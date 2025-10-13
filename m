Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29C25783C
	for <sched-ext@lists.linux.dev>; Mon, 13 Oct 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383819; cv=fail; b=eOGp+q4nvu9HdYkDikCahCh9QVTvLiq6LLq/TbUOzSLkbhpWyjjRKgbbmIZ1bZCLoil1NRP8VtVrqo5VLc18OetN48pdhUyiPstBTmBP5glMqtpVm6yDJZ9LS/nSOFWd2pxrnucqBTDvxTqvtIKZgjCQ0Ob95DIDJTAjupLmGIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383819; c=relaxed/simple;
	bh=ASWAk33SDfAbxgrNsZ3D8hAbYF0zVR5PKj/F+NR/pkU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sy4iVmvuvfE+F3j8dkAXzE+4XYErcPesCR7Y9FqAqHDVPyRZ/juFvajjHfjqAUMOrlEs1+iAWPdvovZk3E1fTOUj5CuKdntCem28n4NjYJ/ApYlha/xM0ri9i8fLDrkhezA9iGFNQEHetRCZbBz1Z3VvpkC+3+TbnEBlah80osI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O2vYsUij; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2vYsUij"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kY0tISMCwhLMlCkHFdcdApolwcLU7OVDJKUKytL7B/UCT5BmG27wHZlipsC3X21hO7V0ci+mea4s+gBw19ijv6IXCsWAJRr3B6hn58Qo+Bd+QmzhrQk+4KTRL9f0k7kTRRfSPLdd0r5AQelHzOlpnYUANKbhWQ9SkV09PXTsabWYwGRf4suflimwYqGRvE887PMbk2hI4+YXZs7qYFiSLct9dd2ltJY2g92M7/o8OTidDWYwNKIH3srrRglTPSKxm2PIUNsvvuOoRN4QmV5OybMddJxLrC0JZglIRLtSp9UJ72ecKoGUXOzH/4B4YHs+M4jmZZWMmGTquvbvRtMrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY3dzaBs4Zrdm7e7T5/Bbfyrc6aqaQ2ptgLMtrs7XJw=;
 b=WDEpG3iF82QPI5lqvwIoDBYIrHktUFdcQL/xcYfS0JJ8BMCZW+GIhJHbOF/gdY+YlHRGgXtUbNAskSJnhpyBhC3UQB98NzcR0QhWoDSwz7E7TrqaRDmwOW2GacAlyoqsAs3fyP5MxaMOpgSufcnEHZx2RPXnYiOHPYGEW11N0z7Hpjl4uDoD0bku/VsknYcpRvfLCwfjXV/oRLz9RxOZ/dLsvuutwmSGCXWkkf7eCXUUKzvdxcYJ1D0bjYv20onmxxKsDWvvHn52rk7LWj98tvqd0fEYMkJfVjDkKQv6n8m4kk8Jr4GM4n7pnrt66tTmhQ/iWCS2DLNW9OJDlhE9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY3dzaBs4Zrdm7e7T5/Bbfyrc6aqaQ2ptgLMtrs7XJw=;
 b=O2vYsUijoGRTFfayeCTxpj+IbCZCH7onlEJx5OgXU20EqzKQrrH+QFoMhsYpU8c2v1KEq4IaTeg9G37cyHurQn5LmtKUxxEJtpgfnQo5A+m+Cvh6VdJ1oSQmVlnpO/48ai+I7Qk29ia9MeuoQlQvedgSsox9n3+L81K+lOaFpIgZYwWnWYqtjGWxQdZWGRU2kbiWHhw4nFCPfCRHKMLWx1ALFXsqz7tt/tbxamrUk+aZgB3bUsNr7x9blFK04Qf4vaSOp3yiHmhKJYnuh6uDojAbE+U1IXnHvY2Pzjgul6wpGJjQulTGa11LKE+r7W520kdEZaNYsCp64su1/KyfxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 19:30:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 19:30:13 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Fix build error in cgroup_set_idle()
