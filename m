Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792447234;
	b=PDYgAjXFxrIxa8v2sh7YYWNDPnRtK8+UUXy+GmOPYyDlRqhCfq+pu8kt8YDmwxDFLGnG
	 qBZ2Rm48kmlMmgSbzWUjcGxlB6L0ycaskOiso7H9dirGy2jSOZWvrFGyJHLLxJN+F9zbK
	 gqtZFFWD1OTvwhesRbPqaqo7etImC41QzfE+IPLFWMvTeCREmsRtRVE0ZSd6uYlqRyQ0w
	 YGKgQR8sU3Cnw32+VCFfmmGyVZrPej4iV24TdXGUJPJfT6gA+98/PrYxOapAKXVXx/YHr
	 7RZGSfQZ34aigqw6VMvBrTkVd3GuSd4AxVDnrlrGrn30Gyfe1EJDpgHzpUalj8xFWVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447234;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=g7TudOx86r5G4uP2w5bcFJYPft7kAr/H6PPD2iZZQzI=;
	b=v8Noj4OhSpPHMHknLTgVXM2t0W1DTL+mEfd8sNCcgzPOajChhwapxoGo8ye1ztB/bNLt
	 u1t2F27FSNRe9PNAt+PNJsxlDb8TkeldN82DSxSOp9BhwdhANKaZKloCNHEjZN8X7iDgF
	 35HFBV4gp3mbF3xqKzxCV9vd2JrBu9Cg6I3MlxYhjY/55+orFdZ6NzQU3loHm+O6nvOP9
	 t6ikRRtI63D4TCYIsGCGJoMawlSXgnP58w3Z/ySkjh65cn+k6N7TV5FUw5EvT5LnpCaba
	 t8krUNg8DCHJlBrHa/2MEREvrvf6XCWomQG9G3sHMeUv4GKHQ98//MLJoUgWQEOeWYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EjlGTIWc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.39
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B3606A324
	for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 22:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823B3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EjlGTIWc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6QsCjm8LBw77d0wuo+2NrNZ/01zWOmGeigMVXAH8o6BanypOeGSA3jwTgmyPd38Y5GutMh3+PqgvP8HyH/HmbblcpnoeMHafLHqrLpOj8YHH794NU27DFaqLISVwwbhfTHw4u0dbdE9uDg9iNvXYEp3hv6utbRS9jgDPfLvqQVsK3BLciPLkk8gi3tmG1GXtlGfDZodZxHanqkB9hfrp1SALkoj3EKC3/gTsjKkkXzCTiqu26JjvV3uZeVp485e/aoLLyZm0xTneeQNBWlfRwJiSqm2mzlhlT6ya0tSLONBhXIC4IrsZB9ZYO5RCFoC6TWmxhfkcB9gf1GIU2P/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7TudOx86r5G4uP2w5bcFJYPft7kAr/H6PPD2iZZQzI=;
 b=Wqou7eRi+/kykxJt5yUoN0QlRajIMv1NvyY2Api6MQsAUubBlDJ4sV7Hadp3d354qCk6HaWvomrYfdzjHDj37//T1Ixc4/EKWzJox1ePN73NdG4MaC7tzVz8bG0iN8dX3+8lBm+gAetiNuAsrag2Y4iN+gPt6D+/MeJ9xbLnzQq/bCNWGQcviWTCfkJoIrMX00oQ+KBsnvJzG/4LM9PVteBEpy7eNx27j56bLOvOopEP5PzrPJ8xVQj3uO20SXN78Eo4NI6q24VWppTcktUlY/gEIoaxRCGcpiKFj1iGQcawTlxAweMfjGuZHAv4jxXntNdx/mb6wyp4+Cqi/tx0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7TudOx86r5G4uP2w5bcFJYPft7kAr/H6PPD2iZZQzI=;
 b=EjlGTIWcNjpVAbWb2KRJvJ6jS56AC6fIiAg3Ea2F1cLZNLsXA2H+4slLUKTPtzLBRDfkt9Sc/mNsYaYKzK7mkF4OADJEuP1r7jR8YWQMK7sCCl3m4V9jQKwWgjDsoH33BLE/42yhkE9gxV+BZMiMlQLrYeDhlNKcgMoy2y3JQGZ9a6Xx97r++qGVdmh2PQw46a2bDI8ypht6wTUUwTFtT3JyvD6g2/QU6+llONE199wkCjq8iCn5U9lLuoYEOxdFz0pWKj3XWalWyGgPh7nw82ovuFiEAnUryjonBCe2gTgqaLQS+sZEY8wpp+8McnYO1uZ464WTspr/8tyLB9q4PA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 22:00:28 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 22:00:28 +0000
