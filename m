Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8223D291
	for <sched-ext@lists.linux.dev>; Mon,  9 Feb 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651812; cv=fail; b=RIQ7wucs034xuBPdesYgrwTtwa/hASpss7mQyl25INlT1+fkcdDiQ4clzLa/SHt9JJET/K2d+pP1U7UwlnNulPOZV458stKBcjBpRPCfZ++RQcd2aWDI39z2TLcqvII66ph9MDor5tuPNpbxKnWyfJgMUcNJoE5j/Fzif13t324=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651812; c=relaxed/simple;
	bh=1cse0JISgJubpoqURsB0UltNoi3xElLfEbKbfcFC5Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDVzxxeH47VMBgMigqb1Iy1JOIVTV3SNa8m4iJqZU1ANbcCeX+W4+cEDi/537lmpS0jsrq2kDgYRK3w43GVzpJ8ohT6QEVx5QPP2KPRfwuY15UyolsHfhFD/LFlK/PUzkuWTUgIZaKWizogPyxlWHtWDSg0ru/HB038DUGaZIgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c9jYpT78; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c9jYpT78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBBThhHrWmyNtF1Kbh42/G8wXJjhApXEW60YSCEibLQMquhXDA1rYTQ/DQdQkaKFjZp0oly/Cq4QmLkUSqGKnH2OsZYkI4Yu0RihdakkbaMEHJH7jK0scjmYv3B1dh3VIa65CvITsdAwjlJdFDbQOfogn6F48CqGblWolXmeA9e/6kyO6X7q1b9RrfGx4jqdE6vEN4PK5pn1zPbrsuGHhktP0EUwXKuR4FxLwZdmGmc+YXgkb7yBKfJfLqTdjrdyy7MXD6pLFb6bawOT67bB/ZYcWYo403Mo9jSmsqFaRTYoIMHsokBtZ7voDoMkTkkDqovSaT72HdppcF3SBYTcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUWjgub2yvpVolyeX7dCDSea0nq4W0obKOuP5YUrwfw=;
 b=uvlGOgaOUH6ZCeIg8p+cHzMrcgq1HovZQudh3aYoAzPYMvUVSD/G6FaF2k8ANDC85IADmKQX1tWHkaQFpcym183zxFOlC6MlIQJHfSE1CPUkiinJ3xIg93ZSwop3ezmjiHboLVuMkFlCpVROuu934STdJeI7feRZgS9nZD8cwOv5dIhcHquTXZvWN1iK1PtY0ziZedZul9Qqq5wymuqPWqV1qFx1tUnb65xlblDZEGLxUKQH1H7dRqkHR+ozLYOMRqwtDxWz1clpA8mWFx1Qo3wfYgEmMsuIDV+SS/5E+ddqZ6XMr39MKHWI7adOaP1E6j7lI+xk+qvsqqg6gW9NhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUWjgub2yvpVolyeX7dCDSea0nq4W0obKOuP5YUrwfw=;
 b=c9jYpT78Q3pXSpfnDPOO0aayg1MgEMWx9pHLFY565FuKOnk2kZXTwf+oKIqnmDqmilT8FGqJoQm7qWKuAHmRIz3s1Du6hf44nfPVs8esNt3eTfYC3432N4DTWBDqMh5nCSNQ5sIk+MBh9eU9yFjIcqTtQ56cRXCaafcP960Eg9srclsDXRRHgtY4y/DILEng8h/Q0sWDJ7A1TCuJqVZ2ly8oXDK6+vS0IP5a72cne4LIvERW5R6NFktehmDXPXRGDZf4W427YqaqorgiOuhfbsfHzfgseZthXYVHSHenxcdHYkewZHBGx65OPii0XBi1y2y79r6M4+UL72LlOez/rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 15:43:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:43:27 +0000
Date: Mon, 9 Feb 2026 16:43:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYoAmES8tKNZJkdx@gpd4>
References: <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
 <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
