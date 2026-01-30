Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372930DD3A
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758481; cv=fail; b=lvl3llW2G4A1gpT4WLrJe9T+sBGtqAkKbb/YFOu7X4aAYpt/XCphyHzzclmdAtojYZPjRlnshkHnrI2N2Jv77IASp7hJH93jmu1Wttj7f9GtI/V4uozRStb8YqwmU90H9N0C+JA4DI811gLCABg9Ups8INLFFXs8a7Nx1+oEOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758481; c=relaxed/simple;
	bh=DwrqRNNes8dP4jhBZ39q/j65nO9VJuMwLzfqn0kuCdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IzK7jZGUFVxqtjwT44BHIzogZUmGh5uZgHgc/U4Pz7+9u1R7N4prGRy+MeUnpxhTZvLuejJgrIyy0mIGqi9oAqb5PWZHLqvlabdd+0Ch9UK8t72dbj8zzKIChZBFxxcqVahmMX1rdgxKS//kJ5K+T6J6gJH0XOyFiWtgoSvcaec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayJIeXL2; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayJIeXL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wESfhDWAyT7zlYiDMEH7uEm8xkr/UlF9D7N5utE4qi8/CfmmYZ5IKwQm0flMQmQhykWL5fGkpR9wY4E/SFBI+LsNOtCiWxGE4S1WH7MDuj9+SJlUOMHT4IgO+x5+V5W1kPoqNAqwT1WbKGxkeoVUnw9fMXaGrQNeQXveUsYVonlz6TAwptEAfTuA6tiR5wQ8yPrlN6uVu81nRUixwPtNjKmqtaf50RDNvvKbrEnUAkdOEDDvcO0CpjcwxwW9gHBAC7IB8yq1QhzkHdIkoiV3ypJ9HTwK6RJPu8PA7N3dmlIMTxGxny2iOke5hPg1ZfclRfAtulh2SXwO4kyQ8ukOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA4WvHdTix9qomEizpgF+0lTXVlKeQWXXZtEdnYd0+4=;
 b=ZHG+dVTmFDfTEwdSFdl/QQaI7Brqiu6Nj8oA93fnFuvwinEuTwuuLfwKGZ7BU9RitPiiekmST6ldX8bbbWyyTaifsyw+XrJapdNGi4KIPzikIec2cQD3XYes0wheQZ+9lolw772nP3og8YUbfu/wfLKa0b0M8wHGZDNVdYnfcBhChat3P0B4zuB2Rr0mYFNfK32OcSQPZ8XiNUv4Jw6O8Pj23xc0Thz4QckzlRnV0bBglE+i3stFPg7gMjASHQGSRfChDcBQhDMaYp2L1pgk/UZPw8BPT65kT0B+yF6J1+aHPYaKZJlpI3gYqtx+BILx8/ObBS0PewiSvIrb+3Q5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA4WvHdTix9qomEizpgF+0lTXVlKeQWXXZtEdnYd0+4=;
 b=ayJIeXL2vjM0Eh0bkHsRsW9F7+5uO2llvDt9iDpp7UpJ1LghVo9Vj4+nJDX/9UkN18XWhU5q+uzf0UMc8xauLamM0RiNTBGN7nrkX0c6se4xy2MplvtUSIlUfto7x6rQPmhuPOdxz3t7/glZMWBkASjDXfEyKF6C5ULBSo7aL33pJjjmllwyQ7t3bte+zeyE0H9kloUZp4c+bcwZbIdpT11dfy24Uz2ifdeuoKZMfDotACqp2J0RcsMNawW/sQPEgt0lDI/PmzbnAI69DL+pn+yPS9F/eGEX0s6aMW63sgmGMXKwhbVqwHXRMBoGSsNq6ILALiF9bcSnw8mW05eX/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 07:34:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 07:34:34 +0000
