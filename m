Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE9278E53
	for <sched-ext@lists.linux.dev>; Tue,  5 Aug 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404392; cv=fail; b=FkK9rWs81veYcEM5Giod/AVETaXbhzfG4Obbisk9nCsgJHw6T0X4jBPHclYzoSVmjJLepUHiQ6gmIW/ZE+hTvYCFCujQA/m24lMHMnIOKm7bA8NNsi0x0/vnU5CHCBVocKE8RrOsnYLRn68qzuw9rKMu09/xnqie/p2xk6m2dRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404392; c=relaxed/simple;
	bh=NE13pcJw3JgOuN6SILB9CLahybINXLP57RkdhaE7HIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/GTa+PkQA98QMGfx0TYUVMqnr2hiXaR+/CQl3DTzJyuE1P4q5Fymbqzo2e2geue0yXRuhq0p4msnCPGWOEEePK7ss573BfbSNis/62SUKtiFWYzjVQByQen3EV+J/UsDJ6l8paS97NNwIbvr9F52ZZSAA0V+DY8ULaE9Do6wkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YoohEbcg; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YoohEbcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIASGX6iyNNtTbHvFGzLZRz58HdKhSqCtbypKIF4/auSx2njT/JXbCJRILkmXSsHVcnkVZbdeig25kzC93z+Hh6FaYoVvyeSTugnY7eMMG6lY/GUQL6jtFK/c7Xa5R2CHBXxdQC/qayF/PWKByJsdLBfo19CkpEL3TO76EysFHQrWUvT9Uypo3W9qLtxfTVGf6hcQHXjreIL0gAr1R74vv7W9SJvNPUv56XX/hZuJqE4C7LzCgBXeZvD2iPVC1Y8DuRAh9hcnG6gs9Bjc+pWq0LLhhEUFPwkt9FqB5rnxcCrekWcg3akO46v3kRQtGh1MtIkFFOS5JFCaZjTzLJvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PY5nwCB8yUCOFGAlE8Nd4iraVGLQGDVua8xbspSV0s=;
 b=soTDY2N3ooldeysbmNaZFzyYd3bET3Q1AZt9k84LYDNTbwOEzTxLP5GLn5OgFeqhKvkW+G1KHYxLdP166LYcySc3WTAfZ1iqsAyXkT46AF7ZEXcMCVupQl07o5kUq23BhjyUtrFxRml8iaxJSHDTylpolEp34QO0Po9IHY5KS8ZNjrIFwJ4+zrt+Smz9qJIM+Yb+oHTrMIB1eTblXOf2oriOWHNJtobyEL05Qfoy3wQGFb4SksAwfeAoCpp4oD+JQLfN1UXPLdKSqkSe8xL5Dl4d8vqsQUW7wa9/eCkvaR+E9BSOejjDV09aV9NcPiqS0t4DjZUAW56wAT8a0OTafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PY5nwCB8yUCOFGAlE8Nd4iraVGLQGDVua8xbspSV0s=;
 b=YoohEbcgxMt4F8rrRBsMFcGyLSTGLeCx+QbWCXl8J0Cmbd/zLBBYmuCBST+Aca0UJnr1Jg4pHGZkPet7cA/8wBUd7pFc/ixZFLzwginxDquj5v+AU+vL+b83SNxuIcGHg6T51lty1LqAeT9LvOWSq+PLWCCzJAooad9rdNavJilTlOeSkf7RHAcRDV81OvHNnWj6HumtHviiigpdzEy8oxV9/VWa0gUr0gs89HKm74N9ptL1oj9c40HTrEagnwLrqCinxbVIOqUmANpW9sFOldfi7CrllJyqB4IvWlmVDmLtOa4gaUGIGonqie/yxXKwDJkqUgd5VFgNfzI7FHaIJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 14:33:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 14:33:07 +0000
