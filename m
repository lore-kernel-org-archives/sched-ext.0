Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64431D726
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028084; cv=fail; b=DUY9ZNO7cOSQWwI8jA0Y6XG7D6KwmJLegam0bJ+6EUA5SXcQlYgV34HuMbaz1pDoc0S+6gYIoHcqF5F2Ia8fU3vmDOOgveZeW0p/8ZTOsKsxFdC7ng5xpAXJ0wrd3bXPw0AUzdojschFDiyD6iXmzAWwUgm9qplSa1wTWkpLO7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028084; c=relaxed/simple;
	bh=YdWDxNm8GLmKaWbUrHb4QLn24GYXpi0CMyFc7SVAGd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7T26CnLGXXYxCa0V8wqc/kyXsQy87NsxvR/Xi35raWNk5YYWu26ffeYcts87kzDRjVW+EulAVbx9+2UJzNUcNOXuISq9kDFsa65OV7m7Uf6R/oQD3UC6JspuZZqnKbR0WJUEQkihavHJQAHMMvhI70dRa0WpkNmRyyobAO1g94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDZwldm9; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDZwldm9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFLY+mHzjJX4As+I9pgn0ca4GTrZY2CNXgIL9y+5OLZ7QkpGG6Q5VklkbVZbwlerOHuhoiGi7dVWE4jahHw5hl/6Bi0L1B4EoD7SHbMevOi0OnbSW9UTUB8OIcVdh6iXt9Mdiu45uVzLoJMJjeSsa2yQoWCWag5EjJa4ztHEnubpTRO+TmOlS7UsGjWxeWef3CAioVRH/1GDAubYNO/XZghZv7113Kail4Z6ltAS84a9QwYaHrCPUmzHhvUG5BZhnbm/XpFMN5OI7VBIxEmzrtfSHGQG86EpEpuBKH2ZAuzQ/sP8y70CFqVUdZHmuVNuSJVWvw1WIavnR4orwoxuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuBS85GVV6PSAnTGA6GT5U4QOUbMSHFjvpPjmuoChcA=;
 b=aODcu4DACAWDfZuF9BYOgFRViloU9xjD1d+ytbTdudMGAGba8FQfhglvJtVvJSgLJkxg1nOjIvKY1/5JDZVlOLuyITgJN0vXQI62asfjUYZtkFxoiyJZ0d3EC+mCgUmKLa/HqEeGV+fqlUNi4tAFRWu/sWn0Xr20VxcbLzZw9/Eb5g+xu66n6OAmJd3Swj2VYVj5UQS3OyK5lvpy9DaFoXIZSiGX4D2xmlLUgIM1dmiDFSF0rTM3nGgLc9ZaHA96bSrq7/dGJNOFiwXTbzaxi3faPuvuzk3vq7AuHLPOiSZuairKChJMQbisEvEhU5zS1aOj3OrMkMIftXoHL/EEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuBS85GVV6PSAnTGA6GT5U4QOUbMSHFjvpPjmuoChcA=;
 b=EDZwldm9BKDNJ2Z3bsTh8j8VFETF7D9bBWyXwM34+OR8nIbS/3Ff2lhUU+XzGmU33dwL+MRVLthhzsg8EUmu53KWFwbadLwxXmFJThwIJAXRDKwn2/zlC83GXvxQd99iz80KH9Mo8qGmjCQIdo3IwzSvHz2bxnWOGTHSdlqeFEOo/4ViDgLkICcWVoUBiF83DsRAhrM2CDgLAHNssGTOq8r431arpvPNOj/nGwi8uokTPKUKy5aHjj+OBH4ly0XWLn6A0HCN7RZE3NnMHI1MlJjmNHKJvJgnxAfBZ06kRt/Rl0FYs1URD3r+QTrib2YyNk8htY//JFWDuMAveUMejg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 17:07:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 17:07:59 +0000