Date: Fri, 30 Jan 2026 08:34:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aXxfBnzs5Xnwm8PS@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com>
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 92acd670-9999-491e-99be-08de5fd20343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ov800oM5DagO5mz6P5CzRpFR8KNvCJ65B8qhmTU3vu9Qybj97f2AYlcNn+Nc?=
 =?us-ascii?Q?svGcP48oVXqazgrHntAI6UocBiCePJ3pwQu8b15VuyQaIN3sWdvNQfC0OTTU?=
 =?us-ascii?Q?4tPAKoP6y0xIlo2u8eOfvt95s3y9GishfC+afkTXiFO6iWvQIcpCwq+tXqt+?=
 =?us-ascii?Q?ldVz6xnQc0qQOO7/B8oUQOuT9RQnZlwBFBp8pZCd7+GaLPbsYYJtktvCZXEG?=
 =?us-ascii?Q?4WMiNFnRil97okaoluJTu9QrrP8/jQhMtcMX1emoBRe6az6YbgOzi0Cf438B?=
 =?us-ascii?Q?G8T862ISwQKwJoWa7651AQ83b0CDwHPKqqH1vnVWFYPvwc0Ghb7qxQyrSlKt?=
 =?us-ascii?Q?cT7hqQVUVuhyjm7C0EAn1glIWMx7BdeyYygxzn7AVr0XG8pXoks6agDN2b7e?=
 =?us-ascii?Q?5BUzCSWHP/j70zk1EmMezPgJcm/WKQOJFG7Tnkrho35fe1kGyUud6hY1Jxet?=
 =?us-ascii?Q?U9v+eu8Ygh6+VNo8HgfyInT7d5Zl9T155s8YQ+p9Pmo4uAhPV4Sz+oZtRiGr?=
 =?us-ascii?Q?sPntc09md5PTfZwLb7mLsRvjQlb5k4oI8GtsAcFsBcMRn2ZWsY2tUqqYwQlE?=
 =?us-ascii?Q?trw7Mqm22ulBuNoocnMvhGAbyESgi5bnPGLiANu+bhP7Cd7rd0V8vt18tVgd?=
 =?us-ascii?Q?b6WwCKKc9T45qIHBca7ac0n//He4sdcUfAbe4Y0NW0Ea4IPX2Ce0yu9lF6rd?=
 =?us-ascii?Q?thJpqQ9spI2qclob7ilBfft5x9iVinnrnwYZxXctXpASyMpNIDUOHjPcw2Hi?=
 =?us-ascii?Q?TJCqy8K8vH0viO1xUl0d+CPecr+xH/WwUmHOjJGV9eRDThbOSiCvbTAn01Vx?=
 =?us-ascii?Q?pMQdAEy721mJ3VCyon269KGt3LGT8myR62X9R1VhUuRFLP+UD76VWWHgQSDl?=
 =?us-ascii?Q?FD21rKGO8QViPViB9/6jplUBfszUPws5CyTgmb6dUWs7eX9f7TLOE/vn9zD4?=
 =?us-ascii?Q?M7+/HXZMHvLY7coiZPFgljdfQ8vGJ7Rc60pAG0Q5mYuIe2e+XEEnjLNE4CSq?=
 =?us-ascii?Q?U+XVIPjUzFKMNjv7kbBZxIxeyivxZcN1jy+w3KoUdQx3khuO9pI5LBEB870z?=
 =?us-ascii?Q?/fHf/lxSpnnqBac1qXoxaJBeUgIVk9sP8HjAQwkcPcN5qpKC2wHuq9yp2Dng?=
 =?us-ascii?Q?ZK9wBZacJK4CgGtvwWQ3o+Nx90n5/UW/FPbDSkYdqEQX6z4CewYc1fo6QipN?=
 =?us-ascii?Q?LKMlZV56uj4c8Nl8dKWIxc33VA/3wZ47RoI3fSI/CXfiYFQn/cNuriLRa82o?=
 =?us-ascii?Q?j2cXLUB5Gh6k7qgv3bmEms5i5I6JHCP2Y7QrBP71jHclHUE3kuWj1YSf805w?=
 =?us-ascii?Q?ekXnn2tS+sRKpaTiDw5uDj4LBJHcFdiwbfRGxdivu5/iBTuQ+L6OK1TqCRK/?=
 =?us-ascii?Q?SV98bbjwB6HOKbN7F04kSHFviri1tIsK8prHjPq9nIRwgxQ2EHVSqPcIXYq3?=
 =?us-ascii?Q?YNRlpOQktCjp6taaddbiTwbb2HoMe09N4HK0vb0p3Kqdo2ehV2Hpvw11Wk09?=
 =?us-ascii?Q?OPIBCl2WsAzGf9Eicp5RnfQ6eWS7prSehS10rYeUk+lRNTryk2dAGXElNYQY?=
 =?us-ascii?Q?nh3ucPO4Ajo9pob6LhU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGZmt2hmc9emGq60F2ccg2jXJlZWFCtiCxv8EJtBlnrFY/UNyzKV/VFa0lfA?=
 =?us-ascii?Q?hT7ncdUz8TWy1XRrMNCag64Anfl6Djt0pByH6TlaQPHmhQuAv4bldnXjC5w3?=
 =?us-ascii?Q?Q3sOibbaTNnpQX2SOYFWksxoJHy7K0jx/hT46hjmkMun6MKtM/Rh2lPDwVMs?=
 =?us-ascii?Q?Qs4Jyg9jkZFKwHOzftC7vWvp+Y4BnDhwr6ZloLNs19Vn3eV9LOZMOhVbVy2Z?=
 =?us-ascii?Q?HfWwTaLaBAVtAoccfkmrZvF81AO/fDOTsnpVw1SSXK4sxpD0hAZ8RnmHI3tt?=
 =?us-ascii?Q?3lJXAicedVBZ0vIO3Wgvae0fNEZt7xScPHk0ywIeKRsguHOgsbj76/uKEaik?=
 =?us-ascii?Q?Kl3PH42UmWCSoTU8RALU+l1rx6Dtk9QLAtOtkzR3Dmgv6tqxyp3z6+q42QM3?=
 =?us-ascii?Q?B51Pl57eNM6hDYWR+8hJNr08g3ZGSGbij5V7Zi+3DCq9jkhrJjwnOnHvJ1cD?=
 =?us-ascii?Q?aZHrBoDED5WVO90N4sh8dC7bpxgTIThTLK9iLNoudQaL3XYpvhlrrzS6vZOc?=
 =?us-ascii?Q?VwCvNPrABBEEmjwuZ21NjXy+uNahAOT45mULRucJIp0bQfI0jWIzds8Gg5ui?=
 =?us-ascii?Q?ZoMbYA2POBFbj2eYeeiicmmst+zSdTunQ5K7BMREavRKXMC5HN/AGhILgEp2?=
 =?us-ascii?Q?Cu+jEn74LfxzgiJdx0U/VhKkKSXexNPZpx0xBXu7zMgmPHJcIH45nj7+q0ap?=
 =?us-ascii?Q?MYUk7ksNQf2osMLyt3Am+1h75TjFi1R75yklj5NdaLn0XC9bzhTBVmKO9KEq?=
 =?us-ascii?Q?35liz/SWGG93CmerhRrEj2AinEvRZlkyKa9psoGhJwG0CnUUqzolBUHTbdRZ?=
 =?us-ascii?Q?DpwHUaspWyNRuJW1kWTblqv+99P4h4GY7JUD6t1SHWT1mWaLtsRB3AMAC0gE?=
 =?us-ascii?Q?yVlMf9IeQKCibVpGweL6vRM5ACNo4ygTdbWhYckarJTEXl8TrrBuF1wJGEAw?=
 =?us-ascii?Q?T3pHkEtol3Hz9IapkouFO0+eNLIyit4l2oRWCyQU2/gsV5qrJVQtyBb+fQ6K?=
 =?us-ascii?Q?L17l4Ik2uOBBoMI0d5eNWeSj0hMpStSt66CGDcxa17rRXbxKfClFONTOALxd?=
 =?us-ascii?Q?bF4uLpBOP8OBLtTYIy9PaKoLieKOLzJy/fVQcwECs228h5/a8yOqMC9OxCpK?=
 =?us-ascii?Q?6Lg0BdO4f4g7pNcm0Flqfh2FIElKNghh47bB4rjY0yhHnuHRFnCZTll5F/zq?=
 =?us-ascii?Q?CwQgQ8n3Y0nNO1DS82IJhfc73ibc7RxbVGYkBsZGhikDU5AWFsKhAWL+2sxR?=
 =?us-ascii?Q?NYhtG/aA0mXxXRhY7z/j5CaXAXKB/vakiz/v9IEm30ccIl3VofLVDiEwyTZm?=
 =?us-ascii?Q?kADiSvY5ZAFD+13URyBJnZIzhISSejjgq6Z/GGkAkCCK+7jGZUendhZrr22A?=
 =?us-ascii?Q?+2CxaB+iqhmp7BMZdEj+ofPGGMdV5WNtRaGcJ0LtTygFXG1964HVUze+acsv?=
 =?us-ascii?Q?CRwx8HAYpfgfR6R7ZQgthJvrtcdw3csqpoQSTfltRP1Xjv6v6FoPkfY5bnKR?=
 =?us-ascii?Q?9SrvpB53WLfjwzHRBgtLbo6pMTwb0MQ4IrftVQwHgy8ikHwx6ReAEV6zzrFI?=
 =?us-ascii?Q?DtE0oslUN2Fa5fnljEgCiPIhRSwwmad2KMfKQ8ka6xVcrWZS/9PPfvEKLyvm?=
 =?us-ascii?Q?xXoUNV+2kpWxBhn0fNiEtBQUkcUMOHVKo+O0LxxDlss8WZvzbzpztmiHHo92?=
 =?us-ascii?Q?lhjjngklygK/seHejSi4EnA/Q97+hbLiX/c35t6pdLuDbGM9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92acd670-9999-491e-99be-08de5fd20343
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 07:34:34.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u76+qCAYdXTv5p7n/TwcBtnw2p/5mVT6Btk0m9nNaB7HBN8pvSizbuyQdzL4558khlEbIAyC6BE0CNasxgxUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653

