Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F427B32C
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403558; cv=fail; b=hIEFj6ngJxROCIunKsr/P77PaJ+Ocw+UQvJzF3HQfNHYXSNJyYyZxtAuSEgbaW8q4lK6MvNtX6JBVt4jCeObQu8JXr5c4Lwik0p3Bn5ERm6YkMqpV/OFrDc2Po3b6Hpv/QLcJa+Si64ox2SwYJQZXYnTmrEm4VtrST1WhbVDQ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403558; c=relaxed/simple;
	bh=lBwwRGrLkn7WstVeIgLwSVejULYj5bByy6JSubCPaBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTt5ViI3oElPo+0riGV7f4MW3YLWr6oSbSBxQctFD+QmCkLR6pNmuh/MpmGxRguxQHn0fXCmneswNNYeFAP3lMXkTzh5W0u5+rbGNvOHSAtGvCK8idWW5QbK+cf72j7AokmOwWGaPavlfuysny+s8ChrvimNFbQlBs54nKyQF3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7cMpfoB; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7cMpfoB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2awI9bly75BoMgLilp72b0GkmCv15rZcuFniRidnMdBwWQgkadPvCfdJACtALPAlH1uAzlytytJCikcVkTlQEH7IgT+Xnis5tMTtAnToPSStNdwoY3Q1J1EL3GmKIuNxFsIX2gc0Qv1yTmQzxECp78qg+qx3sG9Oh3Cqgr5IJFhpSzLiyDpLjMlh/zwDLYI9aZ11fnY6AzKSilEP+Mz5/JWImtOdGGiixlCSltllKR9BA9i5PwaBVDNfGYDNRm2p9tCfFQ+bl8i53eICsN98sPYkY7M3PdwNcO2ATtKCsgcxCjxfi6AzwomfNnEqWZz0zdZAu5xXfMZHAdQI2qzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+Kas+rMRZjkRKhYhluDltAlSxI9KiqiMrLQfRfGRP0=;
 b=vKOoIMo32iU7ZAnAHtuHC9WcjHVUpHTWEivCCzuiqykH0q9OhfBuwQ545QmaO4l8LHXawrBtBmfNenBNOMrfHouYSIOWaTJ+GRuLJCsA748S+4f+VTzYezjOCdG8kUSAtN/oiybAUqsfsPWy4910lKvj/4P0HEJqLO+l55Cyfju3/nkCicj5Ph3iLX2QkMnQ9UuOYpy/5pVVT0yzXZn3VZXPK0+xyUVVkAgkFh2HIbOthgvSUzH+cYwpis9rv200yAZreii6scv6mNkT6xQFBbpZM/A+ixC08z8j7/TiCTvVb8tTFyRRQV5CSvee9xANIn0Hqt0goZG6pUwI5YHpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+Kas+rMRZjkRKhYhluDltAlSxI9KiqiMrLQfRfGRP0=;
 b=e7cMpfoB9ybvhjIc0OTRDjRaMSYvASgMD6SB7jBzO5lKS7PSEYYm6gNL2NahxSKhSEi4xUUjvGuBgaXC0knVDTkEDv/kOlbErNlofqltr/eBh3gq+Sof4odVt3AjRRl+Oi9/oIudnnyycCVfLdtB9+PalSO6MaYTH9hW9OCPHhMSVU7/a6acLSQ/2DbtT1ONr5l73IRL3e7w7nXZQ1eixa/GXWTSop92AVL+4II9NI6PjIkbMOs02xtFb2i3cBX0k+0n5737Y8K6npI2UZ1BbFfhxtmUE9N9QSGPbRvGePGtwAlmhOtdA24aaTzpfnm1s1NTtCrjOo9W2eoHCt014w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CHXPR12MB999222.namprd12.prod.outlook.com (2603:10b6:610:2f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 05:52:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:52:34 +0000
Date: Tue, 7 Jul 2026 07:52:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Enable tick for finite slices on nohz_full
Message-ID: <akyUGFsa8kJt0Lim@gpd4>
References: <20260706162819.650155-1-arighi@nvidia.com>
 <20260706162819.650155-2-arighi@nvidia.com>
 <8bac2ab9236ec0c6db28debf4bf5157c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bac2ab9236ec0c6db28debf4bf5157c@kernel.org>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CHXPR12MB999222:EE_
X-MS-Office365-Filtering-Correlation-Id: 425b83d8-fb71-4044-90e4-08dedbebf0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LNZDc6lqHRJH4V15spTenlAA1CeHlp73ihNwdDFlWH6OO9D62oT1EPTwHXDkaxkKQ/y2Zv1h452h8bYCxmrmkjPGgsqmWUuWLPUobwdeSKmyqtsreM4fkzorqeUZCP2rXLCaSjfIWkXFfhrUFklE0WYnW0Yq0iE7C1HaN6JE8DpvL5yRv+cyjVlgqakX8UufUhZpCKYpTfAtsyqYiaHbA4FMx4txj4AbYmN1hXyJNuNdlDXVor8psIhgw2SltF5IB7HZ57oSIw10sjOGxQLNDgOTDBjo3f/pNnz9r4B7HyM6ew666557hHAm/O68b0nv0GQDIHicgC9ou+QxVOHUTzLUkLOLNVcX7cayf9e3m5gGJauZY1KAXSJpNZnwqndSjmoC1GiSfh8nU557iBJO6AM24rWj+qRTmtZK+PkOTdFMTxpL9nTKsLA1YZpzmCaq3UZNnglU+6egV5dA/DdJD31Oc6eZNX9U6NLrtkuuSJIfbXC7LgIrPjEq596t6Be1aOaaQeqNudj8Y3klNLvGCfZzKrXiF+dW/1HdMaU4GpTaEKSVEyKhPpyv5WqLBhN2h7rKahEuStR647uhXAB4pONhHHp/7f8KoBqQYNUpSbx+yvLkcgVhdM3QDX1YD6b6O1qh//6+ku7/bVquM4TLqkxHnvhqbMaTi7PwKZ5uhYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVMB1ETkhMGDWTlP6Y3VE+E2gp4PhpehW13svxkQv1XQoihmPi9KrYWk08UU?=
 =?us-ascii?Q?LvFgub7FYokIhLHWifdUM33AtcXhY/FarxqG/ikt3/eKlPglIpQNC8hMSlzv?=
 =?us-ascii?Q?yq6NhxwRkvag8wOQSaV+y8filONwLAQ2NCjLbbw/csxlzd1WvMcOTh147uem?=
 =?us-ascii?Q?ZS73hX/ZtIfbms0vuui5zskEnM5IwDDaPfk5GPEIFj3EpWusgZ3tV7dWRP4v?=
 =?us-ascii?Q?h9O2LzAr2vo0gl0QmouoDoqzZaq9UAwW84BducW2vcavV4P94lmEIGszafJq?=
 =?us-ascii?Q?l3p0/Xdpn7LmQesh+8jBp0/Z7asSmpzP3DTdlWDg4VPYPNGxuC4R+09CexNM?=
 =?us-ascii?Q?dS+iazSw3iZGOgovuVGVFAjzLZKwS6cH5uL9Q7uHXLokOAkCIQacz/E+NR5n?=
 =?us-ascii?Q?UwdoYcVp+/ss6udy6RKLClLGuU7vTLQN1jUMFmWkXlw4J3qZuQlBl7wjdxHm?=
 =?us-ascii?Q?9SV7I9qHuXI4TBo0Z70jElBcxLl4Y60jux0MM5rd3z3IuI3E7Fo3adflIqLt?=
 =?us-ascii?Q?Nr1x0BvtgVu/0fWjpXHp/9NmB9Os3SyERk/RFD1fwDIE9tdoOGVkm2Di5ddR?=
 =?us-ascii?Q?EIAnfzwIJZz1U8bYlDy0UtKD1rdckij6YKpMdV150fdNIo4ZSArgZ4BApyXu?=
 =?us-ascii?Q?yWLAyoC6MaTsE2GYRuaEjWh3k5kU5RcMk3q0rsBQocAIyZfSctXs+MPHBMTy?=
 =?us-ascii?Q?a+sLAMEnM6aQcS5C7yE5NVFcNeZKk8aiFJz+nduV4ALT1vMHg32NtkQKlX3n?=
 =?us-ascii?Q?rWEcB41ix2Gf+ZzCfVhVWS/2lslx+gNlrRdAKl7MCN215ETM1Y2OkhTAQiAI?=
 =?us-ascii?Q?Qw0UilVc47amEvQnAddXKPFMtesXan/YKTe+mRZRo9er34oq2ZK9i/OxvAU1?=
 =?us-ascii?Q?fiQluYIEG9SlMShKopnM+OcWG4ulTS5IuqjC0tWxMM4/acAo5YLGPsyMhGEd?=
 =?us-ascii?Q?uUSScOruJHC7JDn1PBucdV94RriU/pCcRdvUVF3OGWmLJGqXuowfSb1DePD3?=
 =?us-ascii?Q?XWMAYeHrJdVZik/OBV8p8kkwXWU0xT/e4Z6+br5vjIOpvZcHxuFHcu1kbKYe?=
 =?us-ascii?Q?pt8EZ8Y0mT9MHPFF3O32HFdjbVPKV9UdI/lH2IU7Az84zYt5MMxqrl7fZMNB?=
 =?us-ascii?Q?gYO/g+XFfD2BEANk8kH8MtRb/bpSRi0CUtWgZk6c9ttUkoPCfpcNJRYCnSGe?=
 =?us-ascii?Q?LTT89tLEbelz27ORK6l3hVGOhIQF7fwFJy9goFcE7g5ZYFb0/oGkCW0f35P5?=
 =?us-ascii?Q?oYn2U8IsDaTW/yRo2SSIOCAeVeojR+k+mZMmAorN1cXuxAuMoMmQMFDapA+e?=
 =?us-ascii?Q?xjTeqOa4HGcO+5GYhDa/BwtyThPx6IpiSOxplLoNQ7G4dJ0nHxzzNyz0aI1r?=
 =?us-ascii?Q?ijyvuuRnyi29dihJYnJcnUZs9PRCSm7SLJdGWiDKFWeXaFOFMy/sCb5MPtn8?=
 =?us-ascii?Q?qrlqPiMw1r+FUVRwh2O/XvsQAM7k3vaO7FW/D24NrbcC3kk8ME3d7N23JLhZ?=
 =?us-ascii?Q?iFoFQQ15tiQ40c2xpzq50Ubw9zno4VABrdfDtUg/Yv5zoR9VZP7gd85/oD4T?=
 =?us-ascii?Q?Vuur+1Hf1UsLSZHgJfLL49HGQmykI/B57uA2CA5dPinq5mSIPacfqHLU8hUn?=
 =?us-ascii?Q?le0Ow555Tm9MeN2slG0m81h897DaArMpOHca1XQZ+Hv6D2p8S+qBdzujM/+H?=
 =?us-ascii?Q?WGV4rYi+CZzsJj6W085m5xW0X8PwTSufhVrcjrfcnpYxvkUsKtr7aXAReioD?=
 =?us-ascii?Q?gUjYE14CkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b83d8-fb71-4044-90e4-08dedbebf0d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:52:33.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oJdr+kYz11Cxbu1HbACWO8uesWCOfoG+etxM62FbOgVI6UIfqfysurPOOAnt0UhH3NOmjFm/9BzODFpk9Y1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999222

On Mon, Jul 06, 2026 at 12:09:36PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> Sashiko's first point looks real to me. The fix covers infinite->finite,
> but a finite slice landing on a nohz_full CPU after idle has the same
> issue whenever the previous run wasn't infinite (finite->idle->finite):
> the enqueue path already cleared TICK_DEP_BIT_SCHED against the idle
> rq->curr, and set_next_task_scx() re-asserts only on a slice-type
> transition, so with SCX_RQ_CAN_STOP_TICK unchanged the tick stays
> stopped.
> 
> set_next_task_scx() knows the incoming task, so it can assert directly
> rather than keying off the transition, like sched_fair_update_stop_tick()
> does for CFS. Moving the finite assertion out of the transition branch
> should do it:
> 
> 	if (p->scx.slice != SCX_SLICE_INF && tick_nohz_full_cpu(cpu_of(rq)))
> 		tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
> 
> Can you fold that in and add a finite->idle->finite selftest case for v2?

Yep, I'm currently looking/fixing at the issues found by Sashiko. I'll send a
v2 in a bit.

Thanks,
-Andrea
