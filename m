Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71631960B
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386322; cv=fail; b=S3pwUsqsIBLTPtoV5BdixQ+5qs3YuJbosBvfHxP1w8/gdivd4CratiF8+srzzp2orLWAjqtEWf9ozoxoGZobI7tLZw0ySYcsuLG6Q46uPrJsN0weThHTO736uwUmG7CZ/TFW92SHmttMiOJ3zFdaDespOtUFWmUbcKsnf3wo3Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386322; c=relaxed/simple;
	bh=zYOEvnGXDs0YDTyg3FvFBoRuMqy0++SbcN4eIsSm0Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UnVJg7MgJdACsT4NXECPZYFjh4MXSkiYwJFxaiXpRc2pSaRcYq0XCM1eC1UHKCufkxB3U1sNgzo+Zn9TYC32Et8QrTD3wXDHTsU9B0ZovCGDfX3YABmP/Wn9B4uYIVLk4/7WG8IvwVX/TxMlptDTCN04Wzk1N5AZR1+5Zyo9KdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oB8e0iZn; arc=fail smtp.client-ip=52.101.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oB8e0iZn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CagnNq0wFBtwBt9izDJLI4JTV0Z9/zZmiii20wOoDHsuOGOgWEXl88yJMOMnn/M5VhYVtbuN8Q7H6/OQwv9YWuaaORCfSd3LAabQvbgmfe/gTaoFyHfFSguqDNltBAX0j7r2Q6U/yHWJPYngRFdD83Cjbo3arVOdAq2dabgEF6L+xQ3bTm6XRd7v4uadEYUtCCshDk5kwlxGuocr4AI2MLreWNFzU9pa/OD8e9JUT+UY8RwnbtjCC6A85QmRzT3RKiIKb4ARKtBvylf6Sn55Qt/OTpL7Xup19pCbtzL3pLTihgi1xNRiE869L2BShfo6nXUMRicpB0OeSivwLqo0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVeBcVUp9eG3vTJOBP16++GWpfzbkHSm7NeqWH2YwnY=;
 b=DISIOElAXOTmlwk2e+dnobhZ4Pdapjwgf/1SHqnck1k6nkKQ0eeImxmi7zc2TqaDTKMdhNg7QE7lXQ7eKGIvgy9xtJmGuO20ThxoNIZJ7+BFb9YZpCPsRxgRchK2FeChAHGvkxi2O+hx+HrEcnqDU2YH7WsXrouwhs0bQg5s4jwvMCJRRLkCs8uqFQ4V+HIh66TAddiJ6mzliyf3/d2r5aaw8W7svsqCqs0KyMYduWhDx+iXrWUFiy5ljf7IcpnXuiHR58OfNvr2KS6TpNP0MasM/QFa8eYJ2GCmzKngrMXFKNGd2HyWbXwjmCuDAq9A+tKLjEbdrv6pzgDSLwklYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVeBcVUp9eG3vTJOBP16++GWpfzbkHSm7NeqWH2YwnY=;
 b=oB8e0iZnJvkVaFUs00PBVDL3rXiWBdn7zryDLmBma/FkCc4n+TKHgyIvTb0rwdih9F/5WPMS0LDeOBtrolKoi53XoY0Dvu0lTCy+9UFFZ6wqZnnFSmMHbJV7tMdQ5EO0pQNyDMwp9UjkaQaKvnqKAjVhal31e/5uCCMDStmgygbm1ujywJdqnozNoCmMzOdyRYB3MR+9PyrbYXyIHqnUg0aGvzUjEy4akpeU2l8XsUN4JaGrnLdowcvx409npkLpWZO71W2d1rmn7wB6Dgsn2pI0HzGrTVz6zHlOCgO5cHsh4zX1qusHrvRPInnCsH1gZAk7itJqbsw8ZMUZBOh3tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 13:58:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:58:35 +0000
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
Subject: [PATCHSET v7] sched_ext: Fix ops.dequeue() semantics
Date: Fri,  6 Feb 2026 14:54:16 +0100
Message-ID: <20260206135742.2339918-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: e86bb4d3-9e79-469c-fa86-08de6587d1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zhB1v2MX08CTxCL3Ko7VdK/Spiyph58b3KPeVVPqHI3Jvpd3wzn8M5ZmCi2M?=
 =?us-ascii?Q?+BPwf3qOMv8D2cnPE/icb58xO8/bzyE2jraQ931H1znZGk4IBl2Z8hLSPBq9?=
 =?us-ascii?Q?yvEywGSamACCv9dbXVQhtIUgeWckL+LYif5XKfwI/sIlAA8bgJbXf8nYub6O?=
 =?us-ascii?Q?dMgB1B6K7tGU6iFmCH7iWIWbGiop8X20MO2K1bqD2YpZfrf/S/w8Qxgpjua8?=
 =?us-ascii?Q?H/q/bgr4E9YRnLUyosfkJvVcBC6DNgnlpeuje0mAo2o6Z2af8Aec8TFq6RM0?=
 =?us-ascii?Q?kY2EZZVJmMTsNqCyRTyWl5bgJWfcY44vYz4aKx+CCQteaVBW4g8kvj8Y3qFD?=
 =?us-ascii?Q?DBW80yLtw10Mu3J9w0yEbF8FzdG/4iCt5qQ7kIieeNmWHoXl/K+B5WE9wXuR?=
 =?us-ascii?Q?3dPsJgyGqe5kDh8uIr7lqTmSRE1oohuDVFp/8txZgzZBUU7qwgTSSXEZL5AB?=
 =?us-ascii?Q?kY7vaVVpF1hVzHE/SGoHxhjH/voP+aHIvXhCbRloDaDu8UwjKOVtpGvdDMvS?=
 =?us-ascii?Q?XzsG0kiDfPTnZKMtU3RHv/Ry4Av5222EKC3bhLKct/l+BXsQWRlU0Bbkn3Cq?=
 =?us-ascii?Q?fTAYaEVJwg/3GeAKU6+XLG5bP6FKKe1JShV92rX8Ia/2MHH7FJkk/HS5TW6T?=
 =?us-ascii?Q?cOphALnZL2k6mEHiQD+tT+42uzplHB1YsYEUFfGTna+9irlVV+ddzjljXbxb?=
 =?us-ascii?Q?2muWf8XuRuftJlQIzKQSQUmqFaQ0aS6mgwg+rsjjr6iWq9qhmJPUfzIPkzyi?=
 =?us-ascii?Q?EIZctRIOL8S39CPzSIqdE4ZVBfdZoXuUbROz6cn5+Zh3llQQ9K6dEcuEkVcD?=
 =?us-ascii?Q?p0R2/+vbvU2GLN+TiL8JFfiJayZGZ8+Unwuh5Uy3XTrrNa8AnkCsgbM3TW58?=
 =?us-ascii?Q?+2xP4FjmtZHtyHAlAmC6QCyK7XKb8QNb/9D0g8l9y0MaMiYt1tFmj0BJoo53?=
 =?us-ascii?Q?SHQe/nyWUO+S4rRI7DE7FJegUPKTnxJul7Inw/y6H29bJIylz8MXoa0NGGzJ?=
 =?us-ascii?Q?l3mKOx2l/cCWOokTQiOwJtbu868APG1IrblJs3/Rf4uEY+XcZgBY4ScF/zSw?=
 =?us-ascii?Q?v4WS0i7NZlUTqDTUVGt1MLy+awwVskLNfCcTrQE7qv0fBvEqPJszpfxH0J3L?=
 =?us-ascii?Q?ij0UC4O0XXIseqeK5M6rsKPlql0g1LdviWbvWk0pHnyIASLNDTLmTbcLHs6W?=
 =?us-ascii?Q?ZhCNEsJmUQQx5sRYCOkRxexuxn4BM6uJA+8PmpM9+Arj+6PjZbTlDSqHUfXc?=
 =?us-ascii?Q?5lCzJpY0p661rm6lk2VjiKPsf2wQVGavsl0zQUNJsMEOMnbcB2CriFEMoHGx?=
 =?us-ascii?Q?L11AUMkXi1N742ejW1iOEWIDnRkFMRO1skdOQ682tXrxsnG9WUfT36oyDWAi?=
 =?us-ascii?Q?gr9f0lJ/JBjzEN+EtloTWme37A9e3djg+UsIphVFFaCFEwn+6JiATNOZfXcY?=
 =?us-ascii?Q?ro1FBvhXbr2PsykjfCt3PCEtajwcPRIm2B2G6nz/8xZO47+0F94zO3DMEUx/?=
 =?us-ascii?Q?DwXefTjRX8T2kXSCfCTVDSfLCCkw/6nbAaXomLRfjedN0ShOwwm2/KQkxZbt?=
 =?us-ascii?Q?rbTDLz+Pp29fZGVNiyJ6h4dR+aCBtiWIrRP9vv99?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9wPqD5VdTHEiFrn4/FN7DIAk13ybdOMtMFPv++aUrdCa3NdGNdjcZoSBnmZH?=
 =?us-ascii?Q?YNM+Dq8v29CcDydIzKnNWJAmXzoZPCcqpMowBUv4mf7JeYjXkh63V0LmVkAY?=
 =?us-ascii?Q?haafCqZzHgxP62JNYi+gWylUYorN3LWjJJV2Rmernt9PQakbAY92SKuGYqhx?=
 =?us-ascii?Q?YXM0F8UPeahixTbfWaSPvg52Gcg1EzAukjgHvPXW2KTbZzWOxrx12IhwGM0j?=
 =?us-ascii?Q?BvLhWORooLCipHVbne1Q57YNxP5cclkEskgpw+fQywPOGD8RMLPFo3PpfPf3?=
 =?us-ascii?Q?r889tzsa9O4x/muYNoPkGW0Jtv83pB7DsUOavPX+GzyfCX5oMUMS+wh9e65w?=
 =?us-ascii?Q?bY4UvS92QZ5wVn/gDtyS4J81QLzyN27ZxjiLzxUB4WGIXjv8K6j3yhjG+B/x?=
 =?us-ascii?Q?edJh9uP5nMueoB5m9HYu6Mm3gw6emiXgDSxNwrWGHlO3l72N5sSGp8QY91Zj?=
 =?us-ascii?Q?nCAX2uc2SmGQHnFSGlPlkYmmOnsXfaizZPrH3KQnvQsDa7YwDd8VsG4Atdpw?=
 =?us-ascii?Q?WIvmX21UWkhZs+6TNwbYL9ZJpRjbde1XghnhZWNmiqvgzjUxYexY1O+YsWOE?=
 =?us-ascii?Q?yJOcMCxEYo11R41o2A6XChiGx8wHIWIvLQaHW4k6qQzcIDJ6MTr1+mtYFmHn?=
 =?us-ascii?Q?MFEe3usUHsmVyS5bxQ0aAkcYPD7zdg63RqnPmSewutS4XjVOYd+ZG8KdBP+k?=
 =?us-ascii?Q?+yKusTBbgxk6Ydpw5aqGyVnjcMl5tc+n4NdAizMLZJE4vPwqpGi6cCxAlmVC?=
 =?us-ascii?Q?+GegPzyXOXD6gA6JjEvezomUviRvTH7a1g14+anbgC5jUOtisAofYyD6FMaE?=
 =?us-ascii?Q?/wYqmwOs+L4Fh5kq5J163mqWMBAShfsxhgFkkQR2opAHehPCQEJgSjvm73f6?=
 =?us-ascii?Q?aYLGP7TuCfs6noWEM0LG5r0387Obr+Exh2zGcNKcqdzKPLys949y5HjZ9J+m?=
 =?us-ascii?Q?VYuxtkd0Yqqp3kC5+sZWVT5LG5s6Q4caNHlsW6bX+c/VMhBgEr8Fdorxjjw6?=
 =?us-ascii?Q?UzEFoeI1eZzmsvjwIJ+Mg+jaK+bs7OVwO5vXTzNYCWoOhzxhIz67Jj2Fdf/I?=
 =?us-ascii?Q?gHQ8MTN99Aafzu1/+ym2xabXtFNn3RThfVBJm7EiO+x4I+snHQMlaLv+vQyP?=
 =?us-ascii?Q?8/NwgKpZNVJUg3Qp110YFnpF0vbwmKW5qeSusxuKVyBvYfbM6Z77IMnriUq5?=
 =?us-ascii?Q?tS/JOS3PY0H3Y0EGPM085lAQgSKJ/pjliL2ShUS0IXi9lsjF10+yavyo+v90?=
 =?us-ascii?Q?k3+lnHHrY79zuwBFeX5suyVecEI/xcEJbiKZc42XEUHZESU0KWEuXwyt8ZXj?=
 =?us-ascii?Q?nqAyumaWaC7RsoRTavrXFNv9gE3qB3ejJTIkFSkXY/21U+TtjaCgll7kbFBt?=
 =?us-ascii?Q?mhJMnd4mCLCTQ3K0sV+5BkUDRlQOLZxpcX27YXQssA6oGtk6XMhtv5tX+1LT?=
 =?us-ascii?Q?60g7O/sZR60KaNg+x25fjo1sQY6ZjrYaBVoMKYsjh1bp0r72vQX6qEZotAhF?=
 =?us-ascii?Q?nPu+vYpCldBwKGs8mjgjG61rpeWVaLaWKhnjFbxcId9AbmV1nFM15tUwvb5F?=
 =?us-ascii?Q?5Vgeq2a+UIxO55E1neeQK4WDMAjYqleATpP550wA32vcdnoGtlZU1ucYGau1?=
 =?us-ascii?Q?7avr6Y1tdL7fO3Nb188rIeSJUisxLfxZ7p0MavffYSWSPKSx4E/jgZ1wyzHb?=
 =?us-ascii?Q?5R7PGNkoz6b3ESHfETOs1OzgWH2WcTXYYh0i8Gu/QupzrrDX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86bb4d3-9e79-469c-fa86-08de6587d1d0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:58:35.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U3aBZsAiRMsjayhiKTEYuiAgZvwy+FU1N1SDiWEIbjF5Fd8XGpTmzjhzqUi5zrjrZYWpc/e1TvqIQPGSZGbQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the scheduler (whether for
dispatch or due to a property change) the BPF scheduler loses visibility of
the task and the sched_ext core may not always trigger ops.dequeue().