X-ClientProxiedBy: ZR2P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab33fe0-d891-45b3-3414-08de67f1f7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|19052099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lGIuHVKggSzu/6FOZlP2YIvzZEbNSSs6rsVFLDqK+oAB2/xS/Wd+f/I9FDH?=
 =?us-ascii?Q?t1VBGs+twWouzbncJxZBKc6V48r+pNvpqlQhxUf/2eYDSMGfQUwt0jwp8489?=
 =?us-ascii?Q?ldooHOI1szwbwJea46q0o9IHa9jQ9V8E5dSlsM4JoThfI19UQ9leSIItqxq1?=
 =?us-ascii?Q?avKMqrhWPBGrsLa7AolppnjvFAlXjU5el8PvOuo1dRunUXvcPbCE6lrANlWu?=
 =?us-ascii?Q?0AajyPs720KwP+XFtc103qoxj/d2sKya/CDyuUKpXOXxf1LODs0N9R6wq1vD?=
 =?us-ascii?Q?Q/+oNCud42V8JFQVoZoywt/pCuX+3As/g+2IGN4E72uOF6TZLTi49JGknGV8?=
 =?us-ascii?Q?Sp1fVW8VGvKlgFu13bS32kQpXfFYFjeSPJ1OhPYfzqlL7VvAT+CbYJqoQWxz?=
 =?us-ascii?Q?tPCa2JIhE77+wFCnqYrE/TSrFi5E+SoRy/G/GxhqeS42NKmNneIPjoWbZCTJ?=
 =?us-ascii?Q?mm9jtRIqXOv1xshf4Oid5vznLOUAgotiB5C1qsKcsBrDBrBfb1MHCeENyM0V?=
 =?us-ascii?Q?77AU8IsLDlDi2+so0h24LyI7FNXuRyy0gCfsf9k5FyT2rAKJoTAORbJ53LAO?=
 =?us-ascii?Q?CHTizPRn+tAO8L3cj682nsPojtmdqDfNgQwJhVTe5r+1runRJ2SWogTn+bdh?=
 =?us-ascii?Q?Ha0fFajc+3Jm8G4sPgN1SsDNeStA4fAlMMcXJeGPpYuucbqSfnxY4a4zs9mz?=
 =?us-ascii?Q?BSe7iA8DX+M8gKrU7IgWNh2LxdByZlhLtWJ3tt033qCqt3mffuYmXznd1G82?=
 =?us-ascii?Q?sPxm+DZ0IyaE9oV5bMGHJCNThi0tgtnL74+dG/IJf59osNCINV9IST7tCH1w?=
 =?us-ascii?Q?1A6jBL2gjkygxhcSOQ/ztPflfcDZ++IHohckeuWCZNEOkMvZH4zIS9HtXghH?=
 =?us-ascii?Q?bO270QdfZss1K6ndbmhBU9k49SJJblqVfZ+2fjBI5Ifit2ibk3JrErImEr0h?=
 =?us-ascii?Q?L6H3CZ3XC2IS1p1sVZ1s3em9zJFS2ZRquGvbzutNSgNcrzVS9rrW5LDKLaho?=
 =?us-ascii?Q?BN/aJ2AW4csjvC9lADzWNJIcAV4dmoAwxlYkaVHz2C6kFANMai0iONGs+vdc?=
 =?us-ascii?Q?pJxNce8Vn4fENDud8ifV6oRNzE6koLcCHn4spk2wvQz/cELpj9q1xVTSooXb?=
 =?us-ascii?Q?XtBt8OvCMj2cm8oXqtIGmlGvLaGsrMZECSAxmDOUkTdxgz1DOWL7Sx3cnUPw?=
 =?us-ascii?Q?fVD+epVORzxYOA/3QVyDblZPoTrnirLvo71coNhse+nyYXdPUybS9hzzO1+r?=
 =?us-ascii?Q?vjBqu5FVcu7PWmbR+p8GWQJzx7m2c7YKp8u2snZS29GzaoR1VstOPm4KKj4Q?=
 =?us-ascii?Q?+sIh31u+Hk2+Qzoqa0Mov8V0Dwa31MLghbhUdnb/5hiPAUP7s7rr8jF4jynS?=
 =?us-ascii?Q?fivic7WvXr+WgXcf9ik/5ZuSMF/dZm2qUKntbdYXHUqfZFYy2zPrEUGSa1IN?=
 =?us-ascii?Q?tFBycnaXUE4i8RQVluae3Ok5P9HNgJikusfYwSjktn5wzTxHulHyWcbE4Gyd?=
 =?us-ascii?Q?UMTrmE7bYjjeWaVcRxBeRDbLMN4f+iUKrUDxPky1/wVAelqbr6cJBVuDS9ha?=
 =?us-ascii?Q?PGqt1Xe39hdr5MIUyFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19052099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8b4lfYEJMcS4wPOT3BLX7FqUTyyBzDIRvONTOabYe+sP6is0MC3whJxJ8LIY?=
 =?us-ascii?Q?b6IVDEiyBd5VhvDz6oEzZUz2SlHvLcnbonW9yq0RQiFzS3504DRowK1PmXXs?=
 =?us-ascii?Q?Ryqgp+ohCR54PT1vVIXAvARyqGLCSfJNn7utK3ob136OPNp7AZNfAbozMjqP?=
 =?us-ascii?Q?rsmFDJ0cgjoew2Eh3p1aF80ILqE1IbdJU60PF6W/C5pAd6g8pBj+tYKqcvE7?=
 =?us-ascii?Q?VU5XIwlnXtifFEOEiDogqgU1m8GqqYO4qjJP5/ubDRzltvHVd9B2+b17rVch?=
 =?us-ascii?Q?lenLqVjetOJV5W7bIDlek1vQIzjorWGFCGX9FOEphewnRYjFdbcKqn/BYFuX?=
 =?us-ascii?Q?WD+qEbjVhz7r5DRDQ5pngq9FxMsHoZaWjiH7yJOQdP4xzO2It7hzdwaNtRsR?=
 =?us-ascii?Q?X4TFw34ZiRM9GjDR1WD7z7uIQNpWGs/N+VUks6yrrMhe3WjM7tqFk4QZpMbx?=
 =?us-ascii?Q?ZZNvGzEe2rJieJbKTmgbz8hwTsld7nUrSsGmcVpJPHHIytzvMR0qOZgqGvVp?=
 =?us-ascii?Q?z/SAKuN0E+SXdOuy5iLi3YdyiZMuvhUYbLfkK/EPhMno3lKGAWsWlJu2qCuz?=
 =?us-ascii?Q?nEH1tnKTq9UUYscxrqIfkhAPZVCW++AHu55QXLVPscjAj72+pqHKC5qcKFUM?=
 =?us-ascii?Q?hJmqzU0DOswp//Q7MzAFiJILtD/tNPmh3Xy/CgtBApoEKxXX3gP2Wdwa0pEu?=
 =?us-ascii?Q?31OVeR7+q8GjhG48MhUKO/EoNnvh0weqag49TtwGByta9aeTi3ZPWIGqwjwq?=
 =?us-ascii?Q?RsKpecmbIKlCT3/scFc/2MXrpqNSQfd9SOhWoH+x5w8hjSgm2cpVMUghRC7u?=
 =?us-ascii?Q?eT5W0i4DYZF24U0qP7qk7TmrmodgClgjnk3Aq4h2id/Cq3Qr1tby7D3H2CEW?=
 =?us-ascii?Q?4iXbdzwX7WqBd/CkWFzDfCYiPg8im+GtU644m94yYHbkY2g96XoeDYvfWOjN?=
 =?us-ascii?Q?jGSJWqp6vT3Qr72puysezPt7NSYQCYPDHTyN80a48I/xjEHydTnxcc4YjOkR?=
 =?us-ascii?Q?nDjZNRPHg5cHfB5Ys6pdDfNJC5o6SNxKjuu0P1lFfKRHP4PiUFlg6OSwPPaF?=
 =?us-ascii?Q?F6tCbvgu+F3nVYi157EXpY/AVEMkRcPvUdCYi/+LPQMrEZffgOPOvBs7e7Dx?=
 =?us-ascii?Q?//vCIxh75POITKLUb1zIHzk7i82khqvgGbbJM13ZyKEHCCuNj/PYHpOTy4lx?=
 =?us-ascii?Q?29jQMmM01ax8oUJZoJ1r8vEpDb3ktsMjmVgIv2H7INOkqlbdnW1s5W/RWCeM?=
 =?us-ascii?Q?j0wT/jaZUmXoJR4nXpvv/f7+uzmJF2zj0Qrr6htnmNg/YgsPlduG1+duC6r3?=
 =?us-ascii?Q?5Nu1m6PAMVjzynCVuTpYdyc/J3cMRJfUM3S8rF/Ygl69wk95rCMZBeXB1pF3?=
 =?us-ascii?Q?VUKen+ffn/CE6xgXddzWgecpCN7G+En7gvRuNXenlWW42hgzGViaW8iJ9Awc?=
 =?us-ascii?Q?cNM3vl5a+W/h5kyhRlY+aYrl/WcDOfrOo7siELFK5vfIrN+LYNjg4aQc+Woc?=
 =?us-ascii?Q?rfPMGnKRZLa5SnsMVc1mp3cqWFw9FCW/HXonpKQ6NsLXxunrY3Ug/eizDHDw?=
 =?us-ascii?Q?rNMN4lZyErHxvyt/gpispqFsGtWY9cRuogSBHmo2h4apvVAAk529b7eGVQgg?=
 =?us-ascii?Q?7GOy1EB0kjwQjoKUQj1Iyk030OhQ2GjEDvjWuLm9x9n+XCmhenpX+ls0pZCQ?=
 =?us-ascii?Q?WQyZFIbVtsa+ujhT/wtF8S6V0/LtSAzaHhjl4mPUwKe5CuqB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab33fe0-d891-45b3-3414-08de67f1f7bc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:43:27.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1/umV9NQfaT5qwymqFcl/VEKRdO4sdMOgbVp5k7A/JGtRCZURp4c3QJ0CTjuATvq7BmbIcrC6pkjTGCqUtAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

