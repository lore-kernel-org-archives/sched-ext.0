Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485894;
	b=QObVgFMxH5AZIYv0oagRyd2V+a19ZadaISkgXwiNEDvBlLGUSdHaXe7lC5FMxofhQnib
	 iatUiJn47pAAnp1SzaF3ZAV99iZhxJY7znLYaEXl3i8Of3hsNWgB2xS2U3UsC3WJvGE1U
	 q/O85FJb5SdEfCYBFoQ9jRPj2vTWOZizGjWzLYu+pUu0gCf+8Y2K6v2/mbWRqUtdfdxCO
	 0IBbJw8JY9JQ9zRCDr9vzjmH1VIi9NDCeKvDUqIRRdDrmkoVeMubRiON/YDSIEpFRpkKp
	 NJ48l2/skPtLX45V2UBxMfUFbeIdUe5e5vIZCQJJr6y5wocu4zRuvlcEnLPLqVIik5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485894;
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
	bh=+lGJ6BADoHgdKMcBI6uAuyv4TQ1R+n8qZXhWOmKkMW4=;
	b=JcoYlGx9SgGyEe8EiVbniDduKW/N9gjiomrqdqZCG6QYiKpkxlA5ja14R6c0JdsXoed8
	 lquwdOYy36pkcJ34OGoPCOkVu6kgDfmdKs+rKyEakd0Q3cCiBwn35oigJ/J2tulrYagkm
	 +2ozpB6wS2/8TCg2qXj8ZDUxeqg9I7SMpZB10/0cxSO4ZsuMFz//RMEs/8H2xYC8iWJHj
	 21NoabYdl0QPSKiPMbYEDf7/h1Jz6JTYfaBk00BCHc+19HQSP4TLRYf2KuhOKUbYHnwi4
	 /HUwHxq5J+iqzvB6Z/taWNgMHYi7VpSleuHRxNzZlfFLI90zOshdGy9XrcXz5sP7FNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XyVqg6OO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.37
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027E60A2602
	for <sched-ext@lists.linux.dev>; Tue, 20 Oct 2026 08:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C027E60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XyVqg6OO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS3MxckC7DqK1RUwITUcwqaqZv+EyAz9GVcbFNItNhHWjIRiOw/pcCDJt+nSz1xx3nm+ZbvWgBhzb9+2cN4aNBVhG/h5vdF4mKZT/JAbBbi6ffHdhgJfNZMIE340HNWEpiCcBHTygU1LmajHm/rEJ1pGt/DR2Ok2P5uzbaTlpQ4Qt6k/y7zgYqrOTjRRoUKIwkxgvQ7Ig6s7OHSfbuJ+kSUX6A8XcJScdARe6cmE2lwIYwpMJeS5Yv+VN+DPnTpdTo6zhSIMtQaurVI514VddaAEc1oBce/NKO54mAivxIgoP28O8gZ+1iVFfMGuHXUynjfDyR/9/xoXOhA8rhoNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lGJ6BADoHgdKMcBI6uAuyv4TQ1R+n8qZXhWOmKkMW4=;
 b=OyzkfY7JwmHV7uNeNc/ENA1L9gV5Do6pau5bnBZmKSG4K6M+4S2lrQPzwSbNWBJ7zdGOvHSEcJXgb12fOlBb7H2I8NBLJX611zMwxz2LV8tjV1AyI9KHB8MkCaHnvOpf3rrPorpLDbJP2UgixbF2rz5DPE3nctNTbFI4+Tdt32lVqU7nAwmnRDF4aj3hKgeYxPk84xtamyAL5eFtAS8kjZEd5ZvxE1AMGS2mndZWlgEhv13u+dJHjW4XzWTUKEgcUOOlPEnxJEqwJaeAXueuFqtLeqBzL1ApLuYJmKCLxW7ntxtQi/hDvfjlE6jHGVxSHE7whQdjrxfHrb2FAMsCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lGJ6BADoHgdKMcBI6uAuyv4TQ1R+n8qZXhWOmKkMW4=;
 b=XyVqg6OO5OxoPqy91tVFcuU8+15q6TUOGGbJ/YDnqTLsTdjarON9bP/m8WgTKkZ66Q6oKOgztP7XHKBKB+KCMWNVZ0FQm6AQ0Drju6sGntjbbA8ovDPw929noajDrAFrUFcA3dKA6wYxjBziH2gjzpQMRzKnlyJ1rRj8YuNsqf3Cj7r9ngJnkIZs0Y21LiMOR5lY3lr43KhRShQoyklmJIIxeIm19Uo8D0lboZ1lVjKgvM67BCDM0daS40RHouvJ7VQfG+vUelEKjbYr8c/p4/OGxweiuHJ/qD15kbjgkNAu1MRGjHNrulzv10fXZnppNnbSPF7cCCfzcBBky4PAoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 20 Oct
 2026 08:44:50 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 08:44:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Fix proxy execution balance callbacks