Date: Tue, 5 Aug 2025 16:33:02 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <aJIWHk_4IuOxyh5d@gpd4>
References: <20250805111036.130121-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805111036.130121-1-christian.loehle@arm.com>
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 509027ee-0499-4c0b-b68a-08ddd42cfea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7OB3tgM/uGipOpnhK5fm1QJQSHlDyr4Xxyl8MnLtSwoJdrXF+j88Y+hOpIZb?=
 =?us-ascii?Q?wQ2wVd3PVOYLI7lFlB3l/dfuLcgsdulIpfz6Oe/2blKQy0OBx1iE0PQ5qBP1?=
 =?us-ascii?Q?h3tqOUHxnG2JPtmfU9ZP7wLyGf3UCtUHhffIeEy4CaiVGjvvwWvmvacQJfBX?=
 =?us-ascii?Q?d9wXFaAL9R5tIdf5MbxTBuYi3ZJmb1OQPf5w9xCdooL8DKxy3LTL7WQ1XZuh?=
 =?us-ascii?Q?I0QuZsg1OMR10S1tYp/yHWXozHMA4iV6Hq7VvcHD7z22mLNwp5sglHY53hA2?=
 =?us-ascii?Q?guvg2VK6eBlxezcNwqm1fkD+2P0WEC7+UqpJhwZUHTiljltSxFgIwVGJQmf8?=
 =?us-ascii?Q?M6psptKxge1HCIZdfwo8YlC8WZMwLIH1KgNm9QBoSFlVbPCWu5Mo97CbCdHD?=
 =?us-ascii?Q?USrN1V4K628E+jkl2YveX0p67KMYskT40Vq7jaImvi6Tvc0jUoObNpihASgQ?=
 =?us-ascii?Q?PNk0oS/hgfz1CIRjS/McZpDJTZCG94HbmApGX98sbFWM6EOjSG1XzLTDSa8s?=
 =?us-ascii?Q?Bg7z62xbhZyiGBkZWevoD0hEhj2iz1CFdPquMRI+0hB/Bi9ttk7Pb+PczC74?=
 =?us-ascii?Q?TJ8zZMeV5d3SdnmjY2SoHTp2rpJZWxi3NH4LoHe29EmiRNFtO+eXZg0WUrex?=
 =?us-ascii?Q?8bGkjU4a61+KI3SQr48w3+Id7S+mEVwP6XSvDCdK/OX6l49CR6nXKq6NrbT5?=
 =?us-ascii?Q?AjR8K/mdWGQYa6fK+ehjBXUD38pgntGmWLcIPoczEiAWkvZUQnKcHKJyUiOY?=
 =?us-ascii?Q?MN0erHEufTUG/888qSgOhqJRFtTn1x2xsPBwDga1qoMadfWRZ6P4cOQtdYYV?=
 =?us-ascii?Q?HFcANzA3Mq7SEAHCxrXA4cvN63fGrric2LntvWxGx4St3mh+F/nVHfBNhWz0?=
 =?us-ascii?Q?p77kD0WWFBMHnrE3uV8YVvgkvo/nmLEf0z2SqB96jyTN8VpwpUZXMtmGNYwq?=
 =?us-ascii?Q?IuWQ1RAM7GlAF9nYK+ISoRqejJ5glpuMHdrDrg0MGnpb6DikG2jJTX2us4ov?=
 =?us-ascii?Q?21dBmLUw9ZptQFFSMvK9g7PHt0fkYhzF88jlPxO99hYltDEoV0cooIZC/6QC?=
 =?us-ascii?Q?wxO0y0vsZcEa/kr+JB3mByYbHbhUk2IHZaNpI6izYIceFx/3Q+0JuWC+K2h0?=
 =?us-ascii?Q?CBIJfZpqivnvjItWhdIIKPGeNRUuKWCkZ8v0C83n54MViYiwUM1UnbDTj7Cx?=
 =?us-ascii?Q?KgioVEPeVSdptyOsNXBSQ/5uOzWxKpAW4yCqZLMAq+lu+3+Pn8bn1BJXzOO+?=
 =?us-ascii?Q?8/eCZK8coBMJtsy1s8YET69qkMrS9WymK9EwFN2OOd3wG/Tsm6jlfbiEOEIS?=
 =?us-ascii?Q?H0EHkKZp0sMKcix+vWgLVeCvT0EJcha24NoT/VQNu0LSZlhfeBNtWBKE//d5?=
 =?us-ascii?Q?4hzRUCMSf/NTeLni/1qhzQEXOQpighFappX/EYYgKi+pdvomzvA5qebfMdx4?=
 =?us-ascii?Q?A06q47W7TM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTwQ2IorVxftbj02E72QcllPGh6BPOHxpNQmBrtMeBikFxRPcAhZ1tjvVx31?=
 =?us-ascii?Q?/vMLtAFSTGFNiO5tO0i46JwQuXxNe9vg0k4oGAAKe3TjPKCV7MZJFbp9T+rH?=
 =?us-ascii?Q?T61a/ooFywGunFKvI8QfIxZSCIo0+HrTy+a8cr89dnB3Sf9JIITCe4RlXCpt?=
 =?us-ascii?Q?bhuNz0k/VPS1xkdjwAKKqjz+2uJSXAy2UcHdVpZcd78cQDxEa7xkr0TVmPda?=
 =?us-ascii?Q?uMAXyZ0lsnHVMYBUcZw+3BDNAuZEDP0XZyFoA6RFTMgTk56ioGkb7ooxydBN?=
 =?us-ascii?Q?dWGmpSMizPFXpu7G1G3vPm/K4390ohOlPzOtpvaD5t+069InZ66oV8iOEHge?=
 =?us-ascii?Q?mL9d4BGHWLohB6zVOIawOJvJb6r5vUnWq+tvx+DQul69pZKYszl7ffr3Sq1i?=
 =?us-ascii?Q?qXcX9VAOgqu4XXMwUUCupxGhuMneklClcFTmdMcvXr9uQdSOjeydM343m5tq?=
 =?us-ascii?Q?A9uUQmUHe40MJayrbRVKReUGQH/3+XYyzZrlERSnAF/zYWBQgD0Ki41BBmhq?=
 =?us-ascii?Q?fvkh67MLOzWRmPwqhq2Yi/UR4QmR2zmPvzw/765sMI/vP8ZdU34Yq9VLjfEY?=
 =?us-ascii?Q?GfKwD5JxxjhqyOGKF6GWKdt7BdRsNKre07gvmfSkhpDCFT2qEORi67IUox8h?=
 =?us-ascii?Q?5PcxYuJO3kv9gaxbL0KoxrvkxfhB2evjpErY5dVlAx3ddwOKqc/gByhbCi/s?=
 =?us-ascii?Q?t5iuK0ZxqR2+fdk5SObaLlaECyDklqlhuTkiQi+ab4rbSEGx9JDP0p2n4Yfi?=
 =?us-ascii?Q?/pS7mhZvDUF6ileXhbuAg5qHaz+ZVq1acguEA7t+GBARp6tdfr18092LqmJC?=
 =?us-ascii?Q?0YKlAW+ShE9haaGVIAvN9ZQWxOsoWQ8v2yAeiY6JNkisQw5lPxSrKL9Ob1qy?=
 =?us-ascii?Q?/X1rLEijx0djf0CzKtO7EIL7b1woHapPJ0G1ZyUvdwhfLrolnwX15KDgni5i?=
 =?us-ascii?Q?meJK7qJfG/JNFRjtlAb74tIlYeniMpo2Egu4MUryAOVMKVvM0gZ1Cd/pRALS?=
 =?us-ascii?Q?BURwMPkwkdj0/klLe5EHdv4+g4tetW4p2f1LPydpcTHMfGe55kMojyHdHPMp?=
 =?us-ascii?Q?OSxGwXd8fRGbnybLuRL2xuZTz9ZBalWN/1AuUdhg9iJVt6a8kw56decYwz/A?=
 =?us-ascii?Q?nKZVs3kZoGY66kOSKgDbbcYPXQfRElzX2pYYUZMjMnrc31+Bz1E+KNYR2gBD?=
 =?us-ascii?Q?SGRdYsjmP5BrgXBc+MB2CUOyxmwByoJkSTg53/sLYeLaZYN223/68Sv93/6g?=
 =?us-ascii?Q?mRvl/DdcPKB/MJT5b1ng9UI97vO8K+gEK9EAkZRy+V3/+ua/cUdLX5+0dktA?=
 =?us-ascii?Q?I+qz6KHsZrNvw4aczne3UJStewONN90ps7G7YTca+zWs+wJPDUVH64bBNxG3?=
 =?us-ascii?Q?Fcrko+Chdk3uuXy+g4x3lmMA5RjVUvFMmhECTybFhEQnnrAay735g0wNxoFg?=
 =?us-ascii?Q?hrK78QahdC/jo96igAKR9w7wAIe6nLZ4VfzOHj1w83HLeiGjVLOekJ+3MGwr?=
 =?us-ascii?Q?tMdHwKbuBJctyQyo/awHJxAdbSyMOczj0qpgMn7gos/QK3tVLSoOfFlYUJkm?=
 =?us-ascii?Q?mLl8YAtUIY/qDlA/57U5PB0kBjkb26y1i+IPk7fv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509027ee-0499-4c0b-b68a-08ddd42cfea7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:33:07.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDTEgCVyO8UberJq1y96AEnapINuemeK3LRH8z8GlKPqlHn6Jjwp9PtLcnP+7kP0+I+XSDLvK1GfZckCzR5BRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

On Tue, Aug 05, 2025 at 12:10:33PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> holding the associated rq.
> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> So provide an alternative scx_bpf_task_acquire_remote_curr() that
> doesn't expose struct rq and harden scx_bpf_cpu_rq() by ensuring we
> hold the rq lock.
> 
> This also simplifies scx code from:
> 
> rq = scx_bpf_cpu_rq(cpu);
> if (!rq)
> 	return;
> p = rq->curr
> if (!p)
> 	return;
> /* ... Do something with p */
> 
> into:
> 
> p = scx_bpf_tas_acquire_remote_curr(cpu);
> if (!p)
> 	return;
> /* ... Do something with p */
> bpf_task_release(p);

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
