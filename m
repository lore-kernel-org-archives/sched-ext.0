Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691841;
	b=w6IES9pG/kEikEOzfvmchNUIEzvmvcVPnI12zACHNrcm2qA5SB48GUbO4ZOI3khLtFxp
	 /eoGof0Fs7i03ETnnnPlrcvwBxuKfqcf1r5X20DyK4eGc6D7Bz48iD5jadFsg6+AyBegz
	 RdPCNFRtFnpLzrTTlGvJ7ktHfj/HOGEFQ2Wr7sy10BihIzUlIHu12ENQ/OFDyIT8xmATT
	 eRDK/h5SZoGiFjwKOUt7qYWgpZJ0GFpOxH0eeoEM/t2CapT2EPhZZANAXz1GscGoQVYJ8
	 FS8c8Xe8WHnhV2/FO8N+GxZwKufN60wiFtM69/8+bXUuTULm/j7cmUEmdQmoM7J/s8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691841;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9b1I8g2nBCpdaDJcfeK1J8xzDDWtKVcykM7pPgp9XZQ=;
	b=kx6pLv0K4+Qn5H4iAnK1t4DAiTIthmWXbJPjRb60enFd4vGpeTXc7E3lhSoKoHhv42wK
	 mpXIRsOlczwKJq2luQOeAbYFISX4mmpJPkaEedHUcAig7jbnladxrLwF7+4KwOvMU9udh
	 zoErajK59W5YLm9/SkrBXw3mLFTSEl9wr8U3gpfaqCLv292DXfqoP/QMXSTEEKjfxRZcK
	 B0UMq4a0bYBuKVblAjDQFz2I1vE8rZB6lDhgGRMWQ8+lO2TCp2s5eOwiiPq+fOAeaKQpu
	 DNwfGw8tr3iqhEVEYpnGUofUOsubomG8ZFWfzBgOuVtoWwez/yA8Xap0P8uwL4ms9lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NKxsrJYX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.4
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028C606A330
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 11:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D028C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NKxsrJYX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV+GEsT5qaRkmV5saQGPktOrPQFPWFSIUQ+I4HTjGfPCkh17Eg0hl2ZZCV1VP609wlISg02AYLWrZNwjaGgjW30Px6JQVFTdidcODFf3M5pGKJGlvkPXOd6RMOhVJX9JqtCUOmgt5CoAKcZ7bTaFhZKWgOy9miI0K2SIMU0C+o3yoWkezm/q02Mf885KsNNf7XfDUKzZt/eidL4BgdBi2TaBkMpSHMG6tb7f/7AkaDXBoMiwWoBwOW2UQPwGE2ah8jdUkXgm+kn1bom2MF6t9UM8hZEjtOwY/x41MAfzLo9lmMsp+G++ZMR6pto9ZEETq5GLUuxBQV7AXwT9//GQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b1I8g2nBCpdaDJcfeK1J8xzDDWtKVcykM7pPgp9XZQ=;
 b=uBc7naTbzYnWq592JpoE6R+PLmu+h4W2NrjsPmf6doKBCFUm92k7dyie/ZNTTkQFZiuCazk7JNrmCHAJJ94EssmlEIUjvw1RogU3LpLCSdobWEiYvFvcNWi0TCQ6XMUoi1DvnwUTevluX7Hh82+TrO7y2Oz/t7JiLijmWNqRLJ+fC0gH2UbJLkSUB1mAQxum8qXrewpxj5B2GDZ9v2O/r0ZvN2LYemH/IDmfodMmZFWM7MKcW8UnIe4IjfBH9ZwUDlgZmJlntbG5ZK6WhIt5GfOEx+hGBq2Z7exUvhGWEi3+eVRBeXpt2BFr5LYPmKeUVyz+Taa//zAKM0jTjxkHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b1I8g2nBCpdaDJcfeK1J8xzDDWtKVcykM7pPgp9XZQ=;
 b=NKxsrJYXhNX/MDtWxS4UfaJkjepHVpX4VrnAtIYGUreTXFRonrTxXbr59244M3XwAEh5tQ2csJc7OiQD9xKg6EsVpo9NQ8KMAEkQlMzyeSmCpPiqrv4bGD/osIBbuUTThbUxmaV1Y3bfUMNGNZ3/gil61viPSE7/ysB/oIm1DmSjEi9XVr/3iXgU2xgJyn//Nne+79z+NLrme6aKARqiHFYIi/oIwR6ThQhk2aRTNCrg9/RPpN2+6GjRU7gU6PZbxHJ5T2dZM9KPhuaoIfzpKavhRXVnWVMUeh4Py1BrSXC/soLzhDEpu9y9SOqPwzSrR4Ih5LtP94dEpi4HUO0SHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 11:17:14 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:17:14 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Tao Cui <cuitao@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched_ext: Make SCX_OPS_ENQ_BLOCKED a hierarchy-wide setting