This breaks accurate accounting (i.e., per-DSQ queued runtime sums) and
prevents reliable tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), by guaranteeing that
each task entering the BPF scheduler's custody triggers exactly one
ops.dequeue() call when it leaves that custody, whether the exit is due to
a dispatch (regular or via a core scheduling pick) or to a scheduling
property change (e.g.  sched_setaffinity(), sched_setscheduler(),
set_user_nice(), NUMA balancing, etc.).

To identify property change dequeues a new ops.dequeue() flag is
introduced: %SCX_DEQ_SCHED_CHANGE.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

Changes in v7:
 - Handle tasks stored to BPF internal data structures (trigger
   ops.dequeue())
 - Add a new kselftest scenario to verify ops.dequeue() behavior with tasks
   stored to internal BPF data structures
 - Link to v6:
   https://lore.kernel.org/all/20260205153304.1996142-1-arighi@nvidia.com

Changes in v6:
 - Rename SCX_TASK_OPS_ENQUEUED -> SCX_TASK_NEED_DSQ
 - Use SCX_DSQ_FLAG_BUILTIN in is_terminal_dsq() to check for all builtin
   DSQs (local, global, bypass)
 - centralize ops.dequeue() logic in dispatch_enqueue()
 - Remove "Property Change Notifications for Running Tasks" section from
   the documentation
 - The kselftest now validates the right behavior both from ops.enqueue()
   and ops.select_cpu()
 - Link to v5: https://lore.kernel.org/all/20260204160710.1475802-1-arighi@nvidia.com

Changes in v5:
 - Introduce the concept of "terminal DSQ" (when a task is dispatched to a
   terminal DSQ, the task leaves the BPF scheduler's custody)
 - Consider SCX_DSQ_GLOBAL as a terminal DSQ
 - Link to v4: https://lore.kernel.org/all/20260201091318.178710-1-arighi@nvidia.com

Changes in v4:
 - Introduce the concept of "BPF scheduler custody"
 - Do not trigger ops.dequeue() for direct dispatches to local DSQs
 - Trigger ops.dequeue() only once; after the task leaves BPF scheduler
   custody, further dequeue events are not reported.
 - Link to v3: https://lore.kernel.org/all/20260126084258.3798129-1-arighi@nvidia.com

Changes in v3:
 - Rename SCX_DEQ_ASYNC to SCX_DEQ_SCHED_CHANGE
 - Handle core-sched dequeues (Kuba)
 - Link to v2: https://lore.kernel.org/all/20260121123118.964704-1-arighi@nvidia.com

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DEQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  58 ++++
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 157 ++++++++-
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 403 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 258 +++++++++++++++
 10 files changed, 875 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
