Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5520E6E2
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780599; cv=fail; b=Y9G3hUSttR8gun2W8DFOYz3jsrAMmIVlQHd8T4ImwNycE3nfBUrTn4f0gnxkGj5vFPhPVQC8lXtbPOIRIdA6b6sFVWwoE10+r+lXufOioC1o8lsyckLqMUdAqpMMxHjcf620RcF0IP5aoIyKXYrikhOI1Q2iy3YxUro3YnWBDYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780599; c=relaxed/simple;
	bh=ACC4Z2CCXrXRu1G5jffsicY3dp06Jl5t5XnZwrDJrbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3uCVvuzii8YBwbvxb9Ve3568w8jl1eYwSH/kW3eWV60oXZugDajPG8RasWZpRvKE7QF0bxaBFJr4HEgSPczRiXT0hM82SHpHGSYsTrn2g4Nnq0d+4KoZ2lKF5Eb0YjrgbLYG/f0HPY0ACuZ4E/gGKTh/52bItFO30P6Udwkoc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMNjDnbN; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMNjDnbN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXJyV4YQLluvEo//c7v/0zgpxQov/3ba6gwO0ZWr0Rm9cpF6NUpzKKKrApahgl/VUxR6uInce/FLxs7COaDCaBxB4nAFzR7hpQ+tJud9K/VBUEg6KpPaLBVbHGCk9BJ63S2f1qzfsq5CUSffzJOWhsSbvXP+CbzZD/X/TEPgXCbAHnF3BdRBKAOd71fMaJ+KcfWmQkalBZIgJ9R529EKOmT3Esa2dqUQQ9cChXqNbwMkWlYN/uZ1CZRxcvfFmEiggTy/kTyVCcPJhwVOISwoXYc/oCrQnGJbRKOF2mVM2qWtPRpv9xygTFTHR3BtLKfMsW/m4JCAoaZJh6NHh1vpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQQaktm9mC06PqJxZuk/BrSJ7xAVTZ9r91u/kKq1B3A=;
 b=SIUStYaPdGulUxdFid6N4uPc7uwUiI53DosOR5uh7U6NmQRtwr/7guAPVZ+pP/CwUuSmvfB+yH23DD8KiIkXY+9SR/LEXhMSa/PH/1BFHu+VMusV7D1lMavyzHUtByM3X/9p9ZBhMWPiH2gfQGgRkB0RnvjBjW0fKhR5bKQ3x+CREhOyJfGshSCCvD8fmAJ/PCvkFjzJmE+kIH1N0+SM0sA14PQVgcSCg4woOiSIZD5NwlpmF/TFCztQtHwljhhtFuwy0j6HfK0rSXlTFiYHs8sCZL370PLoe0QLTFxPYwlbnpTrb7ihVKkfTjuoJIt94+TDHG5hYc54GIYAyfNaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQQaktm9mC06PqJxZuk/BrSJ7xAVTZ9r91u/kKq1B3A=;
 b=KMNjDnbN7vpmmEpKhmJO5jTulxYNRnPDdsTQ8+YEirMgdGy2qLN8Mw/SBLrrPwxeKCZbRKsj/h2wJiS8hPglp/UlXqHmYZkafx79W5ntbRUzmXKI2845xxW2UU3UIC6P3IdeoNnbPGw1ywR6CLdBGKKJ/PvF0QAeBhhkCe1bcxOV4Qrx3BXBpqRkrj3PnX5YJtTSQdjxO0STEJ1ukNsJOqQ4ZNbEgtLq4qyHxmRF1JCDWKYT19AMVu+fOysDPR3v18Ue4H6mIi4VTGbiHA5nM4nnmqQ5I94V0yAcQsU0oEI6rtnmr6CTxWTYMIS8XsQeX4k4aw0YRqMCwuxT7UxeAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 07:03:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 07:03:15 +0000