Date: Thu, 26 Nov 2026 12:13:58 +0100
Message-ID: <20261126111649.208476-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126111649.208476-1-arighi@nvidia.com>
References: <20261126111649.208476-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008D2.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::432) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 576583d2-8beb-49a8-7214-08df4baed2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|3023799007|261022105027099003|11063799006|261026140227099003|56012099006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MAj9J3SUGuof0nXodHMzrm5/nuCl7zT5VFzYVNFq8IFa0yU4le8Dva2st82owZp44Obd8lA9khW1u6YLH/CZtPrFNzh7ROukbm2YK6XLkOxdZ+Rz6KkAmV1C9eZgXXKl7W503+f9HpBVzFsgGYQ4MiIdv9m0p80YhTjSrD9SK4Kqd7kQvIr0AMNK6nEy//uCYMsZAr5X+/31CluCdky7Y9M+HytUkkBA+giDB1/d9iFGFnYmC9XV3/HZ4giNdSPaKrsKgqDt8FdhMW7M6wcm1GxJi+8q8A75OaQ47CjSJ4PMkry/XlaQxKk0d3LRpcsdsjHdxt5Wjcb/NG431lujGnj+H7CF923WB96Ej1uQYyBrK1e02FmJ05aya8SGIsHxV2Hao8mnkCKK0zgdqXExzsDtzcYduee4ZlTkDNOdZQoTfE5KLdFuCGz+Z+qwPhN/9JFUdBvOx8D6Kl8WVUrtVDfS4Mw8btwSGD6rQ+7QQ8PHQbRkwPp8gnvaxG0Oe+aA3AyMCaboix1CUcPhzR3+ronkE0rfj6UiRMwp/gbrWKzIDs99cXtrWERW7rPxwDU+NF8DbJ9eniUdaGVqhPswfBGrYPG3cwhnEk5mv9I2PbDO4l8H0YxJz4hi8hm+LtKkr+8FxPKZfvdolEZT6uHy/Jft3nH70ohDV4gxjCYA1P4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(261022105027099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O53EteApnDkldIUBkeDfQoSLqj395K1BXq5GQ2L4NUPHh4MqlqVGqpFcqxlK?=
 =?us-ascii?Q?sk9eeHa6TZCzQ4TtWWKZTg/rijefArhffWZt5bjUP4Mpr+7sNV1jHH/m/7hr?=
 =?us-ascii?Q?OqnK0aNMgOO2uZE103bkhcenhOPhifna4sUrel4z6tcv7HKdP4JWOf/G6NJ+?=
 =?us-ascii?Q?Ghkh8X2DoEiHLs4peziccciEuZ8rQuxIqrWaEqFP9m4XMPk8IcevRjQdhrtl?=
 =?us-ascii?Q?O24/IUlGW+r9DqUIsi49LEqx0S6UHfPyecvd6sc9eM/Op4RGhcqtLhi+Q7qd?=
 =?us-ascii?Q?V7tKXnCdW917AHIHak1LQD4+wx/WMKgflZiqQ6IBsFfe8FZB1UMsvNDXno+0?=
 =?us-ascii?Q?0CdQjGpdMN8o4xSt1+kzX8X/d3v6hPgZAI4PYpm6RO+9simTSylqFrYmCaPf?=
 =?us-ascii?Q?jpRoxcqM+1t5CkCZeGbefS39jollTDmkS4VGsweuF9ta+LOpxAqIbWV8E9Ox?=
 =?us-ascii?Q?71c0rWlsgHuqRYmvI5u0QkNTPbEl1OOhmDQXCgZ6+eYR7msj1YL/cZ19YnhP?=
 =?us-ascii?Q?0jVKgWaIGvjl8gZo5B+zjJar45M7igFNzSTlN8Xxph//P/gHlbhwD03qGk7x?=
 =?us-ascii?Q?yvNwLv09Zeqk/AJoAVO6Esz7epzoSSbFKiU2v0c1LnJtlpVwBbWnvdGUHm1G?=
 =?us-ascii?Q?/PJQwo3QEt/p+EQ3ZnuwVnJfFmys2h41h+nzGH7RK4sy6Q0vGRkAE8DuGN+b?=
 =?us-ascii?Q?p93kcGCCUaIWhs4RN6dttT00WD+zjSrh0JcROLaXdRG4Zm6u7+vKvhuGUO1f?=
 =?us-ascii?Q?XscnZLcN0P3B4pMlsHQ+0IFV2O7pbY5qSlzk9EoKEglX4PIOlZWD6QanX7aE?=
 =?us-ascii?Q?HckwU6LhIKnqXAqeBgUhNxnU3UqBcC4Xz0eEE8T2DZSllKO2lrRaV7kTNjL2?=
 =?us-ascii?Q?xjeKDYudOmyNyM+QNd2+hBqTrnwMvVPdmri1Vzwy0fLohIK/k8QWzHpnb5DG?=
 =?us-ascii?Q?6os3bpBS8fl7g0R19t+c5TQjfiSA+g/LzBQByxFTmmkKV+VSHJzKPjXHQFQI?=
 =?us-ascii?Q?JhzZPxWj8jyiEBy8ERoVBqIvepL758azS0V4cFjUwuMqA6xe0rrbjZJH90u/?=
 =?us-ascii?Q?S2Whq7i9lD9xAtUJlQGrLZILlZwzUvHmuXKz5/v7Ix13VJIUkFtBeR1BcPfM?=
 =?us-ascii?Q?6adq2I4evYYpP27mAQPw1rttzFIG9DYB8rLgN/r+bDQ9X7yESZgIvoPVhHPS?=
 =?us-ascii?Q?9xzzV0qH7saRKZoZHqiAPApMEr0lFyj4wggMiHIlIzguSw9o/5SL9/u1+/hb?=
 =?us-ascii?Q?qoDH2GsEeP4Fi30O+/94hghv8PI3dlOluYXtDQ2Tlt5O5fBCX+ZEki3HqAPr?=
 =?us-ascii?Q?7vQOE64SxkKz+p3tgOE0O5hdZaKPbf2EYqXLcommQRnOfov+0UjyxCwWa0J/?=
 =?us-ascii?Q?D4T3JEnp9ySlKzg4H9BEz6tKqWWuGsy80Bz6zAekeC2t++hYDunKYCqeJB1V?=
 =?us-ascii?Q?/XqAtNaYmyXmE6eXTGepgXa/3FmXhaqBKZLClqHPXZPJ/oOtbBIO8H8gXLEw?=
 =?us-ascii?Q?00s3OgsMwZDCH4mSxNMpGzQaXLcAhnYFhNWSlPSLmKJSFYCFhYsBToH5JAXC?=
 =?us-ascii?Q?KdVbCZEoDE/7jv5X45RbNBk95dNdUY4xiZ8CUr7i2nY3omj43mdMch6nLgxd?=
 =?us-ascii?Q?Jz2vtEQXfDq/D0b4RRXMcZV1JENCBSRNLFgnaposOS/xun9DdoqF5r8qXZdj?=
 =?us-ascii?Q?JzIuVm5BhLnS2UGTcywj917EhROd1lHZq6sYuKPVYrltVOfn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576583d2-8beb-49a8-7214-08df4baed2f4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:17:14.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/FJjutNS5H4ZK+OxwY5EmaQHgjV8ZzzupN5onQxUgpx9OwFf9gz2jH6UnnYnyLX6hDC74/559pO+iK07b/EqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

