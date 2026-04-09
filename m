Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EC305E19
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713951; cv=fail; b=rMUxjvn3F45arr9ljN2sRphoEaKi1a2CcU3ThKoZ+u/snoWuKbQEQosmAIjCOontryOcWh8xSzdiMAb/3fWMD12xnU2HmigZxgBLuZId7GFjCLBixmAMJQVB7fDT/i8hOjRaOmLDfVHd0hmiyOx88JOE/Fqgv4/2GrKQf3zv4gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713951; c=relaxed/simple;
	bh=0RjOmPEUBC0WcnMZ/dLmrazfwdqH3nF/MP1gTFxvhsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h3oov0dAmbwjbGKqyETVa0Wi+JZGrcg6bSKsmZrecJxVMbTdsXSf98uU+GHxmcbDAh3chJs6dfyB3pxbyzh27DiUU6mF039O1glT+bC4Us0SLevEXCmwkOTEjJpchFOC4tVpqXss5bwCDQALYJtEmYBgXB7cfOCnoxr3cRseFKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jv/hJ2F9; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jv/hJ2F9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC9Mrm8dUC41n3otECPiyGd0KIU9vW8oAIY194jW8+YgHkGvR5ajyfksAYui32c+Pf4vXb3jxXhfsHktmpjs5184ECir0R98wlZA9ToYvMBcG1V4mDq2m9MatJLJzvGu9eJK4Xae2KKOwGjUPHI3zCilpkG8rMK9CYV3Y1XwOyXRphjuPIjB1SlPYRzl23DUIzduqptCVx75WYAJZenUVWLFYbmpYGPCbJrR0f2fTYpSJ1gA56eEHutG/EVzfRm7EcI7WHB9rYsOgtMGfzApanALkw/8P0j96iBgxmv5jM8QqlMFQ8u+CTxU1J9FDW7tDYruNrf08XZ0jXcewVW21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUF1MmYZa4ye75joj101ucCwidEOfj6DqgqCWug0TU8=;
 b=HaXmOQSYh3ETp4CtayOuOMLwnDu/t98ztdYIehvv87MwVwtmNogTp+cx+apkS/NLD2VpCey+5KCtBGGhiqrPdsQmvX6xtqbZt+UsIw8N6ZndbD2x/Atd1JAYxadv3oMx7HNUATuL7vBScuZ2l7U0mKZm0LOwflQhzSLwl6Ah8aYSMsGr6O3cgrg3mCZaIUx2EIHQyn2x7gHn8ZkD2pHxetYh33Tn38NqJ/ggHn0cqaK8orLFtP0wntycmRauic98Q/34xYOxMqjkplHU1IQc5h1D23Qm7wEc4pg6AFF5dUHfbP1+CsO/na8LOIuMisbGFIcw7T4oxIXft8cy4T3AmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUF1MmYZa4ye75joj101ucCwidEOfj6DqgqCWug0TU8=;
 b=jv/hJ2F9lFVbskPHjkC73ekome/GbJkQUebCYMwNgIg4zZoyJnbSoIDZeAL2/5wOnG2UDgoqyhYHuWSag686AYCbbWAQ2Ka0maoxvs27X0zEtIDau9bf+Zl9tDKMISOPtxEdDcMujJPF30ns+twbkVe4LvVjXdynZoRfuOZXxRk8CNoAM1Oh1mL398/CFwT8FjHZLHz7dUh3f0sDsfqz9P4pj1WzBqI2PrAq/1hgagDk43pNxwNFhY3GRvVxSK+T/BnXuW20S9KvgWAo/A3ihxswBvJG1+t3jXlEepunBAG5+4jdu5nCrZ6wYbEs2wfhGTycR7sy9APMu6Y3yxIYrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 05:52:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 05:52:26 +0000
Date: Thu, 9 Apr 2026 07:52:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, void@manifault.com,
	kernel-dev@igalia.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