Date: Mon, 13 Oct 2025 21:30:03 +0200
Message-ID: <20251013193003.36215-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 861c5a6e-db91-43f0-12b6-08de0a8eee68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ypz0ipPlA0scb7wEzEk4AFiA4W8GE4xW+S0b2R3dPek7K9rZXtxMXc2gCWO5?=
 =?us-ascii?Q?XdnQiYgS6DMSNFUmoZZhBNkoaY/S1CLiSCVicPKBVBv3SlaYssoVdkCmqwYK?=
 =?us-ascii?Q?hDfz6YYSx7jvlw7+N7NzAO0B72PS33BBMdQrL1qfCtvGZbI58gTLoys8a0VP?=
 =?us-ascii?Q?ABCAb4FE5gvBq4XAqEA9pHooLFyqvS6ssR5KyBTwnpVTkxCRwqAs7ZAxUOz0?=
 =?us-ascii?Q?20Wh3S0c+hbRY9tU8X1xFX2cSgd7M3wdsnX5yrEu6nIiVSJVPlR5PgsZyGcf?=
 =?us-ascii?Q?xXU1KsBGqoHBKR0rpd6mSLGp6A2wxiTHlaDjiC7Pq8owoVD66p5n4UjPvJkb?=
 =?us-ascii?Q?skEOVCVhtWZk1xd/R6oB74hzVrcB5XbjKrymVOtGTX9AXKl0EWK4OZKBOiOu?=
 =?us-ascii?Q?x5NYWQ2Cnw68vlLwqvV5EQ1zvD26Ti8xaCcgflwOfMP6UKqKNtu3zbPb6Vwy?=
 =?us-ascii?Q?4AbKbttZ8S6CABMHk74o2B/VCQL/8EC8/0z4RPgEFauPrMPrHLQqqII9D1F7?=
 =?us-ascii?Q?BjM3NNoLHYRKuEOQfBl9BaY9TG5HpRrF0GEj7gza5EXbtjP4lmmgst5M4Fgz?=
 =?us-ascii?Q?OkvcBYkoK62vP+1tjKUobuQoFkOei4GlkK29vJKeJ3VKbgduVPefT/Mvj5pF?=
 =?us-ascii?Q?Ak+TQwN1AGhAlSa0Iiuc+VVTw2CZXuBDSVvpagoXlqnlMpfsqVANWmoyNFRo?=
 =?us-ascii?Q?1/rLyPaylm3H16y03QJGZp5IRBVd+H94MLnkRvqf1cyT9Q0A65Nygn6RLj2O?=
 =?us-ascii?Q?XLzh8crupQN8eW+djiWqRLN2ZzYcBFtr9Cjyk0qklBWIkIANQFGU9Jz8WbO4?=
 =?us-ascii?Q?DtJq0z0uMF/Z7z3QVRKb8XQyGEEmvhXEmV67QIYfCW02R7H64Qi012H+F4zD?=
 =?us-ascii?Q?RVYvZf2HQ75VgpmkeatftK8D7gAOl4KQRzSdL87/7L0bFaGRoJN6nWYlI2fk?=
 =?us-ascii?Q?O9ryarvBz+6m5qYjIrob4hLjVC1yrP5GjsUf36FqK/CinxNKSiuGOVWpo1dI?=
 =?us-ascii?Q?b9WUwNfKrotOB9u98x8JGL4sw3Hj7oUHhpZ+6/2p4gVqAYl1Gr4Jok1c5wk0?=
 =?us-ascii?Q?MgDwy8OrxUPfEYm1W73PAzeRvETq/4v1DGyr/UYDV1HZytTXvgOQHf6qUXzn?=
 =?us-ascii?Q?vMQYUftmculDOjedd6TX8bfnv5u4U+m24l+1tcWOs/yovv+IL1nEgTf8dwK9?=
 =?us-ascii?Q?22emMgagtq+Sj8MbSZtx7GTvWaEW9PgKBtdhfpXMQzZXAixSxQ8SOrmlsfoa?=
 =?us-ascii?Q?vqpHQBEfNnV2x0Jiwkg+B0bOb0ipm0F7CxMmDxNZVZLAn7MJaX6BdeCgQe1H?=
 =?us-ascii?Q?MNgoWrdCNUlLLb67HIaMGd9LO/I2ozzLhYvay2FXjuHounz0hAUquhi087kv?=
 =?us-ascii?Q?/BA6OZdaPK3OitxltKU2LjFgbewiczVZK/TnhLsi75j4GJgJ/WrmcI/JeGTm?=
 =?us-ascii?Q?dl516xcdwFd8eKbLXOqc5nQE6Aj4Rfzd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DsHPEJ6ROuxnmflR4moLpkylf3ToWtr0554O1GTttptPly6WpOIvVIAMgWGx?=
 =?us-ascii?Q?Ir7TfCS8zDthqMo8TzdY27oqtySDYTLVV8ryQVey9/M8vft9rXAClSesZ3oO?=
 =?us-ascii?Q?HEz6+YuhP9UpnWlY4G9DHGs4FDjMidVKOhRa++vp9+FTrWCKN01JDIrHii97?=
 =?us-ascii?Q?66aFliF2Y63zDBUTlxAh2w5alj30MWfYk0POxZdhgncROdGhOnBdVavLZZ+M?=
 =?us-ascii?Q?7DAIRazb40wYtJ8bGTQhzCFPdVLJiIL1NDdZj1J/BfvzuZIAuntmTelMhAFg?=
 =?us-ascii?Q?XdiZ3b+/6eNAYTiNzMVACr4EcoQarv8v7eESlhP7uccy+dEOKgdVdprmFsW6?=
 =?us-ascii?Q?EpwtKSXNvnzPH/ARU569yrNYeCg4GYtXoVomvU2Sley01xVguJFcU2zrI5mu?=
 =?us-ascii?Q?j2nNdtRUWHTdF8HFinHQYZsKKqJO2iamFd3FO4Hf5ufjalBH0YLTOnN+0zYB?=
 =?us-ascii?Q?8vuRJMI3kFYiBb2mCIJEKlcT0FJtCtkXNxoM83alnMzmi18PnBMX6n6jrHmy?=
 =?us-ascii?Q?MNdUvIzGcGO50OdvULrT31xXEFhvPEZQhiOPT+rclTDbep4e+G1xkTa80lL8?=
 =?us-ascii?Q?b3xl8LJdj8rgTmcpvDniBuODBs3J/J5gHfVyScobWwnXvoT9Ibg/b570r/Nk?=
 =?us-ascii?Q?cqKYpJNCm8PFlzdaB036jTtfF8YzfzSqC993H2qYo/5DIoH0FLqgb7fWHURj?=
 =?us-ascii?Q?vZPhNCW2jcCF71c1hkZlpPOdKWOBp5ENjUFxsXxb5i1Jdh2w7Wngp4BGgUS/?=
 =?us-ascii?Q?1jJMv8L3UTULt3uRthlz+b3fXuhGJsYP+urClUlSzsxWK4Aiot6l0FVl5OkB?=
 =?us-ascii?Q?BBoQnFpTZgMLGsVQnBz4lwgkLgWqQXwNu8F8CS6ejVdVRrzkquAN08KtNTxT?=
 =?us-ascii?Q?qv53VvBYL1OVkNI7REsVqdilHii9+izITI2HyPCY/2EwrDVrqjmumr6jqkVO?=
 =?us-ascii?Q?y7XO7Im5nTG34Rv2O8/atlV2T4dxCwksAuip0lFWEAnEt97YqhQHHbePzVT8?=
 =?us-ascii?Q?98QSy5N0kYEJ/7N5jgeXnsPuWzUhg9HxjnryZwgvlM3kQ8t9pdIkFyXGAmE8?=
 =?us-ascii?Q?04JfuqdWZINgtnHH6u/O/TZzXktnF2QBovTKh+SSfQI01+a63SlffHn/ntXl?=
 =?us-ascii?Q?btxg9Kyb03bX93V9C6m6WfGsqq2WRkaON1t4mmSSSHLnww24eB7VrXeQoXMC?=
 =?us-ascii?Q?osoypZqTbSe6HmbT5qtzfkfE2gqZJKLnScpmuKwSec+vlziWfQnARcjBl52O?=
 =?us-ascii?Q?TrcVGw5v08KRaYG/dVYamSOn8LJtPyXf5eSHXjK9Ti+rzPMy/5rrUbebCXSf?=
 =?us-ascii?Q?XQuYKciD7PAjRvklYzJ0KVSwml3LHLn48gmVKiKMlxfvJHw56epXBHCp4N3U?=
 =?us-ascii?Q?GAikt2j0U8Snb+Xa9mdvnaH/WuO1uk7q4UzrKYa7nRkNg1QKMK+iW1de1elj?=
 =?us-ascii?Q?OYOtCH+H1CVCfPGXM6Jr/48ZoHSHofUMM76bPEecScoIQr6rtNOc+kxFbFrQ?=
 =?us-ascii?Q?Kh0dexr0waiDyZLTggYhGSon0yg4nbnfmeEXzFAKVjM5RLU0hONzuQPEAe5l?=
 =?us-ascii?Q?Mqgm0A04y/aX3SN4puwg/ACt2NQNS/rBA7nHll/y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861c5a6e-db91-43f0-12b6-08de0a8eee68
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:30:13.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUXfv5u2huritO6S+MweqtNx5yCJgaaxld6EFhyWU/Cn1Pw+vUF1noTbSnEvamGhR8JyjXqYImes3c8QyBcYVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

Commit a5bd6ba30b336 ("sched_ext: Use cgroup_lock/unlock() to
synchronize against cgroup operations") renamed scx_cgroup_rwsem to
scx_cgroup_ops_rwsem.

Update cgroup_set_idle() accordingly to fix the resulting build error.

Fixes: d579dc6eb4fd0 ("sched/ext: Implement cgroup_set_idle() callback")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 228f4faef7670..430749ce46ab3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3217,7 +3217,7 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 {
 	struct scx_sched *sch = scx_root;
 
-	percpu_down_read(&scx_cgroup_rwsem);
+	percpu_down_read(&scx_cgroup_ops_rwsem);
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
@@ -3226,7 +3226,7 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 	/* Update the task group's idle state */
 	tg->scx.idle = idle;
 
-	percpu_up_read(&scx_cgroup_rwsem);
+	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
 
 void scx_group_set_bandwidth(struct task_group *tg,
-- 
2.51.0