Moving a task between BPF schedulers (sub-sched enable, rehome and punt)
doesn't change its sched_class, so switching_to() doesn't run and can't
keep a scheduler that doesn't admit blocked donors from inheriting one.
scx_prepare_task_sched_change() works around this by blocking a retained
donor before every ownership change, even when both schedulers admit
blocked donors.

Mixing proxy donor admission within a hierarchy has no real use, so
don't allow it: a sub-scheduler must match the root scheduler's
SCX_OPS_ENQ_BLOCKED setting or it fails to load. Ownership changes then
can't affect donor admission: if the hierarchy doesn't admit blocked
donors, no EXT task is a retained donor; if it does, the incoming
scheduler accepts the donor just like on class entry.

Drop scx_prepare_task_sched_change() and the DEQUEUE_NOCLOCK it required
from the sub-sched paths. With that, sched_ext never blocks a donor that
it still owns, so scx_block_proxy_donor() and the SCX_RQ_PROXY_BLOCKING
special case in put_prev_task_scx() go away too.

Update the scx_qmap -X help text and drop SCX_RQ_PROXY_BLOCKING from the
generated enum headers.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                        | 44 ++++++-------------
 kernel/sched/ext/internal.h                   |  4 +-
 kernel/sched/ext/sub.c                        | 12 ++---
 kernel/sched/sched.h                          |  1 -
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 -
 .../sched_ext/include/scx/enums_abi.autogen.h |  1 -
 tools/sched_ext/scx_qmap.c                    |  2 +-
 7 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 99038c2f6f4b0..ecec827ad986b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,17 +24,6 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
