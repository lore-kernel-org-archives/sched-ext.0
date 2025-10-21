Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B51340A4F
	for <sched-ext@lists.linux.dev>; Tue, 21 Oct 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058660; cv=fail; b=qN8CgllF4lKhqd0pR3pG6X2agp/EzTUmkpcwyp1u51WvA4FqJENjDgE+5j6JeeRfAP5dUdH6ljCJVrWW0V+nkNPr8Nt2Od1ZMaiuCx73wGTGloEO2ym/9Au3Hh45sbto0mz/wWkXC1awWIk4QLUAd8HHEyq1dPUlMZoRO7alzrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058660; c=relaxed/simple;
	bh=05Wk+m7DD9ZF6PeYSH4Ry3HZjMQAxHyERym2Hg430aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CF3BcNRVgQJV6tJxxV7G1LOYJNXgec3OxB2PaoFaTjVnr+hMjiSVTz3V2XSlZcvCoYKZxWkf4ahHiHXafCahLZgsE+z/y9aY19C7UrYxD7himpwOcpZfN/U0X8K3z562xVctgxqmvEoprC1PI38JHhIZMJRZ8/NmFCIKQmTAKNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VB9ir/Pu; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VB9ir/Pu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUsskFhTatXuG5YmBEvKizmNz2Np7SKrFWNE5hxKca4SRQ1zb+DvLnJ/yIwS/p+GaKoLSAax/HD+J5M00IemyF9GJ8OvwqTHKjnSnV0YHnnCDIhXWUYB9IW1pn4uSQhTosaFy/SjYQ3Q/VJzqdGRX7+/zT6P5XD4MZ8VXbZaWrV8b0zidvmn87SVbohgygGc+DCAATFnSbkfbv68D8pdrLggmnCt1xjT4+Z8GwMtJsAXDPg0SWO+TFLg6/nWQjsQSuJh1rPl8XvR4gOivhMbi3epZi+AM0w0ffxIo/2MypfCunDRfMvhj5LPU4Iqxm2jdu1r+dADYpmx1HtPveUT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFTJffiZXV2QVAUbx2q3GpLS2Gyhki6Qgh7/B5lXhgo=;
 b=moYQDbBX75ykGTzDjNJHf/IiDeu+aaleR0ITTYsRe+QaLjxujsS5NKKQ0IpQ/U9Ri/TSb87jKmwKHM4or9fyYYib2F8N6WCg731hRGzeQnMSag7elX8Ki65fXg3RxxyDcwRHwl/bK7EdA/pylbI0zwL2bDgC2NwEYXethltIXCFJx5zShLaj2jHO/xDVVoTyJkh3JXZX8n9wpmGt7sOsyypxnmOKfz2wa0PPEOdEJnoQRmooCdqMMbdXINhWNS3JsHAMjkbQ6CSWjq6cg84priTPkgdMNNYv97YrX+ygpvz1zIIh2qCYOAh0DaAuI3ffTjIflC/5JWy9sgy+7JzDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFTJffiZXV2QVAUbx2q3GpLS2Gyhki6Qgh7/B5lXhgo=;
 b=VB9ir/Pu/nZtSH4Q1bL4AoOMUu8XSCBtURJYetUboPpHw2q2hQIkh+WML7R1KTPdNv70UOxLwGAzAQZXT33Caahx1CQs8uTzplEaTRyQCcvrkQZXrNOQrt8oyqYlJKtZRlOUfXzsAJGKRt5GR2QUFVhRigqjrp9VosLCKkJIqp6UA7heb4qiIfcINoD1ZzQDwzbcKXBnzVTvViiAvvRio8k6esjOAIREHgtribNa3wf8aQ+ASmiDv6VVU+HYcvSgyxu11j5yrt0nMPRB1BUCdxhzVgZ5Or9skcx11B3XnZPRJqp1VCnA1BNGLf80VZa3R3KgQIYZVmbnfSm9XhPI2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 14:57:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:57:35 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched: Relocate sched_smt_present definition to core.c