Date: Mon, 29 Dec 2025 18:07:55 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVK1a3pnCHnMWOWY@gpd4>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <aVFmstVjLW_QIQis@slm.duckdns.org>
 <aVG9BBWIQLL8uJrQ@slm.duckdns.org>
 <aVG_WZCq5QlRgrqK@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVG_WZCq5QlRgrqK@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: e5403aac-55c7-43ac-647d-08de46fcd121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5LoEwoupJK4QKxKnCcNx6wnPizgHo6gYQJPi3EqpTCp3MY1Mj4QXkespkIB?=
 =?us-ascii?Q?YJb7l69sydJGg7kmTc4/OtbTbm+u9Inz61o1WCag8M8ypbTj8FmViINM4upF?=
 =?us-ascii?Q?aqITt6vPs7haqJmOisfS2uCMWLRbXMs6PjeMvUNwGDhVYs8JcM7aht0aQQGa?=
 =?us-ascii?Q?rQ/8g+ghMl1o2mBGjnroEpGsCNrLdktyvAbYos3Yx/Mn28uMA8boYX6sIBnj?=
 =?us-ascii?Q?VJ3BPuS8FZArw4HrBCtNwXh+jHn11kQEzKgeW/FbfNq0JRQGknBbY3gEoOIy?=
 =?us-ascii?Q?an/isFmkQFdl3d6JcVzV8yNRMtnWrx6i+ixYVSSUGVP+Fr9d8VTJvSGn7aTA?=
 =?us-ascii?Q?hzFXtxsce3Ixj1zriqjzulPqZHWDGvKhwX/vGQQzmzvom44jYyyrO/bCT7An?=
 =?us-ascii?Q?/HkTcAFgZpTq9VbRCf7AC6+VD8AAFxCvrMKSBzJfNtLytND0Qk0ZYhemU7WI?=
 =?us-ascii?Q?mEMP6L9wc+ef3x4roSJz8TjcssRQkz4wTF5fAKO635Glj4TCP9DSZE+k1RTG?=
 =?us-ascii?Q?ChoNkY3OafQlgF8Ek74sJMp8B7thy44kHbAo++nOrwJXezBBBuFD0vnJ+VRk?=
 =?us-ascii?Q?DCxK3jsNqIcv2wqfCCmX4p/nX7OT16GpIEaI3cMuE1lzesTdZ4gmubJKYyVn?=
 =?us-ascii?Q?118TGMZXYN1xw7OKJWyfzBim3y3I1L9ffTRWaBs2Ak5N7h5ZI+wzc5ImL7QZ?=
 =?us-ascii?Q?00o0f5JZXokyW5eXL9tq+1MMJu33kmdo1DKcgxl+jIhRQUmm/pgTHZcPfxsw?=
 =?us-ascii?Q?DG7xZsfQw26p23SmoO2422V4uNXCh2DklcEusYq4ZPN3rpr4aHDMhASoHOmM?=
 =?us-ascii?Q?4f3vPSBHRXjUqbQFvJYG7K3EVrBfiLSD65xKlqBIz3d24hBn3Klh/x+pHe9W?=
 =?us-ascii?Q?1BrtpPkj0TusAsB14Mnf8Y2b5DNMXH2DVrW2zbD5XrBobGJZqwQxRcIixK1Y?=
 =?us-ascii?Q?yg0GMq0ETUX8ndZbRB+tKRsKwsCqpxp6SMFAmxlxJu6KHGrPs4AXTSGJ5Okn?=
 =?us-ascii?Q?EsTdZFblwcPFrcchgpSfLX3yqhIUnRhhQb0OZjdqM0myAVfLuzXYxtjcTheH?=
 =?us-ascii?Q?av7/ikuYc8bijm48DRbvFYabY5FgTs3x3IvyT79voMC1yuB6dZhnjKFJZc42?=
 =?us-ascii?Q?wDZFIWFVA9Mimb2qm5EbkWEYAZgbyP4N4rwnRxm2Yri0P1pUsecfX6pYUmvm?=
 =?us-ascii?Q?C7YkedRBVoeMZq4neFIBYDlvAppU6/h7lgPGrreDQD3uNFT5XC9jcWsyCZki?=
 =?us-ascii?Q?vlpBrdVbuPrDo3AfdmQh+40IKS4fLvfMPtiRakgt7d93c5zqDb022IhLcNdr?=
 =?us-ascii?Q?CWa+mOztQEczGHshT+MvY76DwE6KrYuRWiAGgMsqW9dkec7Xz1Kv5GjVqnWr?=
 =?us-ascii?Q?ubg4ZegxeYGfPVwPQZ98kCZahsYI52FfYWW/KA8y08XbpEhTM1k+3Rw6AFg2?=
 =?us-ascii?Q?45xAR2PeNX8b7XFbyIyJeJt1HN8M9wr+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxVVArVhzpPYOC231cI3zhvwZjUOPA1eK/sXHoF4VXFEiByACV1BvjiB4Ypl?=
 =?us-ascii?Q?QNkWwllNMc68Y6wAS1lnROZaaXsS6q40G8p9gh7jVhcfjz05mxcIQQJjMmS1?=
 =?us-ascii?Q?AGP8CJjNcxH3Sgi9uD+LbeCpuQ2VxyQ+y7AIGxhuvHpjoMN2eGhgG2ZZwpzJ?=
 =?us-ascii?Q?6yBseAPOFhxdWmS754MVg/nEk/rnVJF3BBzDsCuHy50z/ZQzWjUbTtHaSdUm?=
 =?us-ascii?Q?Egt8999GZPl13eZo7F8bpfCsLh0M2ApIIaCsffBwoVah8DCGcK46e5mJWAoB?=
 =?us-ascii?Q?aNiGHyfAGmjwBOmN0SqSMFwg4w9T56fSBmpR1qDMhdG3x/FggJuAKpEMKy6/?=
 =?us-ascii?Q?JdTVDAjoiHDDrxmpmo9/ndUJnwbrgCeLJhM/kCVMv0DXlViHOVkg042jfjyt?=
 =?us-ascii?Q?qAH9gLEY6Gy3COk6I1RP2mNOVnKvrMF/VQ2nZeaTwtGwnS0uNMQpDsD2XL3W?=
 =?us-ascii?Q?0ZL1QU60lx52EcfXBketUcYLl/WOOOph9BVvM56YVhw7b0NNoZ2saHMpIAO/?=
 =?us-ascii?Q?GSLRJKXfCiF3tsNbAZFecVZPSnMRfYKatAcuCV8KowJiMHqUUaxUQEPDIa8l?=
 =?us-ascii?Q?YpzGH3IZkneb7WAEjoPtPN8XsDVTZUffCj7eYZNML5HTuiIzqMtz3e4HJj4K?=
 =?us-ascii?Q?IAzUVe3M/QRsL6lEBGxDwn4boFOG3zzh6oMHOK24YYbx0DGnz4GkUiebWm88?=
 =?us-ascii?Q?pn0riMZclkjiPsketoV/SDUhLWCxb0gbpZz73ScGd0iVps50t6yunlY/AcbG?=
 =?us-ascii?Q?WPvVcchKhyp1J/9T0fFKWKbaubdEJMwk6lj+LALzgzlXy+ZdsNhCJOhWnMnA?=
 =?us-ascii?Q?Kp0WO6RSht2qmxMCsd7X7OMYQ8P223G4MR/YyQjIfujq8feSaf2IjqNraG2k?=
 =?us-ascii?Q?1XKZ4C1I1Kf5IQBXe5wttrwNsucH2i3ZkAWrkEur7A6/glX4QwsYwow5rPOa?=
 =?us-ascii?Q?HMmaNw1tFhjLTRDWhdyvB+uJYwK0PvaIAIUSd7aCZmb1/vgptc+G7bKtkDH9?=
 =?us-ascii?Q?cRFm3Xnn9hlQlZiZzBpxOwfnuh44tPvmgKuCTkpuF01tgxy3ZPg/y4FWr2Th?=
 =?us-ascii?Q?Uq1lfV1g4QLnfLHEAFezAvTFA/mGDBeDRWPynqBN9e1SjFdmYkYuJHG7ZT0e?=
 =?us-ascii?Q?OfgFnD+izwIWS1G1fNErzvVfG4ndI6qEq8OSNGYz4h5s+ZEjTAqxsesAfooz?=
 =?us-ascii?Q?rJNcfyGpTmVK2NreJ+jHiVyGWCfYQCcs297AknzrG4ddzCSR9AcmEzdJIi4o?=
 =?us-ascii?Q?FyeavVD9mFZC1nF5Vz9/rLCwq0fZ1oPeYvXVIwRUx+dZwd7PRg6Lvrdidghn?=
 =?us-ascii?Q?mAc+jODqm1YnXta2LLeqaYEwwsv2MSZ0bbjYv63hwoeAEX0uhOEmXkRBcQKA?=
 =?us-ascii?Q?QlracEVRLnRe8YOdLv1z0xNwolAslXnSg1qifnmKPso3f9VtfzZJLLVXcbw7?=
 =?us-ascii?Q?Ib3yfatmHc83LKJMkMDz/VBadPP9O5x+B9WhuZmHEgDcSZ/4SDUACCHiQoWo?=
 =?us-ascii?Q?0Kcw/y2Rc2JNCLrjCrxKY2bI+u0UUPzCKKFaWBj2dTdSGvXV3HIvOghdnyTH?=
 =?us-ascii?Q?pg54SFclVWkIaUgBSqY0GqyivMMYmizviYhYjO0uvPkLjih7P+JK6vlbw8fQ?=
 =?us-ascii?Q?1hfEX6ZgbKWi8HqpUM853bJz/094I+BWfKScj2wtILwbVg3PovbAY+u6HZhT?=
 =?us-ascii?Q?op/cA/Y1s3qJs+55JVeLsTuYOGXKD9bbAJDoPzLsL8N57/F9WmpgjR3pU67S?=
 =?us-ascii?Q?KAMhtY4ffA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5403aac-55c7-43ac-647d-08de46fcd121
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 17:07:59.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s57eL9mF6mFNEOjRCeWwo4864BEobKhbN+4B889AD5R76j5Cj917gU63v5/99ZTwSU9zCd0uprO3l+0H6dPc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