On Mon, Feb 09, 2026 at 10:00:40AM -0500, Emil Tsalapatis wrote:
> On Mon Feb 9, 2026 at 5:20 AM EST, Andrea Righi wrote:
> > On Sun, Feb 08, 2026 at 09:08:38PM +0100, Andrea Righi wrote:
> >> On Sun, Feb 08, 2026 at 12:59:36PM -0500, Emil Tsalapatis wrote:
> >> > On Sun Feb 8, 2026 at 8:55 AM EST, Andrea Righi wrote:
> >> > > On Sun, Feb 08, 2026 at 11:26:13AM +0100, Andrea Righi wrote:
> >> > >> On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
> >> > >> ...
> >> > >> > > >> >  - From ops.select_cpu():
> >> > >> > > >> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> >> > >> > > >> >        the BPF scheduler entirely; they never enter BPF custody, so
> >> > >> > > >> >        ops.dequeue() is not called,
> >> > >> > > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> >> > >> > > >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> >> > >> > > >> >        not called,
> >> > >> > > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> >> > >> > > >> >        enqueue/dequeue lifecycle tracking and state machine validation
> >> > >> > > >> >        (expects 1:1 enqueue/dequeue pairing).
> >> > >> > > >> 
> >> > >> > > >> Could you add a note here about why there's no equivalent to scenario 6?
> >> > >> > > >> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> >> > >> > > >> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> >> > >> > > >> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> >> > >> > > >> own tracking of enqueue/dequeue (plus it does not make too much sense to
> >> > >> > > >> do BPF-internal enqueueing in select_cpu).
> >> > >> > > >> 
> >> > >> > > >> What do you think? If the above makes sense, maybe we should spell it out 
> >> > >> > > >> in the documentation too. Maybe also add it makes no sense to enqueue
> >> > >> > > >> in an internal BPF structure from select_cpu - the task is not yet
> >> > >> > > >> enqueued, and would have to go through enqueue anyway.
> >> > >> > > >
> >> > >> > > > Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
> >> > >> > > > a scenario equivalent to scenario 6 (push task to the BPF queue).
> >> > >> > > >
> >> > >> > > > From a practical standpoint the benefits are questionable, but in the scope
> >> > >> > > > of the kselftest I think it makes sense to better validate the entire state
> >> > >> > > > machine in all cases. I'll add this scenario as well.
> >> > >> > > >
> >> > >> > > 
> >> > >> > > That makes sense! Let's add it for completeness. Even if it doesn't make
> >> > >> > > sense right now that may change in the future. For example, if we end
> >> > >> > > up finding a good reason to add the task into an internal structure from
> >> > >> > > .select_cpu(), we may allow the task to be explicitly marked as being in
> >> > >> > > the BPF scheduler's custody from a kfunc. Right now we can't do that
> >> > >> > > from select_cpu() unless we direct dispatch IIUC.
> >> > >> > 
> >> > >> > Ok, I'll send a new patch later with the new scenario included. It should
> >> > >> > work already (if done properly in the test case), I think we don't need to
> >> > >> > change anything in the kernel.
> >> > >> 
> >> > >> Actually I take that back. The internal BPF queue from ops.select_cpu()
> >> > >> scenario is a bit tricky, because when we return from ops.select_cpu()
> >> > >> without p->scx.ddsp_dsq_id being set, we don't know if the scheduler added
> >> > >> the task to an internal BPF queue or simply did nothing.
> >> > >> 
> >> > >> We need to add some special logic here, preferably without introducing
> >> > >> overhead just to handle this particular (really uncommon) case. I'll take a
> >> > >> look.
> >> > >
> >> > > The more I think about this, the more it feels wrong to consider a task as
> >> > > being "in BPF scheduler custody" if it is stored in a BPF internal data
> >> > > structure from ops.select_cpu().
> >> > >
> >> > > At the point where ops.select_cpu() runs, the task has not yet entered the
> >> > > BPF scheduler's queues. While it is technically possible to stash the task
> >> > > in some BPF-managed structure from there, doing so should not imply full
> >> > > scheduler custody.
> >> > >
> >> > > In particular, we should not trigger ops.dequeue(), because the task has
> >> > > not reached the "enqueue" stage of its lifecycle. ops.select_cpu() is
> >> > > effectively a pre-enqueue hook, primarily intended as a fast path to bypass
> >> > > the scheduler altogether. As such, triggering ops.dequeue() in this case
> >> > > would not make sense IMHO.
> >> > >
> >> > > I think it would make more sense to document this behavior explicitly and
> >> > > leave the kselftest as is.
> >> > >
> >> > > Thoughts?
> >> > 
> >> > I am going back and forth on this but I think the problem is that the enqueue() 
> >> > and dequeue() BPF callbacks we have are not actually symmetrical? 
> >> > 
> >> > 1) ops.enqueue() is "sched-ext specific work for the scheduler core's enqueue
> >> > method". This is independent on whether the task ends up in BPF custody or not.
> >> > It could be in a terminal DSQ, a non-terminal DSQ, or a BPF data structure.
> >> > 
> >> > 2) ops.dequeue() is "remove task from BPF custody". E.g., it is used by the
> >> > BPF scheduler to signal whether it should keep a task within its
> >> > internal tracking structures.
> >> > 
> >> > So the edge case of ops.select_cpu() placing the task in BPF custody is
> >> > currently valid. The way I see it, we have two choices in terms of
> >> > semantics:
> >> > 
> >> > 1) ops.dequeue() must be the equivalent of ops.enqueue(). If the BPF
> >> > scheduler writer decides to place a task into BPF custody during the
> >> > ops.select_cpu() that's on them. ops.select_cpu() is supposed to be a
> >> > pure function providing a hint, anyway. Using it to place a task into
> >> > BPF is a bit of an abuse even if allowed.
> >> > 
> >> > 2) We interpret ops.dequeue() to mean "dequeue from the BPF scheduler".
> >> > In that case we allow the edge case and interpret ops.dequeue() as "the
> >> > function that must be called to clear the NEEDS_DEQ/IN_BPF flag", not as
> >> > the complement of ops.enqueue(). In most cases both will be true, and in
> >> > the cases where not then it's up to the scheduler writer to understand
> >> > the nuance.
> >> > 
> >> > I think while 2) is cleaner, it is more involved and honestly kinda
> >> > speculative. However, I think it's fair game since once we settle on
> >> > the semantics it will be more difficult to change them. Which one do you 
> >> > think makes more sense?
> >> 
> >> Yeah, I'm also going back and forth on this.
> >> 
> >> Honestly from a pure theoretical perspective, option (1) feels cleaner to
> >> me: when ops.select_cpu() runs, the task has not entered the BPF scheduler
> >> yet. If we trigger ops.dequeue() in this case, we end up with tasks that
> >> are "leaving" the scheduler without ever having entered it, which feels
> >> like a violation of the lifecycle model.
> >> 
> >> However, from a practical perspective, it's probably more convenient to
> >> trigger ops.dequeue() also for tasks that are stored in BPF data structures
> >> or user DSQs from ops.select_cpu() as well. If we don't allow that, we
> >> can't just silently ignore the behavior and it's also pretty hard to
> >> reliably detect and trigger an error for this kind of "abuse" at runtime.
> >> That means it could easily turn into a source of subtle bugs in the future,
> >> and I don't think documentation alone would be sufficient to prevent that
> >> (the "don't do that" rules are always fragile).
> >> 
> >> Therefore, at the moment I'm more inclined to go with option (2), as it
> >> provides better robustness and gives schedulers more flexibility.
> >
> > I'm running into a number of headaches and corner cases if we go with
> > option (2)... One of them is the following.
> >
> > Assume we push tasks into a BPF queue from ops.select_cpu() and pop them
> > from ops.dispatch(). The following scenario can happen:
> >
> >   CPU0                                         CPU1
> >   ----                                         ----
> >   ops.select_cpu()
> >     bpf_map_push_elem(&queue, &pid, 0)
> >                                                ops.dispatch()
> > 					         bpf_map_pop_elem(&queue, &pid)
> > 						 scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | dst_cpu)
> > 						   ==> ops.dequeue() is not triggered!
> >     p->scx.flags |= SCX_TASK_IN_BPF
> >
> > To fix this, we would need to always set SCX_TASK_IN_BPF before calling
> > ops.select_cpu(), and then clear it again if the task is directly
> > dispatched to a terminal DSQ from ops.select_cpu().
> >
> > However, doing so introduces further problems. In particular, we may end up
> > triggering spurious ops.dequeue() callbacks, which means we would then need
> > to distinguish whether a task entered BPF custody via ops.select_cpu() or
> > via ops.enqueue(), and handle the two cases differently. Which is also racy
> > and leads to additional locking and complexity.
> >
> > At that point, it starts to feel like we're over-complicating the design to
> > support a scenario that is both uncommon and of questionable practical
> > value.
> >
> > Given that, I'd suggest proceeding incrementally: for now, we go with
> > option (1), which looks doable without major changes and it probably fixes
> > the ops.dequeue() semantics for the majority of use cases (which is already
> > a significant improvement over the current state). Once that is in place,
> > we can revisit the "store tasks in internal BPF data structures from
> > ops.select_cpu()" scenario and see if it's worth supporting it in a cleaner
> > way. WDYT?
> >
> 
> I agree with going with option 1. 
> 
> For the select_cpu() edge case, how about introducing an explicit 
> kfunc scx_place_in_bpf_custody() later? Placing a task in BPF custody 
> during select_cpu() is already pretty niche, so we can assume the 
> scheduler writer knows what they're doing. In that case, let's let 
> _them_ decide when in select_cpu() the task is considered "in BPF". 
> They can also do their own locking to avoid races with locking on 
> the task context. This keeps the state machine clean for the average
> scheduler while still handling the edge case. DYT that would work?

Yeah, I was also considering introducing dedicated kfuncs so that the BPF
scheduler can explicitly manage the "in BPF custody" state, decoupling the
notion of BPF custody from ops.enqueue(). With such interface, a scheduler
could do something like:

ops.select_cpu()
{
        s32 pid = p->pid;

        scx_bpf_enter_custody(p);
        if (!bpf_map_push_elem(&bpf_queue, &pid, 0)) {
                set_task_state(TASK_ENQUEUED);
        } else {
                scx_bpf_exit_custody(p);
                set_task_state(TASK_NONE);
        }

        return prev_cpu;
}

On the implementation side, entering / leaving BPF custody is essentially
setting / clearing SCX_TASK_IN_BPF, with the scheduler taking full
responsibility for ensuring the flag is managed consistently: you set the
flag => ops.dequeue() is called when the task leaves custody, you clear the
flag => fallback to the default custody behavior.

But I think this is something to explore in the future, for now I'd go with
the easier way first. :)

Thanks,
-Andrea