Date: Tue, 21 Oct 2025 16:55:42 +0200
Message-ID: <20251021145706.61534-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021145706.61534-1-arighi@nvidia.com>
References: <20251021145706.61534-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: abf22602-7c3d-49e2-26dc-08de10b22b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quGy7ftkxDqS/80hl21EuXIHff3o9JEY4k3HKaKDYX5HU2MO5LG4xnBxEOe6?=
 =?us-ascii?Q?5f0Ekv5yMl682mLmLuAeK3vhdVDdNtxLir2Is7NAbwECc9HRqYrhiwZ6pEle?=
 =?us-ascii?Q?aPZ28DODGnS+olMyskmtszq3UsntF3lhMyvOcVyWGeRoNcvBe2AJ9bOpALAS?=
 =?us-ascii?Q?ZRdALZUC9bwIT6u9pXkTP1J6xMx5dOkn5jyZghGGY+SuMkBZK4xX/wWvZki3?=
 =?us-ascii?Q?poGbSg+N0Zrd9pHpzImvRCh2BioQb+c1FJxpdIdsIEnCzC+pwSu+UF37XzD9?=
 =?us-ascii?Q?nzZ9LoP2Cs/O6zOTuM9nNKbzlp1oduXR5vetsGqVH9UuoToIAJtEaR7r5F4M?=
 =?us-ascii?Q?l3MwRS2K8f1EVpLiynOClPiOdlupBMGJ1t/ohEzrOEKxINWjhNt0LKJvK/bM?=
 =?us-ascii?Q?LLYGwqOA65Ca1pNWaupkk8h0599YYkF5ItR3nV3G1R/aexJHmEgllX4FA8Rt?=
 =?us-ascii?Q?qPmMuaS/DC1YmllCsksWCuKlQPO4RSwQPmO/pSZeFPEJAvD4wYV6Me+ga2RH?=
 =?us-ascii?Q?02449uw8GxxNGBO+GJoQNxel0XiMYueKSl27Ec7alWrptJY6cB8B9EQZLlbu?=
 =?us-ascii?Q?rNwz1jKnihHjRha6jocJcY9OQPcIJGIUY/wi9CqYqoaN0IDl8zXia7z9isC+?=
 =?us-ascii?Q?NrDNt+XNL0Rfw1TY8dmHMQ1feU6AHm0jIFQ6fJXFTiOjBsnPkVhJX2FejhWK?=
 =?us-ascii?Q?C++D8aeK7vyQcPSJgCCLKQdV7zH+TlGP6RT/hJPCEpCqz3MXiNBEnFzNzM7b?=
 =?us-ascii?Q?owAZhxzgekjxADeuyIQ7Q3K2mhdhBQok81/cqxblF0YcIJgp0tSdm8/2EtOV?=
 =?us-ascii?Q?Ll8zr343SJi9c2wgCa/CHUTlryTu3GlGBptP5vqU9U+qnWR2p276GL0KO5CZ?=
 =?us-ascii?Q?2tr1w8+8kzf2ofOp5vNolVhC+PBvNC41TXiYLecLQnBSziT+R5rRgQ15WZr7?=
 =?us-ascii?Q?fwH3MZ7F7O6korie5zi+Km6redj9WW0D1/8Qz1HdB87PhXxkE292vUa+XhUD?=
 =?us-ascii?Q?7UR/85/GhRs1oYu6/7GI4sQ19FrnNg7+BL14IA5A+8gcvnUWUpUUK1+9ACpj?=
 =?us-ascii?Q?rJUGxs+qDQUUzjR5MZidAflLwnCRxiUbxpnQOf2iGWxHS1d00DK9cQWSlaVd?=
 =?us-ascii?Q?ufMtfCaJM9squfULZ6Rblau/zfrLL+dhuOPb0xNBwlyFURCwnwQn8NTKGHph?=
 =?us-ascii?Q?9FeKjrBth+/6moDxXUylwvrAoYarA7fmmqsncwTuKBWyFJZvv2Z4qidP9mL1?=
 =?us-ascii?Q?SMPT68NcwWCivfYfCwA1IW396s4FiIwnFNDi1tNXDgOWGGw0NhueJ+tbcLJ2?=
 =?us-ascii?Q?QlH5crD+Zi9GxIFir7rAZfd0vg54nHELFnl+HBQy3kBtIstPumU8K/Frym0O?=
 =?us-ascii?Q?ossM53aRcyHXOVdOe4u1KI/aHW4Z7QBrchGAQQTaODZlOyKlS011CuYwMMzZ?=
 =?us-ascii?Q?kONf4ptAD0tKYZi4W1yq0BCm2GyMT3ZH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slwzplHplfngVCMjd8Pk2YF9MNG9VCHfiWGnSxEIe3PKKfbZiCTOZVZevBvV?=
 =?us-ascii?Q?0JE9vNQ/xAIscRjbVqOkUdWipw0ipB29vI3aG5IDwebsBx7QOZ9OFj8xyckP?=
 =?us-ascii?Q?92nl9dqyXmHvEnJGF4YXH/CqCu3lcAMoEuIqUnrNuXehoAykDu2JU9eE+Wt7?=
 =?us-ascii?Q?hIynRNwh/LwuGZImajxApdblHZDL0HUrFLV+bz7cVO9lqp8035I3gqzRv01u?=
 =?us-ascii?Q?wXfeZar26M8F5460sF+29PxtuhDt1vWDSsgI/vTQb77oWH8y1EoLcFEsTpSF?=
 =?us-ascii?Q?1F4eVeN4BgQzRWXMG2chkdsSQ9eCjNQgqo1Z13PatndC2/o27eRdDN/PAU1+?=
 =?us-ascii?Q?UWWS6LrGQpmlUaHUIa9tqT8xq5L6eQezwOpuEdT6H9U1tz2Xq9UWkqG/TclB?=
 =?us-ascii?Q?uDa+K3X8KS+/1I7150Py84bPOPDJry6C0CKR4uOfeZaWoPWC2q8t5yituLN7?=
 =?us-ascii?Q?SmKyiVWelxMuO9VpcRcNceshpTAXqAORt0SXeWxg7kX1PyEDL0RcoSwFwyeM?=
 =?us-ascii?Q?6hg3TrL0sbnCcY+G1l3URmr8sM/bcO/MTzwuh3+EXKfFIhjas8xj6KO532T+?=
 =?us-ascii?Q?vuS+RLRoeFfHAKKC0RCtG51dmXxdhfcJu7f/l/wIGaIMKerk6sqr8SR2HYj6?=
 =?us-ascii?Q?UKV7rcDbKLilvRFKn6X2E0tm6qJImgx6DUTf7XOVEZuQ68nW/yhpeE/jgalt?=
 =?us-ascii?Q?53BX20cizLe3aw4UZMpl0V5xnaXesbNKVs4JjZkwRjjZWFih+R/ScArs0UpQ?=
 =?us-ascii?Q?eT80938mPX8YpjWO8EB97VpRnp5IoIucvZ9OhDs0a1JcCocVsf7rZS8H8uRO?=
 =?us-ascii?Q?tgi/Sds+9375/KyY1Hx8lu1Z6R1k6s5kQfk2+IgcMo8rJaEd7MpY3WE3Df9q?=
 =?us-ascii?Q?y3iRNVsl3dMLp7gxocgqq4VDv696p8LJFh0o0+vcAJkesi+/Tyk3cHDTYRLF?=
 =?us-ascii?Q?n8DzR04d2SSQAYBl0EkpP6rYhF40WUWCQqbaqgzddaQEgCv/dGYMQ/8jvWXx?=
 =?us-ascii?Q?L1DsuSoRsyfnTEZGaqNly9nYzI8Dys/aKmtHzYs8RxaueHxO3hbbqRA2sumn?=
 =?us-ascii?Q?UmFAM8II1z9h1dpkkkVINk9BkNS4ZQot9ch62d65fwagZ/mHnQWx/L/C2ZyG?=
 =?us-ascii?Q?dyveaMRlzB06wmWNsNV7kTRG2gGOI3Y6u+Bv1WWluZATfgKM4TiJjTcVNFXu?=
 =?us-ascii?Q?mKdvWlcOSpIZd6JmIksvF3QSXWjKgvFXpf5gb/grS9Qb9RGzAlHv36UQb2Kd?=
 =?us-ascii?Q?K1wA+64vkJE1ehGq+i4/If/WZRgZzILKa0V1nRY5Q7MbDdRPwbUBt7yVXJ17?=
 =?us-ascii?Q?fMH06LTS9aGFzlsGQicA1Bsq6dkZUyj8y/G8lC8t1m8b82BNIJ5kLM9YY7m1?=
 =?us-ascii?Q?cUGwOFwKSSR+d4bDuZp8Mq9/UR+MLmmnT3Ul1jkJJmS/T9nUPP9WVmj7AWOU?=
 =?us-ascii?Q?TLZJNN7iobzclAMHOFpYwT6Evc3zuAR4gvGxcMfZsVLdGu+j9sxHXu1p/E9n?=
 =?us-ascii?Q?78KMhV4aIoMwe0g5bO9TFyrg0fm0BvU6ETowYtcbeYnesNBFRXQ/pi7MfS6l?=
 =?us-ascii?Q?W4JKN41v6g3YTAmJGg5vz3QDDkL8qCvL8dwBbWbd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf22602-7c3d-49e2-26dc-08de10b22b7b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:57:35.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67W+Jgrtw0G+3S+Ig/SmHNrYQmPl2zhqe1OhVLoezIgNTkipRr1dwdJviEAow39Cmlq3y7XtzmC08UPmMbAvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

Multiple sched classes are using sched_smt_present, so move it from
fair.c to core.c, next to the helpers that update its state.

No functional changes.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 5 +++++
 kernel/sched/fair.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e21..87387f3e04dd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8376,6 +8376,11 @@ static void cpuset_cpu_inactive(unsigned int cpu)
 	}
 }
 
+#ifdef CONFIG_SCHED_SMT
+DEFINE_STATIC_KEY_FALSE(sched_smt_present);
+EXPORT_SYMBOL_GPL(sched_smt_present);
+#endif
+
 static inline void sched_smt_present_inc(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793e8277a..ef0a1bd26450b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7539,9 +7539,6 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 }
 
 #ifdef CONFIG_SCHED_SMT
-DEFINE_STATIC_KEY_FALSE(sched_smt_present);
-EXPORT_SYMBOL_GPL(sched_smt_present);
-
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
-- 
2.51.1

