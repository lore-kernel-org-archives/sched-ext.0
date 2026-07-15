Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D73C872B
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149061; cv=fail; b=KESSaa1fTqVjrPCgBIc+j08OEg9O9qUaumpBlnw6WNaBTZ4lPSklFYPQU0RlYkGcM5YNaxJoUh4d7LAiqh3DQw08kBwLI2UQlgkwUopphiUMnTtxmj63CB9bkzTW6NIsns7yXsggaffHjoCiX5/6447oHC/YME0SUrPhFaxDHWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149061; c=relaxed/simple;
	bh=1FdUVfSt4RQISHefca2TB+7NxXrzIsbbaqLvHILldGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvklPU3Z974AWuvdp5arse4I2xJXiktRZRFGpczXZBP43fFPktqvcvCkSBZrXZrtPFajSjLbkgGQftnKMmuhJXpNWB4yvBP5Z4afaDyW3MPuE8DcqQVkSZou8wQ/0iBGcQVp51Ob2v2Zxp2x3dPJxe7515bLvQLF0C0nQ0kulJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X20R+K31; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X20R+K31"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I718Y194b0pwDbVhvux4Vrw7tM1VTLSMGbFSJjUGA56pWT1P2Gd9Q/kqlY63OSzbmYIkS4EZOlc2YFLTZDZQGD4LJf6pPiTVos+jMQ+BlhMBl5ntM8raNpWvsp/T33RmMc6UlhtA75B9rLNkZmV3cDjMhSC/XoVP0TZSz+fjDU/iyPPkt9F0VU8MlsoGmvMINTyqTFllaCm/2NU4lDoUrM8iouf7mPYhhyQEp3ZjyJNM3pHp99Wn9mIxyjApW155U3wIwBjPeTZiNpufcx2XDK95JRAPQ9OhD5EyZKnW5+8iAUl2BPpT6ZVY23DgPCtnCpKMXUNzUdk2cr/cN3KFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=MY9HenhmzYxHectNZ4mDY+frTFn42HiBnicawAOaRdbchzESFr+O+qo7EBsCl8J/WHEfzknNBSsjjeG4YpPLBhWzDg7FpyGz+sywB7FC8vymKxw4VJ/XJAFFJG5CBBSWFZ0YISmMYqio13R+514QKtwQBCWLjJdTCq7PJk/BOoWyD9gm4hfYwQpDq9QaTCFGci4oVII3OVYFfRjbh30Rr9Lgd4G3xYPc5Qq3nP79fxO3gK/Sw4OvmzkgFnI7X28poP+DnWVF7YzPozdQApfcdixg63wnjcWs0sC9hdy4I+oBN3lj+TkE12rR1vMmGEDVyhJMv9Gr0b/ukj8EI/Yk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=X20R+K31HmcspSlaeDINbCV2OWd9NTd3xIISsrf4O7JLmJiTPuzk/JDwxfDjQ//bNaWQnuQQyWK2nZZkdW7Wu5aDmrhRu64So9A+1PnB6BHLgGNnssZo3ikFwQpoE2CQs47Lf0H9XNstu4vn6X3CdfrtzpjnYjXUixOlm02Gozwcv/yJXtKrVJ+mcjsjaRVoyfcyib1pwvrJM4+jVtWtivtYvdmIzEX6BfhL003U92a6bjK4KKr0ZEbt8ArpmPYN7zxCX6xKgolXmbfceq64ghem7HqNlbGEFAg3WPDL/tUu20SG/B7eAksgqRBdOuH/QlfVayIpBGaAa7GpCR/Wzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:57:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:57:33 +0000
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
Date: Wed, 15 Jul 2026 22:54:19 +0200
Message-ID: <20260715205622.276220-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: f567595c-7b43-479d-58be-08dee2b3b120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	B9eKY2bvpJprIALCjybvAvIZqUjIfsa0dW2yIDdpGkvrzbtSb7XNZyCU4PJ0sQOZZdIlRkAkogG3G0AYe4A0KuaMy2BUAQ+nEzEpmYDl7genXuOtvNhOWet2/bhC1iG4nUYK1TBBkbUrN9DDv6W5MJbENn0mlJZg9dG0Gc5ti+oPIvgsyICI401aWfsGHYqYIHIrHZAluCTOvAQsfsFG2vBFRejUWW8aqelLjbLUkfjBSwzBzB8xXeItohUN8YxgETABAaD4RJVBc/MO92nhefG7NYXgHgBV/jcfMbAqZ1a7eCXeRWWqy/KYlh+ZfrWgFO1GCoYQJBHzMRAaQDDUSayGk2g9YzMJARBmLTDYOaz8QMBS0m34n+/+bcCJz5GCJnOad6srWLr+kZz0qav/0crWwOftKeHkPKLQsQdqxFKcWZ6CPNmlG8Ai4SzvHzhPCJNS1yrrXs5niwPZoutzjZUMg+Pbw7/pfbYctBtcrrJQGFdRw3neBP57z3lPYR+XzdJVpPANXWrT/c1fwWU9noN7/EKjTmGloHQgI+Ts4AtWFbO0HuT2ftRL1af9Pah1IB2lYNKZdzYBu3zmUwnwjRd+4tE+mGmByaUxRei45gsTnStql6jIUq8xIvTZCOk6ZdQ4EiCIH5Uwuv3njh06nddfYEVFrTNTPNmSjRVFcuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nx7jTFT0fL0fl4mbTC4t8pGnC8cose4GdII+NjSiuyE9nVCOrbC1VEHcNT93?=
 =?us-ascii?Q?defNCLYlNpL5G5orx7a9C2izUSd/ci9vTSrhTFavWRwFJVFL8t9hUXQt3kWy?=
 =?us-ascii?Q?z0ZNG3aOHiZ0voqA2XIHxQ3NHoaaShGR8P4gMoFnVCCDc6U1uCg9MjHAUpe3?=
 =?us-ascii?Q?+BqX8suIv1IGm7jEEKnoYq54uEPnhn57U2uIm5ZD667b6wzTtw9SO4UE6z6Y?=
 =?us-ascii?Q?ii1bmhlssuc3wogf5rcB/jF9vBRTHg/7JZHp1f34yIkW1lXOG5CCbiAsAlzh?=
 =?us-ascii?Q?GLxn0VyctjwcIz6dkeruKdtoFEpWIsfU+g62KYNZCE5ltkwPDsxtSmfdMblP?=
 =?us-ascii?Q?T9lrgFx4ghDrijXgxlyGMctXyMtR5sTS0zYFJzmse/le72xUgzauw1kbHsmf?=
 =?us-ascii?Q?W6exRzXS+N2Tx5aGd4i0nhOjuiXeM7o8Yz5i/uyxNjfZ6EkGVh5zG+Fx08gz?=
 =?us-ascii?Q?8O9oe59Co/gs4BU1mmg3mHqAqdLNHO0Y/tiPV2tsuSMpEx5IrmKskCZDHWU8?=
 =?us-ascii?Q?zjyuPlms0HUWKHwA7pP0AkYHw1wCovSHZ49tBWLiC9L6z3zSfdHDxl53udIu?=
 =?us-ascii?Q?Gw4ctpyyUO3XPoAj5pNSsEcTmq0V5bcHWcYZOq/gCJDQ4SQWfsvxJNW77ibE?=
 =?us-ascii?Q?brzFjK+meHXKI74X0/lvRupDMmq0E1WUtEk8Kdr5IZDqxJkF+JN57N04mgSQ?=
 =?us-ascii?Q?u22s7oNy7XSfOV/D0Pmv/1lokIM6Zwt06n1RoGb5lGHNDXVy7Lu4qCjRIgXf?=
 =?us-ascii?Q?89AJOklXCHwDBePq8+3/5FpqTaDirzxrKkp9rz5XWXr8rsXxc18aG8TRf+Ef?=
 =?us-ascii?Q?fNoDq2i4eQYSx/wb4TKQWztjgSyzFR53GmXEM7+5oLniAK+KVH/wtynOPNrE?=
 =?us-ascii?Q?KE4T2VeGtEEzRov4FaYsurx4jW7kzQNHApQ7xIifGiC+A3aPw3INHfsHQOaI?=
 =?us-ascii?Q?YGL5ope9p0C9jzgNbMOF5/IrxET+bdXlvVQIQMFFP5A6gWVecZdRxmL68lDf?=
 =?us-ascii?Q?ipB661OY7qI3qM77vxtYYjiqhd5Q3ihARfQMMce2+gwPe5tto8aKrh7aTHl6?=
 =?us-ascii?Q?kqjrQiEGpHs/dEzxtPEE88MG8lPiqoDashi2+ZhPlOfJ+ACzyRv8824pkwoq?=
 =?us-ascii?Q?v0Fgyc+ptowg8AZxDXNNYaP+fPN9gTmmvS5YS9EwxflJQqNQIGLJnVZs5Fax?=
 =?us-ascii?Q?S6VIv/Pmh+tJF3zQvRo+aeslQUEs65uC+a3QuFzvbzEPgPyYlVkp5IJIPFsi?=
 =?us-ascii?Q?9wEwlv3EKw5jN/9EOk84AvTZf6T2X0PqBvZjkfsvgmI120pxHAOHKYsMEMku?=
 =?us-ascii?Q?dgra1rMT6pk0l+eNKXxkWUkR8t8k6j7YwgffL96a5uIS/PsYfNzmt0BJ5hvo?=
 =?us-ascii?Q?Qexug4yGoKCqp3CUJHjFOTL+ZmE9VAoZ3QDoTu8S397o8WQVNXeq4oWfIgpY?=
 =?us-ascii?Q?6zzxmf+t5KvwF/7hO2VIfKuwjnshFjoZpGgpygRZSKTYTZcRmnVBwI7zeV8y?=
 =?us-ascii?Q?yURUSXQ2dHV9s29Y1wupBXvzen7UFThGIJZeOyfWaMDykMdyFy37P1LVK9H4?=
 =?us-ascii?Q?+WDjtpf4xHeDZA392BJaf05ejEZIdRYaetJrIabJlFRAwzG/reJaniJ+A3Bm?=
 =?us-ascii?Q?0bj33VlPdyI4fgpEjRXgoIao+Wbu+aWTuwWvZTGQFaCH6gRBtTrMYA78yT8v?=
 =?us-ascii?Q?FE3BL5NUA/Ep/ruY51/iEwR+CpN3D7p9pmJ1AXAjjayVrE/ZfnmkaOAAY4XQ?=
 =?us-ascii?Q?yauKN7NAmQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f567595c-7b43-479d-58be-08dee2b3b120
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:57:33.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIz5L2FcJetWx942gR4qDJLRUlNQnGh1Rl9XT+++h0Y6tXkT3f4bduim41M+1/xnWmp888oaYLHSeZSjimthdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

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