Message-ID: <adc-l_7ZNWLkyPFL@gpd4>
References: <20260408031113.76005-1-changwoo@igalia.com>
 <20260408031113.76005-3-changwoo@igalia.com>
 <adb-pduIY6oZxLYh@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb-pduIY6oZxLYh@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: b4007ee9-09a4-413e-217d-08de95fc2dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7ZE+QF3uN3ohWKD6fbazM/pP7kvd1R8JgjvnQd9OQDZpNHZSY5Ex0wJBaWBsw8ikfSOKmBpqNlG1iZfHCPRIhoq1ZilZPEoiFFqOTHtC639C1sRoOtOcFF3L7nI8Hnqp0yVH4x1IgOqooAGFOM1I4u9XBt/iLfQ1Fu/LZbJzYPj7Z/wwSuoDygLZMeCeQgNL+nKJIVuIEs7sC+dyj556zsBYGvafUoMrfday678k93iwF2mSlvI5xGCkgE/LtoBxHjcEV1ZTH321oBtcvH93NEdOKi6yEqjf8XIKm8TFMWavKN2mwaa2N2TO7OvcQG2Dt5KgmVqYURO0mDkWR0/izUBf2LA7AhybGWBEGccLyK3aq2ay84yDZHVJrBJvvPtWMHPmaRAU/oIE9Lc14wgi1WbGl025z13E8dqMTTcJSMQdznuSJ07QlHBf9AW7GaejOkfGfRw9NAGA45z+nLXc76A2koFuqDFeVa3g6iQBKbE8mVzhY+oZNAn240sUSWlLsyQvM3IaebS5l3KdtgRTr5h+TdS3XBuZSwCL8xGLNmGx8Q7EGeSynYrjs/QvveDQMLrQ4fphZtLf6wpkS9q5Hs3jRcL2/m91CTnm7U2Q5uGjgW/jFE6PBO3n+XfPTnhgWD7fa+rpy40xKjDM/SY9oZ+cGl6pPMAMFlWoauTgXYf51rVX9W8pj7PAEUiN9rj5N7VQZn4v1mwLyvOr85ULGQYOBwqFvgi+6qgeSviBiEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0OSZW/PyMUMJqNFAyTJTukyzEgpo1HU2aWo7fvtjim4DQp+nHCseJIpy36/e?=
 =?us-ascii?Q?t3BIOj6bL3aceUO09T6THMA6CMzsiy6BjW/3rcHTThfrLt62sHnbpfSoy40j?=
 =?us-ascii?Q?10/QdPVAr/WRmiOB43vi06YoVgAXjOBDO9rgweaYqPt98FPhqdglfCva7P6E?=
 =?us-ascii?Q?0L6B63wT4QPhtVvfv55PukbKPK8Rr8MaVaQMnrTrDhgXoEmJKicpYTQO0YJt?=
 =?us-ascii?Q?Tz/P76yav2mRrD9Jh0Wl/aGjuK3TSZB118/ysoWH2yvULZXAXqEjbnEIzOhv?=
 =?us-ascii?Q?e8qqQynRnatfrvW16+aJWnZM8ZI/so6N6LvoOMb9BwT+qi+dmObux/bePuRD?=
 =?us-ascii?Q?cBof+w/T69E/HZC6uC/6p7p61B1oVNUKqo18KHGJweWnYMxDmblgugbgh8JY?=
 =?us-ascii?Q?UqVZcUAzcT/YQRWSwN7Xht3dI5G94q4dMK79wIutJkAKHPtHczv+6LCpCEo4?=
 =?us-ascii?Q?ng/lU0n4B6Aj7GY6bDc8al0o2PGFCH5yT2/otUpsnzIUbXWLTd/l0iiPdify?=
 =?us-ascii?Q?0CrTk2WZJocOE2QAA9QnOgbKBzG/pTImP8bWBaIYoZ5xy2YNdAN+ZnpjK1Ai?=
 =?us-ascii?Q?992INAQ7UR6X9ytmXxeWPL8px8o4tdxwL25AALaaySoQsNeKy0LZyUlUodhG?=
 =?us-ascii?Q?bv2I2PO1qJLWxe7RBn/FKA3PX118fS787VsL42m2UWXnNp8/c/I3xYPUBwCm?=
 =?us-ascii?Q?oE6S17iUbwRwdaTYYt7fIXbbp/bP15/cQLMWnYq5f+IQeTPj4VcSkXMi7QNT?=
 =?us-ascii?Q?wMukm9fqwDSvpgifIR3fChutuD8F8rI+MQ3+0HxCNxb+QHAXFXYXUD/kpBfY?=
 =?us-ascii?Q?fVhN6yyipo9HppFkvFxOMtrdDVGT8wIVNTtYNP1yJcqZ3tCLyuzkZgT/4SBC?=
 =?us-ascii?Q?H2sf/+TauCdHB2foedi6vpyKwFij1+t/WQogzGqzaoPjX3ZQW848W2d2DRLR?=
 =?us-ascii?Q?58+cdxIlRt0INx9Ekuhx4BRUiYipD0q7AXfrw2orrNi5/9lHX5KvGhUyAvwP?=
 =?us-ascii?Q?zT9qAEBT+XlaB0yQXFSkVOHZtByRpuvqz3r1NqsciyZDKGPk0OzPG1Q8lo8A?=
 =?us-ascii?Q?QTh0aQii//xdWoNw1TtjI42e+/Xz5WIhJbHf6bRcP0RSMoVMsjxrHbdbs5Oz?=
 =?us-ascii?Q?3gTh6PGOiBqav5kWIw1a3lNDRyC0lecNGlFmmxdLZOvHDME9Mbb2iTTBIdvU?=
 =?us-ascii?Q?L7+ZTC9fW7AlqXnp6H2OwSndSQUBssES5rHR5fsa284PHE9DWq9PCCs9t3Nl?=
 =?us-ascii?Q?oD7KWlnpto3AlVN24qwDX5Ei2R3lv9DM/OPXnyOax21GiMQEDXM4BhOb0YIr?=
 =?us-ascii?Q?xtWajq2ZD+5G//K2khfQrMVSYTFSGh27Ufa7ijWoUWATHhRPp6s87QN002Il?=
 =?us-ascii?Q?biRxBbCCFCsAWZS5g/HKlmVcmV1MH18d59+WHyxR5yN2pijpjJUIHEgBayON?=
 =?us-ascii?Q?asRC2Jf3D2fUtNnBDXfwpyOOwL/WuXidDBM7A+U+UeAR7hIP3pkq29Fcu2RC?=
 =?us-ascii?Q?IW//rQKBdLPSyfLsQGoRQap3SK/kzuQs5DNVfGfxpm39Vsw2KbxaCyWEurTU?=
 =?us-ascii?Q?BFnbDyu2cw9Ak0S4GzZMvDTnXRCHgGryfWz8dRWPZb/PokEGzFJodxCVJa4M?=
 =?us-ascii?Q?0YjgBjPNlqeCrZ/rSS/WHWSYhlRcWAMGSOg0zPASJxODGzvRg5JkSJk0CZom?=
 =?us-ascii?Q?MhQzbXScHYvFk45XBQBHFhm5+v4XRo5byxMTfudDPlj08xFrWdN6Ezotsc+v?=
 =?us-ascii?Q?AFKJLeeEfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4007ee9-09a4-413e-217d-08de95fc2dcb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:52:26.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irUuubQkbjkMw7pNQPxYOVida8HNH+rtwfqsOWsTjzp+m9IdmCGH7OLWetvL3gTIYmZJJgyJ/18AcdBvId+7PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387