-/*
- * Block a retained proxy donor, telling put_prev_task_scx() that the donor is
- * about to be dequeued and must not be reenqueued.
- */
-static void scx_block_proxy_donor(struct rq *rq, struct task_struct *p)
-{
-	rq->scx.flags |= SCX_RQ_PROXY_BLOCKING;
-	sched_proxy_block_task(rq, p);
-	rq->scx.flags &= ~SCX_RQ_PROXY_BLOCKING;
-}
-
 bool __scx_allow_proxy_exec(const struct task_struct *p)
 {
 	struct scx_sched *sch;
@@ -46,21 +35,6 @@ bool __scx_allow_proxy_exec(const struct task_struct *p)
 	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
-/*
- * End retained proxy execution before changing @p's BPF scheduler ownership.
- * Called with @p's pi and rq locks held immediately before
- * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
- * is updated only once.
- */
-void scx_prepare_task_sched_change(struct task_struct *p)
-{
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_rq_held(task_rq(p));
-
-	update_rq_clock(task_rq(p));
-	scx_block_proxy_donor(task_rq(p), p);
-}
-
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -3596,7 +3570,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	struct scx_sched *sch = scx_task_sched(p);
 	bool proxy_put = p->is_blocked && next == rq->idle &&
 			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
-	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
 
 	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
@@ -3624,15 +3597,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
 	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
 		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, !proxy_block);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
 
 		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		if (proxy_block)
-			goto switch_class;
-
 		set_task_runnable(rq, p);
 
 		/*
@@ -8246,6 +8216,18 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	/*
+	 * Proxy donor admission is a property of the whole hierarchy, so that
+	 * moving a task between schedulers never changes whether a retained
+	 * donor is admitted. Sub-scheds must follow the root scheduler.
+	 */
+	if (scx_parent(sch) &&
+	    (ops->flags & SCX_OPS_ENQ_BLOCKED) !=
+	    (sch->ancestors[0]->ops.flags & SCX_OPS_ENQ_BLOCKED)) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED must match the root scheduler");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index c20326d6eed84..726cf4cee2c2a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -240,6 +240,9 @@ enum scx_ops_flags {
 	 *
 	 * For blocked donors, this flag takes precedence over
 	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 *
+	 * The root scheduler decides for the whole hierarchy. A sub-scheduler
+	 * must match the root's setting or it fails to load.
 	 */
 	SCX_OPS_ENQ_BLOCKED		= 1LLU << 10,
 
@@ -2296,7 +2299,6 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
 bool scx_set_task_slice(struct task_struct *p, u64 slice);
 void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
-void scx_prepare_task_sched_change(struct task_struct *p);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 9732809c09f89..e5b5098fa1e3d 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1623,9 +1623,7 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scx_prepare_task_sched_change(p);
-	scoped_guard (sched_change, p,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1655,9 +1653,7 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scx_prepare_task_sched_change(p);
-	scoped_guard (sched_change, p,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -2434,9 +2430,7 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scx_prepare_task_sched_change(p);
-		scoped_guard (sched_change, p,
-			      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 11d38b2e18f05..b34709723d861 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -803,7 +803,6 @@ enum scx_rq_flags {
 	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
 	SCX_RQ_PROXY_TICK	= 1 << 10, /* proxy execution requires the tick */
 	SCX_RQ_PROXY_PENDING	= 1 << 11, /* blocked donor awaits proxy resolution */
-	SCX_RQ_PROXY_BLOCKING	= 1 << 12, /* donor is being removed for sched change */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 27b45040c88ad..67aff283798af 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -208,7 +208,6 @@
 #define HAVE_SCX_RQ_PROXY_RETRY
 #define HAVE_SCX_RQ_PROXY_TICK
 #define HAVE_SCX_RQ_PROXY_PENDING
-#define HAVE_SCX_RQ_PROXY_BLOCKING
 #define HAVE_SCX_RQ_IN_WAKEUP
 #define HAVE_SCX_RQ_IN_DISPATCH
 #define HAVE_SCX_SCHED_PCPU_BYPASSING
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index 5cf54dcf5ffe1..18d69aa45538a 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -220,7 +220,6 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_rq_flags", "SCX_RQ_PROXY_RETRY", 0x200LLU },
 	{ "scx_rq_flags", "SCX_RQ_PROXY_TICK", 0x400LLU },
 	{ "scx_rq_flags", "SCX_RQ_PROXY_PENDING", 0x800LLU },
-	{ "scx_rq_flags", "SCX_RQ_PROXY_BLOCKING", 0x1000LLU },
 	{ "scx_rq_flags", "SCX_RQ_IN_WAKEUP", 0x10000LLU },
 	{ "scx_rq_flags", "SCX_RQ_IN_DISPATCH", 0x20000LLU },
 	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_BYPASSING", 0x1LLU },
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 414afb817e0a6..48cedf635d77f 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -65,7 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
-"  -X            Turn on SCX_OPS_ENQ_BLOCKED\n"
+"  -X            Turn on SCX_OPS_ENQ_BLOCKED, sub-schedulers must match the root\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
-- 
2.56.1