Hi Kuba,

On Tue, Jan 27, 2026 at 04:41:43PM +0000, Kuba Piecuch wrote:
...
> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> > index 404fe6126a769..ed6bf7d9e6e8c 100644
> > --- a/Documentation/scheduler/sched-ext.rst
> > +++ b/Documentation/scheduler/sched-ext.rst
> > @@ -252,6 +252,37 @@ The following briefly shows how a waking task is scheduled and executed.
> >  
> >     * Queue the task on the BPF side.
> >  
> > +   Once ``ops.enqueue()`` is called, the task enters the "enqueued state".
> > +   The task remains in this state until ``ops.dequeue()`` is called, which
> > +   happens in the following cases:
> > +
> > +   1. **Regular dispatch workflow**: when the task is successfully
> > +      dispatched to a DSQ (local, global, or user DSQ), ``ops.dequeue()``
> > +      is triggered immediately to notify the BPF scheduler.
> > +
> > +   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
> > +      core scheduling picks a task for execution before it has been
> > +      dispatched, ``ops.dequeue()`` is called with the
> > +      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
> > +
> > +   3. **Scheduling property change**: when a task property changes (via
> > +      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
> > +      priority changes, CPU migrations, etc.), ``ops.dequeue()`` is called
> > +      with the ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
> > +
> > +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
> > +   regardless of whether the task is still on a BPF data structure, or it
> > +   has already been dispatched to a DSQ. This guarantees that every
> > +   ``ops.enqueue()`` will eventually be followed by a corresponding
> > +   ``ops.dequeue()``.
> 
> Not sure I follow this paragraph, specifically the first sentence
> (starting with ``ops.dequeue()`` is called ...).
> It seems to imply that a task that has already been dispatched to a DSQ still
> counts as enqueued, but the preceding text contradicts that by saying that
> a task is in an "enqueued state" from the time ops.enqueue() is called until
> (among other things) it's successfully dispatched to a DSQ.
> 
> This would make sense if this paragraph used "enqueued" in the SCX_TASK_QUEUED
> sense, while the first paragraph used the SCX_OPSS_QUEUED sense, but if that's
> the case, it's quite confusing and should be clarified IMO.