Date: Tue, 20 Oct 2026 10:43:18 +0200
Message-ID: <20261020084400.845842-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::16) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6289b6dd-8e5b-4fab-7457-08df2e86671b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5XCff0URnjwTC3w59vxzxFKZT/ahwnWiSxep/8GTEERFJYmeHsTG9mAZxJVfiAai9jKLYeJo5r/LOEE8P1xp1iqT9NW/8jObXnlPt3hwxI2O8AcMrE6Daci+4OBnsxrB1+tSjWso9E976gsTj1/2W/fSQDo4sr+qqw0lWFzLIDxhUro64c+QZCnyvxVJR53zY8zeGo31wz5mBHo/w/CTptYAUzULTbjZPnn1x/mDg8hrd95LOeIOUOsFkPO6/gciLL+C5F7m2CIAeqwxXzNuN3Qk5ZybeX/GD5aqdhKTuTDyPu2oxPhPdyvma5X1TMot5Bvw92WrCtaI5xzbGW+aJcQMagQqkDup2Y2sk8hZwzLboEC7iw9oaHTzzTu+zq1HDNSjMsM1EurDNeOXu0ahctfiwdzhyRrV5uPwkhn7lneHsY1+TYsUNwsmpttdqrvUw9O6yHHpk7pVPb4R/yWe01fkjRNjKgdHnXxdBHC3AiFG6upSqpupxiD0d7Bzv8B7WbhN+fUeaYmRPlhY4YOfBUPYst2AITYA8NF0pPW2SCKaZKVz7d0OqCebXiQy+uge1wpsGTMFJqU2TlBXXFtorEMTgav1AKvSJZmc8JMBfYdRe0oJRWH1qWv08R400Vq4NSXsRmNq6chuTQnEACTT0fnujDJbkXyQTUNsjuHD9G8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iatw0Al/OchiWmF5T4KTawwIsnMBMrzSwC/0mPEEWBgB19TR1kghFNoa6jkq?=
 =?us-ascii?Q?iLLtsaB/IcO+2qhRvb+pGgLjdZusyVpyi6An1INxHcddWrTaz3C1J6K4+Nif?=
 =?us-ascii?Q?t/K4QxUkeCUu6DuhFx+2zVkKhynpmg0dsaQWqtffs07k8OzrQ644jwB6LEhN?=
 =?us-ascii?Q?L2KC533sltu0SDXyRP/KNpvHhLIz3gcZji0OCNSzxNkiPffy79LFKoq00uDy?=
 =?us-ascii?Q?Utj7fBVO2ResmbBhMhumY6gDxKsOaVk6/m+0XB/Jz7ogiU81K6VsoL9IVVTX?=
 =?us-ascii?Q?OshOTD5PhxVbPJbT60yedWGOBiR6xAsB6ive15XPKvpkCXmSmDsIHLew/FkP?=
 =?us-ascii?Q?nOq6/ArOoqAfOSgsQBBz/pfO/eIVJocxPPyRmuV5t3c0wGnB5SBRxfbAvsf8?=
 =?us-ascii?Q?wgsiwe19TuwThShQEO1hhTNHKw68q8sMszmaXMBzSGJMlIsayGjWPcOAkdTw?=
 =?us-ascii?Q?lfbzlgQuZO9Eg8kcVIonHgax+WRcNxFdhLZe+IVW+G58809b8yGVpK8oMs9E?=
 =?us-ascii?Q?NMKvcXcqxFgRxIdiK7qyn94/MfV9pwVqvOEELnnG2E1YWSQvCZTf+bH5KHWZ?=
 =?us-ascii?Q?JOlZphz7HO7WkgZ/AKF5ni+yFflNxaLL5jy/lBt+w5qT0rqHD0RFfL43BKL8?=
 =?us-ascii?Q?VhsECE76VHutuckb+ovbrDoZexzeJX7c6PcZtiV+IK4Lhzsk5/1xGF+EFOPP?=
 =?us-ascii?Q?NPIV64KSNioKWl0oUnXBJFHeDDKaBua7VpLm/w5Ox2carULXLCUE1Mi5l6J5?=
 =?us-ascii?Q?HPd3+xoXGiKVaZe69nIQIB7lZO2mRQ2Imd+wF9y+b5LttA3U9EPF/2twTrvI?=
 =?us-ascii?Q?kj6AJz+vVCrv2D1t1pHDmuNFoV6sDBuCgIvzoYVtzKR3yP+DC6/EatgSCEAg?=
 =?us-ascii?Q?Pnhz4KK72Cinhj+MQWMqcf1aSikCIxsSXYnE6wY2dbw+9MoIJXDLT0SeGLnh?=
 =?us-ascii?Q?wDOevrfVMZkdciefD8gm9xL/T+hopr44cN9Ak8bffet+v27AxjHtWNlJotNz?=
 =?us-ascii?Q?GnrtiqvKI3dOLF028cjjQELHSyrjTxJRiwewZrs+diQlUIa/bpRRWccCRV5f?=
 =?us-ascii?Q?MifqWeq8C28LwI/sl96xxW6mDhjeS9HkGochXLjWG9622nU/FSWEuiWbvuby?=
 =?us-ascii?Q?XaCyqPHx77I4HcH7S2Tb8MYKQQtN8l+1oIaaqN0rxhgyfkrq+6eIWsPYKoac?=
 =?us-ascii?Q?vWQZ43wKbMp4qboVwExYDkGhuWPUqLHezhKnGYgerx3rcawOYCZgGmWcYyCp?=
 =?us-ascii?Q?Iy0p7hzEYBhWuoyubUT2GuuiiY4+/kZT81K5ypmWOL043HvvaT7ZxfSK8flO?=
 =?us-ascii?Q?jx7W8+vpcXhdCbGSmwSREwxYQID6vB6xUHjyB1bWTiTpUS62exeLeeb1mFAO?=
 =?us-ascii?Q?jJ8WNGetrOr60BqrZW64y99TNqYsYlKW8CEQJO5NixSKeme4SJ05QXwUsWR5?=
 =?us-ascii?Q?fRYgkuz79c66b4z4fcloe0UjenE5pKb0X9L13F6982MIdn1MpkJvSDa4EG7W?=
 =?us-ascii?Q?YaaHjBHFuQ0uybXqCJvr2AKJy8VAe5nk1Elu5PRRW0ab3mg6KMhjYIu4uTDC?=
 =?us-ascii?Q?vPHG5XMNZgdg5rHrRtJhPtG2eD9uk6bhByQM9EHtU4zANKMyvvhS8RQyquD+?=
 =?us-ascii?Q?VCKI1hcQwj+TrKIMuvIuJ6XzX5ULyOvtntqSZMVs0KEAHQOztgLVJLEwgPec?=
 =?us-ascii?Q?nEWm8SXH+RObjsbyDtthLhEcPiQfqdqcfY3UgNSUlZqSx/v2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6289b6dd-8e5b-4fab-7457-08df2e86671b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:44:50.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKvqQ1nHmdNjqBcQolR1bV5/WmvsgSAB7W6z1fRnUfG8bTdzWtg4MvGIRdnW2YwZYQkyCPMZtQuaWXcr82GEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

This series addresses the three follow-ups you reported after applying
"sched_ext: Queue the kick_sync wait from set_next_task_scx()" [1].

The first patch prevents queue_balance_callback() from requeueing a
callback that is already the sole list entry. With proxy execution,
SNT_REPICK followed by SNT_PICK can otherwise queue the kick_sync
callback twice, linking it to itself and running the wait twice.

The second patch routes dispatch-time deferred actions through irq_work
when proxy execution is enabled. Proxy resolution can zap balance
callbacks and then select idle or another scheduling class, leaving no
SCX dispatch to restore the discarded deferred callback.

The third patch removes the now-unreachable foreign CPU check from the
kick_sync wait callback.

[1] https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org

Andrea Righi (3):
  sched/core: Avoid requeueing a singleton balance callback
  sched_ext: Use irq_work for deferred actions with proxy execution
  sched_ext: Remove the foreign CPU check from the kick_sync wait

 kernel/sched/ext/ext.c | 18 +++++-------------
 kernel/sched/sched.h   |  3 ++-
 2 files changed, 7 insertions(+), 14 deletions(-)
