Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15D37F30C
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315118; cv=fail; b=lwPWVRYDViVxvozcYnqB0yhyaDPSTBN3/kRkOtJnxc1JpQsrdXLP4X0bAB8GJ1ogpU2F2wOlnvnRsthGu93zFibSKb/D8c0QUYAD5XCKc3z6NMChp5dVX1FkV4PQgnWNBrR9XV2I04W9BSnU+K/tnCN7FXeawa+P9DARGiPXFdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315118; c=relaxed/simple;
	bh=6ug1a3SuX05QjkGVw5NBqSY24LkpRur27DV9BYzT1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VekH4eJPWsoKs8shGyxmJ208BeNg9rm0blO2yCjDm8K5s/bM+c/GkCl4f1wGWTT3YXO628LwUqOGLnouYZxJtDqvP2/E21vuanaw50+DhV9n3pWFml1y/tPBq1u9Rjj99rd3ug13gv1i1sUHwNfPD1r56qG8Y4zn/k8QIiUOPGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VV/P4wpv; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VV/P4wpv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSf+Bb8iniC5rqKdjj1ZRoFXx7oq1tidy8bfFVS47pAjoue2F1VV9Ayg4dfIg26RmKqZXRquyk7pbklDbk60QLfG5AWyGBN/OM8bIvJIxPxGw/oul/BimweSESeFaMn4lZ7OIRHj3a77VC8vppAbUJqeQgU8EcsXwVyE3nN+YIx0pIlyu62+f5V0alheif9MwcI3Ez5YVuxAWiPoTUv5DB4TOQbLCp56sL+xl7J8sVTkKxo/wYKLtfZzO2Gi2Z9M7/8I5FIMZjLfWb2zvVJ4mQdKGpCB0IYg7wylB3NvgIx48k3Ja6LGr83F93cy1KYDoyLvpbJTigIurruGF1ibLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVgh0Qb3mvZbXlLwn1hzUNw9sPkecgiTes2KefnuCQQ=;
 b=r2GsRJ9/tJ6sENZHNOyLRe83HUd7XoHPmrkllVpdzasL5Ay8uLP8KLe4mu1/sRwfc4USB5FaoMW2zPkjjdQTyJuuvEO4/uxStFJyErQz8sEGqWqF990cDiuv1AkF7OKJbTTHpi1ebXsF9kZZ2RWkAaFwF8rT8P0DSkzldsRMZYsNKS+UixJqM5VXTmM14CjicJExuXEokMQneGalQ/Z2fHfj3gJZ0vdU4nC4ojw23Ykh6Rx6fbm3MQl4LP+E8ADK04QlSbEQbamlviZ9GIBvg/LxXXlQlS5MA9M6tNnUMhX64V0JQ7EgS7WS6Z8MUm3pkzSoEO0DH+rK5tLxOyXDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVgh0Qb3mvZbXlLwn1hzUNw9sPkecgiTes2KefnuCQQ=;
 b=VV/P4wpvwLDSQmGSxo8GOhK5sv2pG69I2gn0PxmaJtoRLa/8D2Z8zfZsNkifksK52CNbXvBrOPxRxveKypWtxmz5ZOqJg6mXqYDwC2jefNTFo2HOgJukKqjOitIOo0E6wN0zoKjf1fMR4gYixrYKXTI0WgQRYYH7Gl686AQJih8oPDnrsUri68SXTExIWCGYGrHh+2hXshTrgqWhR3x4Hzh9eL9kBi77Xh4XEcwWEQw8XHc7eQyn1wUgeDRSnRFNZ/4gGSKl0N1wSCHGTqyzmvECQLbx/o2xmZPGU3fQU23P+jqCw6VdxjmY1lra4reMwqyn8UR0rMPvIQ3uaXzyAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sun, 18 Oct
 2026 09:18:35 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 09:18:35 +0000
Date: Sun, 18 Oct 2026 11:18:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes
 offline