Good point, the confusion is on my side, the documentation overloads the
term "enqueued" and doesn't clearly distinguish the different contexts.

In that paragraph, "enqueued" refers to the ops lifecycle (i.e., a task for
which ops.enqueue() has been called and whose scheduler-visible state is
being tracked), not to the task being queued on a DSQ or having
SCX_TASK_QUEUED set.

The intent is to treat ops.enqueue() and ops.dequeue() as the boundaries of
a scheduler-visible lifecycle, regardless of whether the task is eventually
queued on a DSQ or dispatched directly.

And as noted by Tejun in his last email, skipping ops.dequeue() for direct
dispatches also makes sense, since in that case no new ops lifecycle is
established (direct dispatch in ops.select_cpu() or ops.enqueue() can be
seen as a shortcut to bypass the scheduler).

I'll update the patch and documentation accordingly to make this
distinction more explicit.

> 
> > +
> > +   This makes it reliable for BPF schedulers to track the enqueued state
> > +   and maintain accurate accounting.
> > +
> > +   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
> > +   don't need to track these transitions. The sched_ext core will safely
> > +   handle all dequeue operations regardless.
> > +
> >  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
> >     empty, it then looks at the global DSQ. If there still isn't a task to
> >     run, ``ops.dispatch()`` is invoked which can use the following two
> > @@ -319,6 +350,8 @@ by a sched_ext scheduler:
> >                  /* Any usable CPU becomes available */
> >  
> >                  ops.dispatch(); /* Task is moved to a local DSQ */
> > +
> > +                ops.dequeue(); /* Exiting BPF scheduler */
> >              }
> >              ops.running();      /* Task starts running on its assigned CPU */
> >              while (task->scx.slice > 0 && task is runnable)
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index bcb962d5ee7d8..59446cd0373fa 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -84,8 +84,19 @@ struct scx_dispatch_q {
> >  /* scx_entity.flags */
> >  enum scx_ent_flags {
> >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > +	/*
> > +	 * Set when ops.enqueue() is called; used to determine if ops.dequeue()
> > +	 * should be invoked when transitioning out of SCX_OPSS_NONE state.
> > +	 */
> > +	SCX_TASK_OPS_ENQUEUED	= 1 << 1,
> >  	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
> >  	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
> > +	/*
> > +	 * Set when ops.dequeue() is called after successful dispatch; used to
> > +	 * distinguish dispatch dequeues from property change dequeues and
> > +	 * prevent duplicate dequeue calls.
> > +	 */
> 
> What counts as a duplicate dequeue call? Looking at the code, we can clearly
> have ops.dequeue(SCHED_CHANGE) called after ops.dequeue(0) without an
> intervening call to ops.enqueue().

Yeah SCHED_CHANGE dequeues are the exception, and it's acceptable to have
ops.dequeue(0) + ops.dequeue(SCHED_CHANGE). The idea is to catch potential
duplicate dispatch dequeues. I'll clarify this.

> 
> > +	SCX_TASK_DISPATCH_DEQUEUED = 1 << 4,
> >  
> >  	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
> >  	SCX_TASK_STATE_BITS	= 2,
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index afe28c04d5aa7..18bca2b83f5c5 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1287,6 +1287,20 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> >  
> >  	p->scx.ddsp_enq_flags |= enq_flags;
> >  
> > +	/*
> > +	 * The task is about to be dispatched. If ops.enqueue() was called,
> > +	 * notify the BPF scheduler by calling ops.dequeue().
> > +	 *
> > +	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
> > +	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
> > +	 * Mark that the dispatch dequeue has been called to distinguish
> > +	 * from property change dequeues.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
> > +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> > +		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
> > +	}
> > +
> >  	/*
> >  	 * We are in the enqueue path with @rq locked and pinned, and thus can't
> >  	 * double lock a remote rq and enqueue to its local DSQ. For
> > @@ -1391,6 +1405,16 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> >  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> >  
> > +	/*
> > +	 * Mark that ops.enqueue() is being called for this task.
> > +	 * Clear the dispatch dequeue flag for the new enqueue cycle.
> > +	 * Only track these flags if ops.dequeue() is implemented.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue)) {
> > +		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> > +		p->scx.flags &= ~SCX_TASK_DISPATCH_DEQUEUED;
> > +	}
> > +
> >  	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
> >  	WARN_ON_ONCE(*ddsp_taskp);
> >  	*ddsp_taskp = p;
> > @@ -1523,6 +1547,34 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  
> >  	switch (opss & SCX_OPSS_STATE_MASK) {
> >  	case SCX_OPSS_NONE:
> > +		if (SCX_HAS_OP(sch, dequeue) &&
> > +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> > +			/*
> > +			 * Task was already dispatched. Only call ops.dequeue()
> > +			 * if it hasn't been called yet (check DISPATCH_DEQUEUED).
> > +			 * This can happen when:
> > +			 * 1. Core-sched picks a task that was dispatched
> > +			 * 2. Property changes occur after dispatch
> > +			 */
> > +			if (!(p->scx.flags & SCX_TASK_DISPATCH_DEQUEUED)) {
> > +				/*
> > +				 * ops.dequeue() wasn't called during dispatch.
> > +				 * This shouldn't normally happen, but call it now.
> > +				 */
> 
> Should we add a warning here?

Good idea, I'll add a WARN_ON_ONCE().

> 
> > +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> > +						 p, deq_flags);
> > +			} else if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC))) {
> > +				/*
> > +				 * This is a property change after
> > +				 * dispatch. Call ops.dequeue() again with
> > +				 * %SCX_DEQ_SCHED_CHANGE.
> > +				 */
> > +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> > +						 p, deq_flags | SCX_DEQ_SCHED_CHANGE);
> > +			}
> > +			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
> > +					  SCX_TASK_DISPATCH_DEQUEUED);
> > +		}
> 
> If I understand the logic correctly, ops.dequeue(SCHED_CHANGE) will be called
> for a task at most once between it being dispatched and taken off the CPU,
> even if its properties are changed multiple times while it's on CPU.
> Is that intentional? I don't see it documented.
> 
> To illustrate, assume we have a task p that has been enqueued, dispatched, and
> is currently running on the CPU, so we have both SCX_TASK_OPS_ENQUEUE and
> SCX_TASK_DISPATCH_DEQUEUED set in p->scx.flags.
> 
> When a property of p is changed while it runs on the CPU,
> the sequence of calls is:
>   dequeue_task_scx(p, DEQUEUE_SAVE) => put_prev_task_scx(p) =>
>   (change property) => enqueue_task_scx(p, ENQUEUE_RESTORE) =>
>   set_next_task_scx(p).
> 
> dequeue_task_scx(p, DEQUEUE_SAVE) calls ops_dequeue() which calls
> ops.dequeue(p, ... | SCHED_CHANGE) and clears
> SCX_TASK_{OPS_ENQUEUED,DISPATCH_DEQUEUED} from p->scx.flags.
> 
> put_prev_task_scx(p) doesn't do much because SCX_TASK_QUEUED was cleared by
> dequeue_task_scx().
> 
> enqueue_task_scx(p, ENQUEUE_RESTORE) sets sticky_cpu because the task is
> currently running and ENQUEUE_RESTORE is set. This causes do_enqueue_task() to
> jump straight to local_norefill, skipping the call to ops.enqueue(), leaving
> SCX_TASK_OPS_ENQUEUED unset, and then enqueueing the task on the local DSQ.
> 
> set_next_task_scx(p) calls ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC) even though
> this is not a core-sched pick, but it won't do much because the ops_state is
> SCX_OPSS_NONE and SCX_TASK_OPS_ENQUEUED is unset. It also calls
> dispatch_dequeue(p) which the removes the task from the local DSQ it was just
> inserted into.
> 
> 
> So, we end up in a state where any subsequent property change while the task is
> still on CPU will not result in ops.dequeue(p, ... | SCHED_CHANGE) being
> called, because both SCX_TASK_OPS_ENQUEUED and SCX_TASK_DISPATCH_DEQUEUED are
> unset in p->scx.flags.
> 
> I really hope I didn't mess anything up when tracing the code, but of course
> I'm happy to be corrected.

Correct. And the enqueue/dequeue balancing is preserved here. In the
scenario you describe, subsequent property changes while the task remains
running go through ENQUEUE_RESTORE, which intentionally skips
ops.enqueue(). Since no new enqueue cycle is started, there is no
corresponding ops.dequeue() to deliver either.

In other words, SCX_DEQ_SCHED_CHANGE is associated with invalidating the
scheduler state established by the last ops.enqueue(), not with every
individual property change. Multiple property changes while the task stays
on CPU are coalesced and the enqueue/dequeue pairing remains balanced.

I agree this distinction isn't obvious from the current documentation, I'll
clarify that SCX_DEQ_SCHED_CHANGE is edge-triggered per enqueue/run cycle,
not per property change.

Do you see any practical use case where it'd be beneficial to tie
individual ops.dequeue() calls to every property change, as opposed to the
current coalesced behavior??

Thanks,
-Andrea
