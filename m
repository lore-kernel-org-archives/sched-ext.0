Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478E369D4A
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541105; cv=fail; b=h0QQeV6Uo+kN2cFLDB+JNVzO5woatmIj6VVWKks+7HBND67ipnl4JCn0YdiyF3ngcoUdAJ3Fdk0I+6Z8ZCwrXSF/p4bEn5poWE0P2X5B+BxLgL8N2ssmL18rKqCvRqefoo/qjFl9eML8xRL1N3Zym7fbsYdvX5YWVfzyQi9XRzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541105; c=relaxed/simple;
	bh=6CbgaGfpZZT6fTpWJXnUbFHA5lhVVdwNzKF3vZe/IA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRW70ag9uTYGWJdXdhmfKD+8ULztfR4Xm+CJM518az8lfRsyZAF2KtuY4q2Zp3j/zoWfqrp3GYaYtLqTJ7Z9ue5kvjJOaGV5/e1vzEtvBV8SgWB+bJ/J79G1LLcYIUX8mV6nJFDcTQwEvWiFZteG6O/G159ZnD1NOt7jUBwhaws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uhDTX9dY; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhDTX9dY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgTtwPyul3/FLQRNxYp6BlNBdw7zFCiPCV7+ZKTcRobMgWNY6Mm7yahN0dZqhiPiC2eo6zjuY4LI6yFCGLleeeZNdV7mnwMjTLKmJJzIZYGeCKJGeEZ/P3bywmOSaP/jL3CdclYJhV7QI6zBfJngWfmaDH/FbYFbXlAOUsg0crXUX7oS7K7RGdVUlSTTWeEXqbYwmhi865nu5R7WM1dav07jPu/cZnxCWoO6eb1ObYScEtJAMI18nnHNAjKze0guWcaWagCZNto9Yt8bvrQEvd9YNBU+FAaWCUfd9PN+Le8qWc+YJIiNVYqe5/PxUfQC844enfuNJwMYThzYqX4UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O22ds7kSV6mxaHcZ78q0DyGglxKbnXNBSBUM1XF500=;
 b=bBdCkAKfL6talvCMtciHkXLiCYVLHj0Y2XhogsPcmsHb1sa/uE4kzxJOyrjvuKrseZ9vHv6KUqSCGfXLZAhP/9kEvtQInuOO4GnA/HhRQE8Q2dhW4lQIP+61+Tv/6a8muxtldwKJj8ngiX5W3up0nU8XpWlOMQ8wPsDDyy2PItQJb92pqKnf62KFc8Lu3qXt8DfbxjxeIUXYNb/I4WPo54OvECytYSGaRf3lPoj3WQJuv0GmapUW1OoapYHxZw0O9fUz7Y9VXqR6cDSzwxUlNi0bB6uZOgHjqfXhY82mM4t42rN+jld6WzfSgVehefuBDG0QtYFTWDBqOrmNU/pGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O22ds7kSV6mxaHcZ78q0DyGglxKbnXNBSBUM1XF500=;
 b=uhDTX9dYAExXjORLFlg7iMF6J4wHlL5pC01zKx0zVDA2FTRvwOzTPxFad4jVd63dutzG+vpR5lX6UO64KynUbs6Sw3UoOjlrywismKs83ILi34LQPmOFqeuSOazX2O9X5S3nQMfOsXriS4Zd16r+JtAiJiou2ktvqXLsZbBaC8P9cg46DzHnNVonizmKPYY7TzkXNbqXUiSWv2Xf1JrSSKljcmrofytPHPyKRvH39qraWM2VuTqzPOOgcCWJmpsvOdHXB30Ir9IWxerTjObZ3HTmDO1UDBwRUOsZeOR/hKEYtWWSoZncuYrmVZfHB9+222zgv3igEu5MCexsEyJpDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 06:44:57 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 06:44:57 +0000