On Wed, Apr 08, 2026 at 03:19:33PM -1000, Tejun Heo wrote:
> On Wed, Apr 08, 2026 at 12:11:13PM +0900, Changwoo Min wrote:
> > When a watchdog timeout fires, the CPU where the stalled task was
> > running is the most relevant piece of information for diagnosing the
> > hang. However, if there are many CPUs, the dump can get truncated and
> > the stall CPU's information may not appear in the output.
> > 
> > Add a stall_cpu field to scx_exit_info, thread it through scx_vexit()
> > and __scx_exit(), and populate it from cpu_of(rq) in
> > check_rq_for_timeouts(). In scx_dump_state(), dump the stall CPU
> > before iterating the rest so it always appears at the top of the output.
> > 
> > Introduce a scx_exit() macro that wraps __scx_exit() with stall_cpu=0
> > for all non-stall exit paths, keeping call sites unchanged.
> 
> Would it make sense to generalize this so that the exit record the CPU the
> exit is triggered on and always dump that CPU first? That should include
> stall case, is likely useful for different cases too and we don't have to
> add @stall_cpu to the exit functions.

But if we record the current CPU the exit is triggered on, in
check_rq_for_timeouts() we would prioritize the watchdog worker's CPU instead of
the stalled one, right?

Thanks,
-Andrea