Hi Tejun,

On Sun, Dec 28, 2025 at 01:38:01PM -1000, Tejun Heo wrote:
> Hello again, again.
> 
> On Sun, Dec 28, 2025 at 01:28:04PM -1000, Tejun Heo wrote:
> ...
> > So, please ignore that part. That's non-sense. I still wonder whether we can
> > create some interlocking between scx_bpf_dsq_insert() and ops.dequeue()
> > without making hot path slower. I'll think more about it.
> 
> And we can't create an interlocking between scx_bpf_dsq_insert() and
> ops.dequeue() without adding extra atomic operations in hot paths. The only
> thing shared is task rq lock and dispatch path can't do that synchronously.
> So, yeah, it looks like the best we can do is always letting the BPF sched
> know and let it figure out locking and whether the task needs to be
> dequeued from BPF side.

How about setting a flag in deq_flags to distinguish between a "dispatch"
dequeue vs a real dequeue (due to property changes or other reasons)?

We should be able to pass this information in a reliable way without any
additional synchronization in the hot paths. This would let schedulers that
use arena data structures check the flag instead of doing their own
internal lookups.

And it would also allow us to provide both semantics:
1) Catch real dequeues that need special BPF-side actions (check the flag)
2) Track all ops.enqueue()/ops.dequeue() pairs for accounting purposes
   (ignore the flag)

Thanks,
-Andrea