Date: Wed, 16 Sep 2026 08:44:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] sched_ext: Split curr|donor references properly
Message-ID: <aqo633Wj0nOoIn1i@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-15-arighi@nvidia.com>
 <20260910114726.GR776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910114726.GR776954@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b59942-8edb-445f-e1da-08df13be0582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NDxEI0YWe/DBrFWqLQuIuEGIrC7MaWXpyW/8QApcKkHUUZM5LBQ0NVST31fI/9LCx/y+WEonRB63sgFTw4o4lm6rztQeTBRwszFihfLPBYLexe6d7XNhwPTfgHmy3Jk1laxaOy3uLwvfKTs8Ns0SP9FDQ6f0OGdGd34wv1e5v+Zcdqe2RXC1pq2wvIvG6hZncfIu7t7MXi95C3/cMAibFbgH8yF8exnOv1Re7oD3NjGSYvzZ8nZidUT0gmGUCS6IA8nh3SgcPnT+IJ4tnWIu95wvRj5jUUzFaTDzaiTW7Lurw492kSIhTzKXf1xbrWR3PoYVD5k6SdW4sCTM2ZswbTaCWadjmmHqlLxAPQIiSV/u9TV8vwG+DNLnV3L1pTW+rR+LpJmeTPoJ+3CIPdkr6C28iXBCFkCdhZH1WeKw5NNJ+v9DJYb9DElKjBicQAK2aAg1rrHjE2NQ8eRHpUzm/1ComG6K7QoTqkOb2WHKsGm2m+fZANhgOydnmwp+nW98nrnAVNxNd+Vf+8NmNfMR2pXTkuhFCJyNsFJB99Csz7iSsr+Q7MhN/gK0+B8Z3PgbFgZvoSoXgbWSXNnO+5LcQiOAb+EagoZDDhS0vtnko3fkdvuhYqwVp5xpG2zxd+Pb4DwxjS27By8m0S3btUaoetYcOuuFVUbhwXkGqcuJy5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fh0jgSwTrSTJgKI5GJ0JrXfWNP++qULd/lzuKyPiZ1kAHA6xxJSZTMS9BqNa?=
 =?us-ascii?Q?m3HRXGImLhAHRkWEuW7G3GIFLccImLntniZ4hnI/GdswoVBUVV7/f2QWkBSK?=
 =?us-ascii?Q?cdHn5BBWtaRBUe9f+rlUDhJ50YYjI5BV4bUmWC1X7yewLMA754SIqyiY74G8?=
 =?us-ascii?Q?SF/JxLpbayKxpnVoxRNbdVpqj2huingHW+yjn39pS2zupkj9MC4GEMPMS4s4?=
 =?us-ascii?Q?pApGCzYaMKtPZH+AvBvqnKPmtlNgwhi15pD6ZWFZEadM1bQsHSt58g5ebOh7?=
 =?us-ascii?Q?o3nU0vOvLSTTJddM4mzcpsgRDL4H080SWWj9FsAAreYtlNGdVvILRo7XqXnJ?=
 =?us-ascii?Q?VqSSZ8E29kO40xIcxJ6JqDdHihCAezKSZede5PDi+6Vhnu4+Pi2Nqcw4FmYp?=
 =?us-ascii?Q?oTKsM0P0noo3BP+kK+8qIVdg8uGU6Tk/F9hrlCIgGZEXHOZ4pkGrI8kLl114?=
 =?us-ascii?Q?G8oByqYUnv9maH2va4uYE9+ySQDpmI2wXonXO+Le9WTa8zTHYmBPTDP9x3WH?=
 =?us-ascii?Q?eD5U5kTXrxGtpoRqIzsHB+dohEFuNplXE4zCv2o2GtbITkiJgG9vNLRauTiW?=
 =?us-ascii?Q?EbJDqcqZpjw43QVJceRIm3DH1fSa30lybVCZCp2tqI2iAF/QJhm715cHrSHV?=
 =?us-ascii?Q?pcaG5Bg/0jDULnh6MO/pUQm7Rd42+l+s0cLsNoyo2pOwP2lBIkk/CEmMjBOQ?=
 =?us-ascii?Q?0LFq0SEppbDrs2qJNprRDZSYuKzExAsgULzN0DkWFEjZhkLgKItkjKqIMeiH?=
 =?us-ascii?Q?l1kLqTmMWFKEacom4W8mwTG+X8SVKzCuuNkEmuzuwRk5vApHUX1Cnfn0BoYW?=
 =?us-ascii?Q?O5J4XrAQgz+uKLp3yt5NdeAvCDlyCHWvV5Bnb1YZ76Ki/xeM9TjXXzTbyLx0?=
 =?us-ascii?Q?iPGjwB7tsZ1RQJfxm6TEUL7WpKNXwGBcOUVNP/9CAsS1VftU+zJVgzwRx+8W?=
 =?us-ascii?Q?VHFWPsWI4Ca4hJYAEac4lbC/wd4jwgHVC3ETmgwLZWZ+G+rWfLA/yO75pyq9?=
 =?us-ascii?Q?9zRtddvlQuExu3Ytf+OntH4yBcvoTt2rGVOQozzzdkuIHA8uwj3m7jlvGAc3?=
 =?us-ascii?Q?mhfCBFiHyipq3Dlc7QPKBaFnrGT6fYgXXCGDBs6V/cjSH7VKRiEJ4chbUlHd?=
 =?us-ascii?Q?4osiqD3Sxc/jY7hheW3KF5OP93JW1NgQsvW+H5BrS0sAsLulmsnl7wXbw7ZD?=
 =?us-ascii?Q?DxrOXORBWf1qNb2or2wVlbmF7a4kefnkYng3cZl/n/oc0gPccEA8nB7Ei7Me?=
 =?us-ascii?Q?cNHe1hvprH851Y5F4Rb/92OCgUQcGdUDK+HdGcPt1OkQhzTcSfyemwthgxud?=
 =?us-ascii?Q?LhcN5HevV9aGJ2TaBZ4NEoiP3MNN5FWh2A6ogt7MIhEnM/jBV7Gx2ryUr8bp?=
 =?us-ascii?Q?Ut9KmI1h0LS4ZYJYB9gMXMfNeJJ2cnc2vN6EPyeymI+xBj+XpDTzgtK+e39M?=
 =?us-ascii?Q?Oj4HXQUx/s8wXFBNrKCIForUyMtIifiCTczItKq6mAlSe1IAPPzrA1raeAqy?=
 =?us-ascii?Q?q8KJgMDYWlHqjTjp2M1ntQZZq0VeDNo5hopKi+DKVFM5F7nrZBmYjmVdGDrV?=
 =?us-ascii?Q?WMqs7e4KUKa+DblYOC4KNrPp/dLMezSZ1Mw8F1XMSRlDo44lgWQ9sr6E1L9Z?=
 =?us-ascii?Q?tl61JWW/JdbI4FhjkDDygkzgFHxy4da5URwRYisANwSKqhoPHD3G6c3HjDby?=
 =?us-ascii?Q?ttV0Dz5TjGBhT9YEepW0TMwwoml/4rjx7EsSKvD9TNAQ/ldJlPhw6ZfbEbHn?=
 =?us-ascii?Q?PEje42C7EA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b59942-8edb-445f-e1da-08df13be0582
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 06:44:56.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdDnTpdLd/PnHZdVLTx1Vx42kARVkQtTTZWp/Ah2s273dwG/aeJMi59Wba5trgQm8XfifAwjc/ln/NO2Mba1Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