Date: Fri, 6 Mar 2026 08:03:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCH 23/34] sched_ext: Implement hierarchical bypass mode
Message-ID: <aap8MAJeUeqialG1@gpd4>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-24-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304220119.4095551-24-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c094605-1168-4d83-556a-08de7b4e7029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	qXLK3KogezeMgcCGpkeNNuOG5yyjKRn8rIBiCW8vr6pXsmwTngJ2KSXw7wrjfHVBtr1kCy6i4I4qTOJ+hSEX/hTQkG0wBzRG+z8A0q4qjP58hrsEJxUST+sDvkovtPtHMPp+PypkDY2VL23hS8LenDju/kvSopDjomGp8cm2C7IDL1x1zSbgbhlgcSDX6blw+rMMBSR4aMsMZHbGDRqqs3nptO/7woqqj0vrLeUUNEHzMqYJNFBu4PKi2xgUegLcd8zjxPE1RwHdmNEMpJoJV1N0cGyYd5gSNwevPE2HNdBkryR5ZqScFB1now9lVdW7XfNk1OrxlP9NOXfMEyUPpkFCQQEg1VOi/RAHAfIDxBdUtcHnbn7XjOrvUDBMmuynuePqweDobV3TW6N5qNIqFuw6jMD2x3JxHHbQ2rOFzUx45DuTJ1Nvw04Wn+CmNERqJ/pD5mx3T/jP6WJ2wJzb8T1gZkH+v/ImLT9UU+hqiMfeprQRg2H0B8krXtRITTc6d+NYUpubplMzq/HiQPURGr+c0Yo9Sj5i7tbllQt/EgeVKmaG8lgrX8v/qWJv1ZfXBt5P0/K1H1zbqgzP4qhh/PMWlIYYASPlhhw8jgyyoD6Asm8nNeW7yWA2GD3SXPuhEMrVI7J9rrU9PlMRr5J5VKfuRjAt97Cj6FM4CjPyIDnFNrHIqNI+wqhFQhPThzNz6upWj/iDxN0b1ULOoy/R7eszF7HykpCdtPBlYoNHXdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OlEW/rePst+p1qPTCOn5GWyFUmyh1xLyO/y2tSowUZDp3elGvVwmbnhuX82h?=
 =?us-ascii?Q?tv7bLVsam/HlJHePAW1st0552UMFzgx4MzFSMKTEL42/jf/Vnmnrsgdz5AgD?=
 =?us-ascii?Q?hXyWaaC4k0pW2Qg9k2G3IPTZIehcqeuqVm2fICHKbiDi103J7wXMj648F8gb?=
 =?us-ascii?Q?Lj54oNSXslNOjSKM7zcBXBwDS09HqfRA8/vb1KWUDpTsH8CXm1beSp1pU++y?=
 =?us-ascii?Q?FIKKMMpsmYfA3QIvPuQy+TAHLzVCH039DEEDi3AEa9vrOwqnGhRYkQEgLZDL?=
 =?us-ascii?Q?Fb0QS//+veHTHggPAZ8xcJ+1RkVt/S49TXfXGFhX2Tk1SPKzi9Rqv0ktVl6P?=
 =?us-ascii?Q?YnyFsmc0LE0y8EDC9DaU39AspsQIJV0rNgbCgPkCesH00FAghVYR0YE7JHF4?=
 =?us-ascii?Q?6FaDUxWKaPutKcTh8R0tiQNXGZxU74cSgXtND6pNkWT8HZcCtDx5MYADTnNC?=
 =?us-ascii?Q?rBcfyLBJAlTiBAEjHZxRV+xuqBJRGP0kfeTDI5hCvdL79S+QODyE7ca5yAFT?=
 =?us-ascii?Q?SOua9IU6zAA0qWqu6abFZKp1Sf0HL8urEKdWey/EzwEhanS89ky/l4LeF9hd?=
 =?us-ascii?Q?wtoyhbe/j55iVuZzVbSrwSZEzkGZftNmertYj6geXIc8jRcq4+NX1m25V5uk?=
 =?us-ascii?Q?u0sNHc2blOBNfbIN5co+6bDo2x4iGS+8VPLWjUZsxAno0/AIPiMwRcFSjhTQ?=
 =?us-ascii?Q?BW1dwC6IHAsybbiL5CIb8lI/SftEWOMfHPFk5aHsBmmdfLvBsVcu07FvTKxL?=
 =?us-ascii?Q?7dh7nyQmq/bue9SGkxWvRiaZgoYNF/yH/LWykDuYAgkp0WWe/e6plSXGgFl+?=
 =?us-ascii?Q?IH6sbb4MNt4JQW2rGWHDA4imJkrqFwVaezrNBmOuaKj2sDxR8bZTZFhOQSoI?=
 =?us-ascii?Q?GDtEHw367rJXJpt7Zngbvk1K0JLA/htRXZ7NiknSrrGdDt5B8IT4RJ09NeRO?=
 =?us-ascii?Q?TxjIEhNEjF0Y9CXT/nvim18frou0gGo17eWw4w/48dksltKDqgb32N7dE4Pl?=
 =?us-ascii?Q?rhn51jxbqu4Z8qP0NcX0+S0/LzbLWSKjNeUsVYj/ft3xkpQP47Q3Nh2CijZT?=
 =?us-ascii?Q?uq9FpuOrx0stx5Isc/WquSv1KU7TW8grcsfF7xwi5PFQ4qYqC50KR3laM6ye?=
 =?us-ascii?Q?RKP3YY1lIBDkAq9ToCoqZbcnT1AcadUgZkStbILZFfDR6OI2OSPsl10fbaZd?=
 =?us-ascii?Q?8IvQ7K9fSvV09eUPXIFqijm+od7qYaiW3nyg2rKipTJ6BZMmIjQHdeovBuIJ?=
 =?us-ascii?Q?QDTIdvz5s1zWqGIlHRqAPSaqB4ExkcBzLChCsZey1ABa6ZTuqR7/K1/3mEjm?=
 =?us-ascii?Q?/aZ2NRCXpTu3M/ZEZYhi8SOpdSZBHbsiC6xnPRb1sRV7HXBsw29R1d14fjJA?=
 =?us-ascii?Q?xa2blxD2qk5LOp6lDp4ggFkkHwwoPfJ1ZmaGtSxzWd30FkJGJUQ7KGaOpdbb?=
 =?us-ascii?Q?/t6cvhBKNePw/HT9GB2K2RdNbthsjoi4YhzZVDF2so0Q0MpF6UbDpLuWmKN5?=
 =?us-ascii?Q?QM6RQn9uCKXqn/dpYwrhFWwcVt5RYeUsj/s+euQ1xSrTqsa2FGqkTOfxxD4F?=
 =?us-ascii?Q?TE8VmXGDoQ3s4i+cXutnS7OKf6U/z8wsSmv1wl+nPRndR9RlVDtQHeFTl9TQ?=
 =?us-ascii?Q?bXPOpUH+W8EnPQQWUTbXKqPeG9UdqsD8dnMNnpZDhC46uy9DsawQ6u4QNYDv?=
 =?us-ascii?Q?P1YGvBmQMLxBCG74UkxqOsS7/nmhmE4qQBTqsLxDiMgFiAH0+OTXA/8vs5FK?=
 =?us-ascii?Q?mpp6KQuqXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c094605-1168-4d83-556a-08de7b4e7029
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 07:03:15.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3q5Ru8q43N6Wa5VB8u12KqRf6sgxynRP+AjJMy8dNM7MyjLp1fENTq6t4OT7PmPST0cL4F/Fif48LP/NuwEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

Hi Tejun,

On Wed, Mar 04, 2026 at 12:01:08PM -1000, Tejun Heo wrote:
...
> @@ -4471,14 +4527,35 @@ static void enable_bypass_dsp(struct scx_sched *sch)
>  		return;
>  
>  	/*
> -	 * The LB timer will stop running if bypass_arm_depth is 0. Increment
> -	 * before starting the LB timer.
> +	 * When a sub-sched bypasses, its tasks are queued on the bypass DSQs of
> +	 * the nearest non-bypassing ancestor or root. As enable_bypass_dsp() is
> +	 * called iff @sch is not already bypassed due to an ancestor bypassing,
> +	 * we can assume that the parent is not bypassing and thus will be the
> +	 * host of the bypass DSQs.
> +	 *
> +	 * While the situation may change in the future, the following
> +	 * guarantees that the nearest non-bypassing ancestor or root has bypass
> +	 * dispatch enabled while a descendant is bypassing, which is all that's
> +	 * required.
> +	 *
> +	 * bypass_dsp_enabled() test is used to detemrine whether to enter the

Nit: s/detemrine/determine/

Thanks,
-Andrea
