Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480261EEA54
	for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950172; cv=fail; b=IxuHpSWFADKD4qBuciSkQbpk8n67rWI4iqL/MPbGn1XzcxJ9i75F/zInxQuFRGwYGhiGbQ5L90jqXwlumtZYiITqJUF97KNmR0zyBnjt4GTnpmUR5pEGJi8wsaOl5mYueHIFVWZzoOvLJZ9K6eonp6fAlw0wn7CNL7EK+JqFJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950172; c=relaxed/simple;
	bh=0MywoHakJx3BvkzVkP6/F5CnPFU3dyziHQCZHgpFwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WA1QGfNus8bql8GpB5Ppq6QJRcQcq8DMROrq2XoPRzmbNGMf+kSIN7MhymfsrGYy5fNRfUtCWPkl4RwemmHL0BXosjcvv9zWI1RcTfzx4lvDk6gyTihclcbteHsmR8knVo0IbJrJCEDrXM0tlIggEHA2VgxmqciUCBS3OnqhvBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yf5tbwuP; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yf5tbwuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7lcOMvaJyBkO83U4M5LrnjPs7VK2WtlEXXxNHeiedTbAJ7dyfOGRrul1RjxNc11rmaT9COH4nSiklXDTf0lsHit1aRGD1zorMoNFwHPXBQdcCXgM/euIYzru/N5Xbp1UYKxllTE/GCKFhZXplvqzfZAPyVSbYPt7omQC3OQLsJIWaUhqYQyEA+qMwNZkFv9naxUsSOtzAR/3vzrP6afZZRPFn9UjhE907OxQBGMpxrO+ZH8U0mvCmNGVdngXHNCcFGcdwbGnvHClRh9OoGq2+oN8zPo3HT/W9kIK7mthDrEICgx/P81G2HxQV5s3f5zszU0VIcCXgvB+ETk1tjC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCR0wwh6cjtIvMWjnXB3MoJpiiz9OYcBvochCGRubjM=;
 b=xpET4J1bCo49+Ox4VyIUyrX4KlN5LLCZRPUsJtpijI38ShoyT1xgyNwAm8yZoqV3hIYiXHC2NIyvrhY0U8feVkdcrWbHZdJ3aDTSKyhU9QYPBPelm06emHwhw/+cZ+QUiI6CMjgky32Xwxxakl7yyXFeHfkRNfNrSGRdRnT4Jxn2b4qYlrmG+/vqvYfR7+hxuYhYRsat4c+Je1/MO5lbu1LG59jlDORWHTaSFRkYwkhD2PrSsu2eXQ90iuoR8dwYmgwRs1JRQhAyr528lVFCLrWxfsi4yLpeVDTOZIzYX8I8JMgBCOwZAnx/yTV5T5CSP0U+urU0pPZyv1HBiMVZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCR0wwh6cjtIvMWjnXB3MoJpiiz9OYcBvochCGRubjM=;
 b=Yf5tbwuPi8d43niq35vQhq7vGoAveBBrPbMELtdEGjFTxR2RML/1bEIMfIuVS2eP+GxPpVyXBKO1r/WSp6HVsTgtzHv81+fkoYSgcmEuX7/cPRcdsSljA/UNNRmOpi/cmz6IbqfwFhQDvucHHabP57H0QZMnl5eHXlx+ylIBlB+X1oSx3t9/mO739MdH14itaRjdEgJm0XUVu2z9Q0n0zC11+9eqFJ7EfFvo94jZOCVxI+t2hCrMd+NlfcWDqnMfLGkll6o/r2SaRdfmf8fNECT3hyyfX1wvjyhgBPcKoRmQ/yYfonZqXpjGU8PjMMfwezoQaIq+OciQ61Lh0hHO3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:42:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:42:47 +0000
Date: Tue, 31 Mar 2026 11:42:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload
 zeroing