On Thu, Sep 10, 2026 at 01:47:26PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:24PM +0200, Andrea Righi wrote:
> 
> > Consider FAIR and EXT tasks with sched_ext running in partial mode. FAIR
> > can be replaced with a higher scheduling class such as RT or deadline
> > without changing the class interaction described here. The possible
> > combinations are:
> > 
> >   1. D is EXT, O is EXT, T is EXT
> > 
> >      D can interrupt T according to BPF scheduling policy. O executes
> >      with D's EXT priority and runtime budget, while T waits in EXT.
> > 
> >   2. D is EXT, O is EXT, T is FAIR
> > 
> >      D is visible to the BPF scheduler, but cannot preempt T because
> >      EXT is below FAIR. Once T stops, BPF can dispatch D and O executes
> >      with D's EXT priority and runtime budget. If T becomes runnable
> >      again, it preempts the D/O proxy execution.
> > 
> >   3. D is EXT, O is FAIR, T is EXT
> > 
> >      This cannot represent T preempting O because EXT is below FAIR.
> > 
> >   4. D is EXT, O is FAIR, T is FAIR
> > 
> >      D cannot boost O above T because EXT is below FAIR. O and T
> >      continue competing under FAIR. Once O releases M, D wakes and
> >      resumes normal EXT scheduling.
> > 
> >   5. D is FAIR, O is EXT, T is EXT
> > 
> >      D preempts T as the higher-class scheduling context. O executes
> >      with D's FAIR priority and runtime budget, while T waits in EXT.
> >      D is not visible to the BPF scheduler.
> > 
> >   6. D is FAIR, O is EXT, T is FAIR
> > 
> >      D competes with T according to its FAIR deadline. When D is
> >      selected, O executes with D's FAIR priority and runtime budget.
> >      D is not visible to the BPF scheduler.
> > 
> >   7. D is FAIR, O is FAIR, T is EXT
> > 
> >      This cannot represent T preempting O because EXT is below FAIR.
> > 
> >   8. D is FAIR, O is FAIR, T is FAIR
> > 
> >      O, T, and D all have FAIR scheduling contexts. D remains runnable
> >      as a blocked proxy donor. When CFS selects D, O executes using D's
> >      FAIR scheduling context. When CFS selects O, O executes using its
> >      own FAIR context, and when CFS selects T, T executes normally. D
> >      is not visible to the BPF scheduler.
> 
> I don't see how 3,4 can happen. If there is a runnable FAIR task, then
> pick will pick that directly.
> 
> Per the pick priority, the donor class must always be higher than the
> owner class.
> 

Right. I was trying to describe why those cases cannot result in the stated
preemption, but listing them under "possible combinations" made that unclear.
I'll remove those two cases and state this invariant explicitly.

Thanks,
-Andrea