Message-ID: <atSO5LIzqgOYxR45@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-6-tj@kernel.org>
 <atRuvuRosQI4JJZu@gpd4>
 <b291e2b97ceef620c6330b13978da668@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b291e2b97ceef620c6330b13978da668@kernel.org>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4c26ff-5996-4b8e-2a74-08df2cf8c969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|5023799004|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NqwOcumR8rZef5UEAMoBiCXxGAZLFCxRvcqyKDMzIYetH+XRw5yoosao6lvIG9yTcEoy86hJn9FZ+EIhPkxF8kfrNhHGiIJcjlLqSmSt1TuEQy1cLZDwpdpUJBaSv/ugFi03Yrbp92olsqIFQHaKauGaWCpzaTu1XfMQSVowCVwNmAtoBS/7xZPsYlLQSkfFIs4XVMpCCTl4Mr941gORiw1peJ07HyEX9bWCAYaFDvzA3PMk0eLH/AfqDUKd6k9/7XIX66ccdiFzzuRaIrG7WmSfzojeqq7X5F3zGSfvjZYTlUVxszr64/4qT3O/6moGeTBvRRK5QONDjwQX0csO/mPkh6vC/JRKK5k78PsC2PxBBcP8tsweHigY9QDDpythsVvEweBQSCFDiJWZt2zmjk2XTnTtnsndCcE77VAiEQ577auRw1RbCl2eOQPPjSkfC8mFKDk+ro0vWI1Fd2744QFDZrHVV7Cr3w4cbk2+Tv3r18U53g3EjTlVD6ASF1s/sjn8qBWunT4nwARKf2aJyXoQu5W0egZAGpQgKtkSkPqpNFo8Qkv0jtRTMlQqXAOLCiy5KoYNe7EkK+EjkEYd/OG7/2PZG10KE7jchFvIeR2JQJTzpSeBVVFU9yREUcqA3z4t9792g3jFHFa53Iw9pzDFBRPXEaJD2YJ7HCPcIfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(5023799004)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gg/FNhP2ejcE/P3JljFiQEcK6JBPksayRL8SV7OSupgGA3zPxjrDZ4g71GVz?=
 =?us-ascii?Q?wayOPc3f76av6YmYEMJXzz9JydnBoryNn/JkQW2XG8jU2MoUmeo5AYRx6LFj?=
 =?us-ascii?Q?sfg6zGmbvZOf6HD9Xsm7hRzV7CCQCFtWwJqPH/SeDW8aT8Lb7hK1ObZMepid?=
 =?us-ascii?Q?F0IjLO1YE7k5JFylGc3y9NBOP2Wx6MHMPE4YyFzi/NOMKwmPsUHw3//jcJe0?=
 =?us-ascii?Q?d0fyUVTEepFvA7WnDD8ycYqGRDi0ZWGSehZQfrThcHLEQlv4gNMuMv6Ph9Kd?=
 =?us-ascii?Q?q3ZolmDhMGLICXHk77pX3/3y2+7KnjlIrikWGSWhKukBsWe064sZMCY2uGpl?=
 =?us-ascii?Q?lYy+aKMl80YsnBn53KP/IjLRDXnhVLbfScMhKEnXOi23p8ooWrX0Z9lgjZs1?=
 =?us-ascii?Q?sPJ5jpjglQIkhCyvBdWhsNLs0R6DQlbB96ChJWZCx9TuSIiLsdplyFPGeZJH?=
 =?us-ascii?Q?/U7PlmvLsXk1Gv6Svtv3BowAMLJbUJQP8E0p9cf2niXkmCtMNwIzTq6RyZhx?=
 =?us-ascii?Q?FpxmHnB1/4nMuWBDe6iI8swkAcV5VkuZeIgNGsoyJ8i28THQ6h3cY61Hcwhw?=
 =?us-ascii?Q?TtFoBsWiGwlim3M0iGXAMkR4fkalHNC3RUU4fX+wI1zyiKrwgWvIH7VPgbZr?=
 =?us-ascii?Q?blDZ5gj6e/dHZE07VwcywQ9w9PKFbMfkHSQvmYu/LVbuvWgDxzJYL+pPLTMs?=
 =?us-ascii?Q?pgz1oXgsBDjOMDSqmBgfO7VpuwET/bQkOrsb2khujv1Jcmd79FZ5eg6Ixpva?=
 =?us-ascii?Q?TNH0OMsAzv0kesdduD4ChrKYD9v3n6cGi7rkJDbFtA3juvuowFDn4sSf5jup?=
 =?us-ascii?Q?AN62hcLu8xtdMGIoDyK24K3RkLiZjECo2ny4FF4fTo8qvrNlQ+81G+iJ2kez?=
 =?us-ascii?Q?K/8aZWtWuzyoY9Y9l8tOBD3F3A3uVx1DX082rUAz6ziiQZ6BCytITmDJEBuo?=
 =?us-ascii?Q?u1qyKunRdvGPEHjbub9Nobp0tNC4qraV/+TMe9Jhyxm2xbxYuCUCNseu5lGj?=
 =?us-ascii?Q?xfNgXLfccPQyhsn13rNSjs2wohtQPlkXu/SwY/zb1QyjGD4qqkx9ZBEI+vvB?=
 =?us-ascii?Q?vMcf4lFapM6MYTh436nUPwp3N8NKpn3mIQATmjoreMFrhD8tgnOaFfZr69jm?=
 =?us-ascii?Q?3cCtOHxkDDtt+Y9Wndq0RZifRsvj27dFB72si1JBPk2bMPmNdTJIp6qU6HXe?=
 =?us-ascii?Q?QTIBJXoCoB1PKM0y3EKVCPtzuNFRdzFrLGm2gCOK2Eo3t2Sz2sfYltK5WNAu?=
 =?us-ascii?Q?tq1hMlEJO80Tram/hpn4DUzqMLlb1a1Z5xiICb2cYxEmnOZPOC29aB+ssyip?=
 =?us-ascii?Q?jShM5DW2AHdQBDFSz8kHJKgupMN2eVcs9HS8jUpwasThm68nwMLJzpp5uqcD?=
 =?us-ascii?Q?mD8u5xPCqs21d/5THgB8+169etatxSTCJYhZDsCdQbzHmGTJE0VF75lQ0xKP?=
 =?us-ascii?Q?WIY711Jl343eNm9dPe6c5yuNpUXnfUA2wZNHAAFLj4Xg0vnAMro6RmeIvaq+?=
 =?us-ascii?Q?5aqnL78DOZDL7/wvTqNod0/MYdZ4rWkQU+GYhTvnsMVdynT0sNd8Nd+mGJiw?=
 =?us-ascii?Q?X6SIXTMyuleN7biRHEA/OfXJNrZF6JWSAsVRiPGSyS4YC/zFKrABlxQbSEeo?=
 =?us-ascii?Q?eifRwymGMjwYJWCASRKgk3km7nHue4HT9rNHsRphgiN7pDC+LqjZJTHEge83?=
 =?us-ascii?Q?18zCtNT3lJgR075J3azM+zZV4H6OZNkvPvPhreaMiEQaf4ZJeFIUcVs+5bQz?=
 =?us-ascii?Q?spa2aaSJJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4c26ff-5996-4b8e-2a74-08df2cf8c969
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 09:18:35.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT0CitCv2QpSA6bTN9w3JWTv5mmAxbkOGNdTllE9lUccioDwU2qEPBwClSmBQ9vgXBEeLZm48aDhWkFgThT+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On Sat, Oct 17, 2026 at 10:16:00PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sun, Oct 18, 2026 at 09:01:18AM +0200, Andrea Righi wrote:
> > With a root-only scheduler the walk skips the root and queues nothing, but
> > resched_sync_ecaps() still runs on every online CPU, starting the ext_server and
> > queueing the resched irq work for no reason. Can we do it only if something was
> > actually queued?
> ...
> > ame on the offline side: with no sub-sched nr is 0, but we still do
> > update_rq_clock(), dl_server_start(&rq->ext_server) and the irq work on a CPU
> > that's going down and the ext_server stays enqueued there until
> > sched_cpu_dying() stops it. How about:
> 
> These are on the cpu hotplug path, which is really cold, and the cost is a
> resched on one cpu. It's minuscule and doesn't matter, so I don't think it
> makes sense to add any complexity to avoid it.

Right, fair enough.

-Andrea