Message-ID: <acuXD7AVGnnLAMn2@gpd4>
References: <20260331091901.219894-1-yphbchou0911@gmail.com>
 <wyp2r4ac6ddkiubgjm33nesl3hmovqrlcvfkstcuvqgtvzgryx@yd44lc6xdhn2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wyp2r4ac6ddkiubgjm33nesl3hmovqrlcvfkstcuvqgtvzgryx@yd44lc6xdhn2>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: be470a56-4484-4c9e-41cb-08de8f09dde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GMxEFG0LzL5qiMJpcAi/3qEj40SupkKuzt50I9N9wnUVaeJmeAL7DXcH6WOIdnpcFMQeJZr8EaSJ29YtlIJ9lUxV4lbh46xwNqYx7yocXJsEzfv3Wreczza7EwfgQkIOeA+sbT3eIGH0rNVdfb+fjjp9BzvukLpouzb4GFjVfGkcuvps89qGhkBYnUiDKUcNEzsVQ3ajzKvr6d7MLKPZDEJGcgeMH/3/K6wTmUxfXlQx6mXIW/J/zdlC9iYHcu+Jo+galWqfwH3l5uZXsYQhkAKmEswJfi3TpYRqGe+5lIpmexcfUefcyssY1ursDQWJqNatSmDMACMLCkJDMLwMdrZRacXG7wH/droabvP+rcK0AqB29X4DYjzRfQANyXYjFxdGFxiju9k/n51vhEecjlESlyDB6ek8he1OjXaGGoEOmhLyf80ppGBwjEShz6lNouieOg8FbQs7SohGyUWSELvIJp0bYW0RPuJKPLlgqHMnU/5BDqOFCMEEN6z2v21Tpjt11Q5FvrKlw0C9QU4xKhJatUj1rPBVLmVqiFBwXkkokik/wFqCu/C9PqN7GmRCvyVW7ga92cIU+j3A/LuuUNVVg5urQYNp1D7n5T50u9ogSBv3n+AytVTpTLMVQo7xZ8pc0P3iQo4FGycTyf0QMsWZpWlz6vZMXZyKQzdHP4HNe40wvDsbEr7nYkX91oAXxotjtyR3i6MMs1ppLK+A9Yj72tq3dpxYgL/CKA8dg1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?olG+COd0gxfRkV0paQMd4iKCySlqZXZXwdEendzQUa3EbpQmuPfAS64F1UA/?=
 =?us-ascii?Q?0U0uBvrkKnjyahw2ZWQj3imUR4RNs75o+ZVU/GmM2LUeYrviURGNDcCLdcDQ?=
 =?us-ascii?Q?mVW7aHfJLNB3ksGUhvNgRH4yih45UG4ZrxdWYQe1PzItd7qLyRhmNP9ZpOx1?=
 =?us-ascii?Q?7Fhx7/IYkKaejg9YRDm5eWAp+EuO6vROX9nJM6e0G5SWZvrGXrEtiv0Lwcgu?=
 =?us-ascii?Q?ihV7Upo8szJEehX2a/H0aCXQUgujnaliZRxFwvs8Cq4dtv7MsabKr+UboqJO?=
 =?us-ascii?Q?iKr8WSuACgsDPhNLXji8vMwLPRhRiMn5BKfKMadbtWghlSMNQudKP/bPzs7a?=
 =?us-ascii?Q?zhDULyxjSbQQrjwbD5Z9UIt95+ImbTPR0cHVAXUZToSpsLF+ROa6RhLnJXYL?=
 =?us-ascii?Q?N2+hzKeiXmbgRnKTCrct1sqrCT5C3WxtSdF/vEUTXACm9QA0yoRyZgJUIHbs?=
 =?us-ascii?Q?hrrKEV9pBM6CpniFnpU3s4Xe1mMYcQhFTewVicekX39JQMs+UuIEHOdFTeCY?=
 =?us-ascii?Q?P1kAiLD/nyRSfDzcknFPCJrNwn9MpWQACRE8OGXsrne5ua1NVgUKgrfF7prQ?=
 =?us-ascii?Q?OCj4ZloKnoZtQo5n9gXGyna22H2xy3SiVhtkCRzv9PQ5QgCayJwzbGT2ge+K?=
 =?us-ascii?Q?PEU/0hUOlvf1dAQcvZ7tuFIuLMnFtsDf26ypqwkrUiF8bFd5yUKaPTDbtYv7?=
 =?us-ascii?Q?5eLqRcYOf+56lnn/wGqaitirAi/6PxcY0BG+g27Xy+s9HIWVeae7cDT3tQOI?=
 =?us-ascii?Q?6XQuKoNaa4SDSKTF1qnNvCX8r6Bz0D6XWSsv4D05welI9Kg+MbKboHqSiBbX?=
 =?us-ascii?Q?9pfDcEpLYqWToQzEkeRt+tSexmuYDECGkaXIBkE1q3IE0KI/XgKG10dDHKQn?=
 =?us-ascii?Q?r9kIk6RZacgJ9hUBe/TNW+yFEQA8PGs8sWNnXrwZoT/HXmlhcdSi+FZOm0U0?=
 =?us-ascii?Q?lK0V3Dg1nbz75LFkBkK8uJZH4wMUEV/pKqbC8vXnZTRqMzj/FT6YrHbqUfhH?=
 =?us-ascii?Q?h2CEHYclsd1cfHhrytSVzMUkStHm1WbK+V19NCTraHUlXp+jkeKgRUqSHH1z?=
 =?us-ascii?Q?6xIxKGIm8jVmvEfimsgAT0Yh6jruc6TF9E4HCrwv18zBVs8RFoxy/e8538bE?=
 =?us-ascii?Q?58rNAJjXue5YSQlCKq5VOKKAW55BdQNpxxFLBjOkMdvmWCyMeyRxPuFjZiuT?=
 =?us-ascii?Q?2nXiTu18qwy1zlA5pCDHUvEJdNXuMtUDuMGHpE5d0m3GY0twFJqOiiZLqdke?=
 =?us-ascii?Q?23XIgPntRW6kaueMyjIZ8A8SkarPgi3t3Jvn4L5I8SqhN2mrlYd44SodvRAI?=
 =?us-ascii?Q?xfdaWmT/cWpwZzO+haSQuffNSeYH+CLbdPuYSiqHV1sw3nRItzfiZuXP2mnp?=
 =?us-ascii?Q?+C6S1lxD1FUZR+kVpKxzdEv60NjV5ewCqlrBlUxN0zDEiEZ8cs2HfcF+7bdy?=
 =?us-ascii?Q?tB7p5dNk5mrcj5WwC3FEQ7PX+iCyuGylU+8F5MYy2lxc0CZdSlV72com1xZv?=
 =?us-ascii?Q?rGW4MO9roFWBcDbPjYkzLlWyaivRDYUjd9OOep9c/6fGa7FsF7aLqEwgaxt5?=
 =?us-ascii?Q?w1n7LVqvk7f4eeDZ2UgmBver4VAYcXylklNoY9bFpCpe3MM5+5rBx6jHnAnj?=
 =?us-ascii?Q?KkilLrdk9UvYvKPxAVsb0gbgbl4r81sEu2hYNrsbrEUyeJvEx0vRb6o6Dkx8?=
 =?us-ascii?Q?pFuYKqStA1+4UKWri+0k+kuDBu90zwoj4gBjwVIrit9IyewmflqB1V2tjj+p?=
 =?us-ascii?Q?Q46GHU5Biw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be470a56-4484-4c9e-41cb-08de8f09dde0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:42:47.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FzeapUKhqY5BOn7F1sKaY2f/QqJjCTBxZ7NBIR/U1TzTH4ErRkPvZ5PyYhbEjcYzqD9zQi0jcYqsJHNuWU3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