Date: Tue, 20 Oct 2026 00:00:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: scx_qmap: Drop the
 compat code and fix a lowpri starvation
Message-ID: <ataS89RDe7vZ6nGg@gpd4>
References: <20261019213221.2919481-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019213221.2919481-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 2234b228-e7fd-4390-d701-08df2e2c62ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	iHEdle4zGmN51zEAvIE13geA4ZPqix6FmI74zICfEA+LNnFLsME0lW1jM0+unEOK9UFalXxrk/WeVvohZnu5BsQW7kP+T8dU5BwregK/Ljr8d89If9/6SIUR0JmM5X1rulP277oES70LVTJcV05SeYrebVIJ1WLAJ11YFG1Fg+Za6mNVi72a40T/xBGCDx3PvmQJW/icl1S5ZvMNBVLYmRbKXlgHkoTmJMMCv41ut+ugQdSyT6a6iLEELTwx/DwpAx/U0E+8Jh0xQZR2ieG7pJnk7Tb353EPqGBALQrA+tvYZFzBxhNZ86+KL4dzVxnNJ95HI+8lK+5ouuSZVlnsaOw746I/VA7Zd8Jm3NHqA3QdVyQNEkYLfacit841VbUZOkSRaUk3MFk8PPaIapZWDgg9lEhrIM4STIcwyZ8MBnlf3KUiFMdaz7Z8IvBipCvV+N702o0RcwvS2Fc1VHbXL2PaOzxQnvYCeGz00FMza4cvZVQUmsWKCFNNBhJjCQFofico0qncQ33TQ5dqaWd2d3yOP6HDZGGk3kpcAURoWWka+NCC2BVLh9dC0dFdV5iiN0GnRX74r8EnP+Sn5YrM1BGImUSw4EcbAaX6i4izy+0RpL85qLc9KgfsZVlV9h/VeYLE9RucAvnPihUeHTO8i0Q/cmda/Lk2TveLysxlTXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7/gHBFntyIhmHGfqvM4WYzrIs8Xo26OvVop5nQCwIZvD9ZAwe+RbBEj8ZJt?=
 =?us-ascii?Q?YuxHdWnnNjEbzGxSGgoM30YgwCvvbrFJQ/iTwxtYjgbfM8rUyOoOaqZaekZs?=
 =?us-ascii?Q?Rp4q176yC1/unrja/mX3HAkLSDzrLkWxsrbdT7b7ICwvOCh6yVvxx9mY6LfT?=
 =?us-ascii?Q?ammAuIvWBo03o1z5yUXLqFcKDCd9mOZiRKD0MQ10wHdmJ7eqCWClB9UyVol2?=
 =?us-ascii?Q?KEXl9jQGN5Gaf7YQv0fDgOHaTnUnPDhIL++KcLKaRigOdUMAgk/VDj3BQTTx?=
 =?us-ascii?Q?sl85XAQ8FTa8SDAylSdfpeJ9O4Sa70UvaUsTlxt+EABvjpklzQY99Z2G6bA+?=
 =?us-ascii?Q?6wzOPSkdIL4Oqdegmsdfz6ujBeuMfYNdT+o0Lq2vzsKbHzJSOtfmooMewH2U?=
 =?us-ascii?Q?6crXF1IyWOM7ektii/V7G16w3z62ypyPYyAiwrHInsoaA4oZhvvJ+WO8dqdc?=
 =?us-ascii?Q?zquJT34nchEx8+MWlCyF9DTZw3Gt+lSasYFcw/u6PwQMtxOiLCEDS4XSltP4?=
 =?us-ascii?Q?ZC8HXUE5OhG/h4BkfzgtTfow4JIzx2C2muy4KGMq93T3kcykEIbaSo802QhS?=
 =?us-ascii?Q?9PTDjzPqzhRKjrjce/ZCRpiAIZJL/vPnIcuYFA8zf9CYAEUEwKU5sMu/bX3s?=
 =?us-ascii?Q?/exACVN400Wrxxc9nQWqA+XRADR8mUeAy5zDUKoIyjjAB3MO0U0GE3SwRg6z?=
 =?us-ascii?Q?BxyZWdObBpPJwHMbHbel0DHQR5lvLMMCwZa0VfKVrn8mzR6F/o3byuu3WyEB?=
 =?us-ascii?Q?ebz/nWzvjjnIglCLSriPuGCG306PeX1qez594egc1zBOVeDClwEA6rD9QLgL?=
 =?us-ascii?Q?tvHPItIvIFprmbNZ+wxJw+/5zNdvUPtCOxy1eysq9XdpJvISQ4seTic/B1SO?=
 =?us-ascii?Q?79sGFJ5L6u/wOcODTKaq6oB9m1KTUlpD0k9HXhXM61tHB7tmKXw1y+e2g/+q?=
 =?us-ascii?Q?UUzaMbi//xg8q9tocinEBaajquEDjn12WTuRPT9a9cti9CpxYp6fS5i2/nFQ?=
 =?us-ascii?Q?ogAllyFv7KLXd64Yu/rhh+3MmDi2TTWaOwu6+IcCrf4VKFCJb01whaM55uvs?=
 =?us-ascii?Q?Ta27OntVxcffzvpRWnXqoNahA5IosqX28RnItm7P3R1tjJ6JKqsNnnScILVQ?=
 =?us-ascii?Q?RhoSiN0HBow0sE9HS73VOU6NIVQcaBzr66KA40X5CN7lEtlywtZebZehkR1D?=
 =?us-ascii?Q?Tai9eT0AQ1nOT/zZTxNRMbKRuVhpxLm3u5FR2vjDIaHjO/pOZb475TlzSd/x?=
 =?us-ascii?Q?e4IMlOs6jkwYBuzXx1kJqzSTK7j09Ux/LtFTsHwFOEXWvT6VNJuxZFGfqjDP?=
 =?us-ascii?Q?4nZ8krNcVh3o/M/30gyxbsPdm2Qe62AaXjFwV9ccBMh1dMTjj+0+YfMN03P/?=
 =?us-ascii?Q?sJh+Y7jl1a0NRqseE9VHH5R6/if+amveNYfHzXgfKJymYW4nnMbSYW12sz7e?=
 =?us-ascii?Q?M5BB3JmjPWTbKymvtjvu7RSkCifw4T3WUYSz4wE3F7/Z/IUQNeoJfKARA3Cf?=
 =?us-ascii?Q?IqPZwtBzfCJ515xf2VsXNxw0Dsf3pH81+Shw5d+HsTnpumWRVN5CZMnZGR1/?=
 =?us-ascii?Q?clQgqlSWLlMon7acSeAHtnDRWBb5l8V/HJWd2FwkMD/2J0Dh0TjOxPtOHHKU?=
 =?us-ascii?Q?3gKLUyYdPnQe4tRvN4mnee890rTIw9JPqsX5whEKReclcrtGs5IgVaKWjMEo?=
 =?us-ascii?Q?HZH+sT5oNEjcA0wpC8fj4GKEKMw6t9NoisW7/EuF5+xgpsP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2234b228-e7fd-4390-d701-08df2e2c62ec
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 22:00:28.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHN0R73OP0pU8gF2kWwoO6ZnfZfE0CDmevjnxY5gAKx1bNr81jU1D6ieDOAAdBHhExV96LW161A1FBuwuhMmyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751

On Mon, Oct 19, 2026 at 11:32:19AM -1000, Tejun Heo wrote:
> Hello,
> 
> scx_qmap is often used to exercise sched_ext features as they land and
> already requires the kernel it ships with, so its compat code only keeps
> untested fallbacks around. The first patch drops it.
> 
> The second fixes scx_qmap's lowpri path. Nice 19 tasks coming back from
> LOWPRI_DSQ go to SHARED_DSQ, which is consumed ahead of the FIFOs, so enough
> nice 19 CPU hogs starve every other task until the watchdog ejects the
> scheduler. They now go to their FIFO instead.
> 
> Tested with root and sub-scheduler instances under nice 0 and nice 19 CPU
> hogs. Without the fix, the root is ejected within seconds. With it, the runs
> complete and the FIFOs keep being dispatched.
> 
> Based on sched_ext/for-7.4-fixes (ff343a94e44d).
> 
> This patchset contains the following 2 patches.
> 
>  0001 sched_ext: scx_qmap: Drop the compat code
>  0002 sched_ext: scx_qmap: Queue re-enqueued lowpri tasks on their FIFO

Both look good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