Hi Cheng-Yang,

On Tue, Mar 31, 2026 at 05:24:35PM +0800, Cheng-Yang Chou wrote:
> On Tue, Mar 31, 2026 at 05:18:33PM +0800, Cheng-Yang Chou wrote:
> > Test plan:
> > - Add a temporary sanity check in scx_task_free() before the free call:
> > 
> >   if (mval->data->tid.idx != mval->tid.idx)
> >       scx_bpf_error("tid corruption: arena=%d storage=%d",
> >                     mval->data->tid.idx, (int)mval->tid.idx);
> > 
> > - stress-ng --fork 100 -t 10 & sudo ./build/bin/scx_sdt
> > 
> 
> While testing in virtme-ng, I encountered a bug (see below).
> IIRC, Andrea sent a patch to fix this.
> Has the patch landed yet, or is it perhaps in a different tree?
> 
> $ vng -m 2G -v --rw
> $ stress-ng --fork 100 -t 10 & sudo ./build/bin/scx_sdt
> [  111.268570] irq event stamp: 24073
> [  111.268577] hardirqs last  enabled at (24073): [<ffffffff98dcc597>] _raw_spin_unlock_irqrestore+0x57/0x80
> [  111.268654] =============================
> [  111.268655] [ BUG: Invalid wait context ]
> [  111.268732] hardirqs last disabled at (24072): [<ffffffff98dcc277>] _raw_spin_lock_irqsave+0x57/0x60
> [  111.268882] 7.0.0-rc2-g94555ca6d0bb #8 Not tainted
> [  111.268952] softirqs last  enabled at (24060): [<ffffffff957da30c>] fpu_clone+0xdc/0x520
> [  111.269016] -----------------------------
> [  111.269180] softirqs last disabled at (24058): [<ffffffff957da2b4>] fpu_clone+0x84/0x520
> [  111.269282] stress-ng-fork/703 is trying to lock:
> [  111.269762] ffffffff9aa64650 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_sdp_contention+0x107/0x260

Yes, landed upstream, you need these:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=175b45ed343a9c547b5f45293d3ea08d38a7b6f4
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61bbcfb50514a8a94e035a7349697a3790ab4783
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c405fb3279b39244b260b54f1bd6488689ae235

-Andrea
