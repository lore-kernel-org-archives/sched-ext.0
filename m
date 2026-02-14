Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CD218E91
	for <sched-ext@lists.linux.dev>; Sat, 14 Feb 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097552; cv=fail; b=GJs9BkjY8qqfDE8Yc8cXwburdX7T1YUkDXqyqlS0O3lmGeKpTs+w5OVqO0Agqa34LPiNTcWMLXgx9UYowhXi5oc+zcrbLbtueuu21O5NSA6DdPa1aPi/DRfxk228SxO6Tu/EWXQ2HF3HKfJw4D6y1m0eS7w37B8zWN3Qyd0Giw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097552; c=relaxed/simple;
	bh=qgnpgS7L8d5cu0zq8COXMOm2OR3XqzMB+gBHOz7Zv4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aWkhCEFfoTpC7n+e0I/nl6hrARPRcfzcpdPipi3uEjbCc3cyAcmOYTPICgkHz37JBAzfgYAa4d++fBywgX+f1B4W6j7Cc94D/Mhv2WVfF4mHbxJVCydNnXY+iZatJdHYKUqjkhxRstnpZYJoMfDoaqEv7FggmXo/INWmnPX0/nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ItyQ1aPW; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ItyQ1aPW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLob3rbvd8MdWA1G88ShQi4grgogwJEo8khK9drQZpR0H0mdbdwElOTJoANbPShuim3d/eL1G7a6kp+tISMoMb9y7k8BN87aNHbYO+ofqz0XIGrrcONWm9tB6ruK5NneVlcE4yYCM3FpBZUk/DlzkT70/h8EMy958NOHtv57HvcP8wFuigN1TM02YYePopf9K1fNDsUhugOvjrzj8sCEJiaJs9Ix7UPSBU7wc6Nkr08Aj2eSvgNvE/EGoybMTL2AZTPCQ5WmXOrUY8a/3DhakmlTe153naCn+lKJY2Q5vXLEIpu1iBctOaA1hZE2yKmpqcYbw8lPJfUnCaX36ZbJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OPRYZ7L82jfb6fx2UL922WJ08AyRlA/NJ0mOfIaRrw=;
 b=TUJ1QoOYktMd0ZHRsJSoCvVZYzDsF4NigVNnUMGCZVXq7zZmEe905G02+6GBrmRyJTJ5Aej+OsN2hYi18E+FuAhWtEoayedoimVq0EE/rhb7EKz3Y4BgmcdLkxYttPhD4gSSXy7WiAeglzPa6zvsMVE5yqlPnQzzAnmEA4X9n31pEkSrdbQQWZTb59a785RYRiHE6qvp78Dj2CiAkMmSyxsLhnBzNaR0FW4aayGcWM+J400kjJulbs1GmitbaTDYmnS4do1oirDy1XMiqucqP82h+VLAa7dkTPEA/Mrc6qv51D/SMVpuWyS+cmbf+jwzcsMfUohH3gsFooo0nKYWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPRYZ7L82jfb6fx2UL922WJ08AyRlA/NJ0mOfIaRrw=;
 b=ItyQ1aPWx0XwM1trYjUjq7sfSw660n9CTFMR0NnulRaaKVl13BBxS3+wC1a8cHWkDQs9xwP+JXBRYEf7U0/op7USoy5ij3igB9D3qsn4tPg4uhAkzxx1Vn7zUmWFyYNWdLUd/o7wv8sWISPmL7ZYEvdoGNP0hl5UP/BoQIKZyULbz1drREzYKluun/M8EOVQJHRmg1BBhm3NmNIcaYoyfFc+eYX9z2mSx+wTO6b31K1bk6Tfcvad+BGXeOhPE4GRX2puMoAkN9er3mIqpFh8hafok9AOA3n++ct/WNCe5ILsdXEvH5fvwqpzLAvx8CsQ69GSWFrbqlAdk4SahTfnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sat, 14 Feb
 2026 19:32:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 19:32:27 +0000
Date: Sat, 14 Feb 2026 20:32:17 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aZDNwX6EAN_Acj2z@gpd4>
References: <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
 <aY4IuX59PsmSsi1g@slm.duckdns.org>
 <aY4YdW79Y3FBM5jo@gpd4>
 <aY4di9M4BUfutfrw@slm.duckdns.org>
 <aY5Ua_mFijPmRJSi@gpd4>
 <aZBLgiGv6U8xiZlA@gpd4>
 <aZC3PC2bQNRFNURY@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZC3PC2bQNRFNURY@slm.duckdns.org>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 362d0896-8e1f-470f-c1ed-08de6bffc923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgCLBQQjRx+RahTNNRiFC9DpDB3qcTYq/FqJVfWe0qRXGald3X0S3nav7wDS?=
 =?us-ascii?Q?BO6uNsbx/qEAWwj84d8jT0E+SJYlgmPTi958FKBbd9k4m8UQ1tMeUYTCr71S?=
 =?us-ascii?Q?WyjAyGV1Ihrvj03rfUI7KLXKJTPFI0ZL+MSAFeO3NZqgBZ9Qse4Vh387Q6XB?=
 =?us-ascii?Q?mphqCNvqFZ+zzOWv0fOqRZkcQ0j2mtz46ZM7+Z5FiiaJrvOyCq+y9vKwWVdK?=
 =?us-ascii?Q?CjZEBC5hInYTOW6Kuy/lfqL5Hz83KwpHJSKAGBzcMCV2oPyOGMYv8eCAG/xZ?=
 =?us-ascii?Q?rsEwA5idWrufWOgBN+8cBMTorQ1gGuM2+QQXD2jJKpgaeqWaUeHvdc78qaEG?=
 =?us-ascii?Q?l1+z1rI8UwLB4noLIcpOqZ6DWIaOwGwS57Qz0TLkXSJ3Jvi9O4ZCkbgRkyLy?=
 =?us-ascii?Q?cCar8V70JmQsCaf2YIe3HImM7GC82mNgbRhDhwaDL/eoWBeyVNUXJhbbr9EE?=
 =?us-ascii?Q?QTa8OLGM8ZeZLpAPI5JABIN+Osu5/kUhkJmNDlAlMU3TaLyce2RTNWKvljhn?=
 =?us-ascii?Q?gu5zYarG8bKwxGzo9Y3CO97VxwUTUrKgI9f4Y4ckQlwpl/fWqr7xPqUzxSVf?=
 =?us-ascii?Q?VGHD2SShw3WURYjSrmZYPmmg5sc5rocgloFEwow9iKGqI/wsTmbteFbaRRPu?=
 =?us-ascii?Q?sCqcrPCW/Qyc9xooqfNp60LQyD/Bl4ajC244uMHiYKPGU+Pxd7BY3nZTTrdf?=
 =?us-ascii?Q?TsUJedIVziz8th+Dx7qf/9oOfI6Z0kw2R2mTzbx0vWS4jxnwApGdtuOlthr2?=
 =?us-ascii?Q?9pg4k5vMw/TbI/Pcv9WcTbrYV/W6nb4u8acJqpTNpqSzvKlRQ+8pgwB6oJiI?=
 =?us-ascii?Q?dBuj94b/u1SaYhoATGw7uO3t0hpbhw/kNwW5C0QC0xttf5ht6hAof3PrZ7qY?=
 =?us-ascii?Q?gH40D7ZBrRNgM1cm6Vra8mx9OfFkVW70YDeiX1gIX3OUAeOwjyuYdl9Ndhtg?=
 =?us-ascii?Q?PAe3jpOnjVRoqmpplQUXS99g5dnBQ2cZ10H4+5Yjug0WpqqM3m0HIkQwMP/f?=
 =?us-ascii?Q?frgtjqoO5oi1tVXXD06Vo0WCCGA2m5LvMH+DzpG8Vm1eIMFh6ML4y/DRpUe3?=
 =?us-ascii?Q?yKH+DOy6gHzIEDRl2cPkS8rvgpHINpwWAW/upywGK9Hy4AB7cwd+95/LI0e9?=
 =?us-ascii?Q?V+JoVhJr37EUb7qoqrZXJDR3iU0jKhOKHicMFKkA+pkQ60thIUuYekeyltop?=
 =?us-ascii?Q?KzMqpocOhuZnwO7TydKkHTpR+npweRcNwcy1Q2EgQkGe/gTLbygIt95cRl/p?=
 =?us-ascii?Q?NDSrRc5OvsJLx5jASvzeVmixuPVPcRR2t/O+f11nETE80MoqnX3WlGsFjarY?=
 =?us-ascii?Q?c2eXQ3aBbiCV+pdDYI3XI3YGPmz2YFw/fsq/ilYr/mjbhCr2vCnQjt3yzTVB?=
 =?us-ascii?Q?ce8Uc3VF9Cwfc9K2paXJxTCyCcBezU59kfdZxEC2v2j3+/OccuhOX4KivwHL?=
 =?us-ascii?Q?riMVQV0H9xn8sUGxhx0yJqM5Tkf8sXoU9jAQH6wxcq/IPvYciAtktuKpk3/U?=
 =?us-ascii?Q?K5fga8TQvNEzY/WFZhw09jb7f4GKQGLH/RZQcy7HWV82kpehbYZmoa7PebBn?=
 =?us-ascii?Q?trJIvYUWkHmTLEvK7aQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sOvuIoUvgqasy+3oUtc5kc9SDo5bUpsAlBzENgIi388M7OBtIb3jzWBJCUi?=
 =?us-ascii?Q?KrRsy0EWd/weEmsksluK7y2QO1hP9DNG491UZxaBaQyk+Cf3MBIo5EhtGldR?=
 =?us-ascii?Q?FIo5dpciT7hk26Tf0s75jFHKPw59K+ilSnJYRMSrpnvicXG5z1P4RgZO4FAC?=
 =?us-ascii?Q?XqSDlgSYxjF9pLKpWDPH/i4nxX2O1S5Mi6sZLorMJaNXg0FR03viAcxODQ7e?=
 =?us-ascii?Q?sfxiiKhks2nfbiDRP7GJgxb80iN6iv3QRN9q8jdcrbOSNkOciQKLRIZ1C7jL?=
 =?us-ascii?Q?xxbO3XlTiA925lg6pvGt8JfZKP9FpDqYHIY70RlRxWN8RsoDd+tvaooR4lM5?=
 =?us-ascii?Q?wOx0wZ8c9Kme589Dsu+23Urr65plqyXH0qvU+CaySeIiZSKvUGpBgLbhs8cB?=
 =?us-ascii?Q?Lt7HQtDVGd/PWY+OGA+ACpVsiUZ80f3jSTiscraxabaXYlgWpUxDQnGzDGia?=
 =?us-ascii?Q?0ItTblwjLWOpwhpcsCl5fIWarhgNAdZu0ApRpo2wo2KM4g+/AyG921LtuSgX?=
 =?us-ascii?Q?LArI0AQ/nTjYezLJJG7FGp2ABfyGM3WJzV5kIi+6dtRsSfcex9F9i4nFEfel?=
 =?us-ascii?Q?17TCzd76TnR6KtXdoQOXyB/M10MijKrKsXqaUYfogx8DBD77rtcbk+r1xFYO?=
 =?us-ascii?Q?q0zEzLJ4EI9qJNUREXYB3QRaNM6ySBcm1Has2m0LzJmzefysXo+ZapU8aNY1?=
 =?us-ascii?Q?97RqPYuro37fCchcjTPu32H8bNix8g7jqSGgJxCQDNU7ShrvDHr1YQJtI8d9?=
 =?us-ascii?Q?QC7Gl/eQnv+HIlIK33YsqPPduWrgjX8ge2qmfR4LsS/7QwXcTXyuvoBEMtob?=
 =?us-ascii?Q?1zojcF6vAJyr1SDv334mUxtP9OXK023xD9DSOsnEFUOmMG+GVdf2ZGCO4762?=
 =?us-ascii?Q?DUXY7/8hMLuV+QVgePwXzwdvntxTCaRKGZu/XHDMtb5cOCqOsVcYkVxgDJ3s?=
 =?us-ascii?Q?l15l/0qMBTXff4uESRiqlxoPRX5cKg0GhNiNhpQgUmnTONX3ZpXKZqyqoX+t?=
 =?us-ascii?Q?pvU10m9vOtOeKQcAgBj2r5hIZUFkviv/7Bon90EW9hhKsC1/yFKSQVKcrRCO?=
 =?us-ascii?Q?lgdiGf5Ie815oDEIfj0eKtZr1MCza2U1yzq9qOnIGroNplKGw9K8k+bRxZDj?=
 =?us-ascii?Q?vMkTG/mRVepHhzsvfFBTm6HGc2sVMpeKmiIrldSN+fCLMu3IMAgmBWVcywtM?=
 =?us-ascii?Q?WDGL41Lt9fDRKp9XGE93knHw/3OS+kXYaiGT2GTTj2V78lS1jAg87NCfMMcv?=
 =?us-ascii?Q?SGW9pWEmncH53sVQwRBVsuexnoI2cQkXTvb0e7XrzDFPGzo52T/02szcDlOd?=
 =?us-ascii?Q?Cb3xiFOmJ4jPftj0X2uT39PvmA/hXUDr3183oEHc/AMozOxcPLQo2ejaN/AN?=
 =?us-ascii?Q?mbYoETytsdmTTrRX4X9R90wFWt8A6L0cdKBujqWtHAH1YcUKP18wGI7u9Oe9?=
 =?us-ascii?Q?ukzCOF/k7fYC2WJ9xsHn5QAErsaxBpm9Q3KtXSo2n76jS6rM4+lBGOkyovzg?=
 =?us-ascii?Q?nupRrhD4NwiPNsXqJgGPL8BZUDJKaEsk3dMZueTGxYVoBEaIg6iq/XPU0hUU?=
 =?us-ascii?Q?X8Kg2m9nTebj2drUUwis0FT5NrHUHKMGcDHyGBt41FH+7hr8EHEVfxPedqu7?=
 =?us-ascii?Q?Hx7V6O7SkVIjtORA6IKiR0DAzW4rwSUjqGPu958qZsU6lazDZNjZ7+p0LkN0?=
 =?us-ascii?Q?VCXNIDcoMwcLfoOmUUTDiUWeya5gxO3j7eJ4Jgjq/w1WfeVZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362d0896-8e1f-470f-c1ed-08de6bffc923
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 19:32:27.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdHmO/+G5TWbayeXuYOKe9cwtWuU3GelJv4sJ3tkIUEs+7rZDMy3/zwR7xBJ+BTok8RNjV5VAP1hQTzHb3S3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

On Sat, Feb 14, 2026 at 07:56:12AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sat, Feb 14, 2026 at 11:16:34AM +0100, Andrea Righi wrote:
> > I ran more tests and I don't think we can simply rely on p->scx.sticky_cpu.
> > 
> > In particular, I don't see how to handle this scenario using only
> > p->scx.sticky_cpu: a task starts an internal migration, a sched_change
> > occurs, and ops.dequeue() gets skipped because p->scx.sticky_cpu >= 0.
> 
> Oh, that shouldn't happen, so move_remote_task_to_local_dsq() does the
> following:
> 
> 	deactivate_task(src_rq, p, 0);
> 	set_task_cpu(p, cpu_of(dst_rq));
> 	p->scx.sticky_cpu = cpu_of(dst_rq);
> 
> 	raw_spin_rq_unlock(src_rq);
> 	raw_spin_rq_lock(dst_rq);
>         ...
> 	activate_task(dst_rq, p, 0);
> 
> It *looks* like something get can get while the locks are switched; however,
> the above deactivate_task() does WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING)
> and task_rq_lock() does the following:
> 
> 	for (;;) {
> 		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
> 		rq = task_rq(p);
> 		raw_spin_rq_lock(rq);
> 		/*
> 		 *	move_queued_task()		task_rq_lock()
> 		 *
> 		 *	ACQUIRE (rq->lock)
> 		 *	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
> 		 *	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
> 		 *	[S] ->cpu = new_cpu		[L] task_rq()
> 		 *					[L] ->on_rq
> 		 *	RELEASE (rq->lock)
> 		 *
> 		 * If we observe the old CPU in task_rq_lock(), the acquire of
> 		 * the old rq->lock will fully serialize against the stores.
> 		 *
> 		 * If we observe the new CPU in task_rq_lock(), the address
> 		 * dependency headed by '[L] rq = task_rq()' and the acquire
> 		 * will pair with the WMB to ensure we then also see migrating.
> 		 */
> 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
> 			rq_pin_lock(rq, rf);
> 			return rq;
> 		}
> 		raw_spin_rq_unlock(rq);
> 		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
> 
> 		while (unlikely(task_on_rq_migrating(p)))
> 			cpu_relax();
> 	}
> 
> ie. TASK_ON_RQ_MIGRATING works like a separate lock that protects the task
> while it's switching the RQs, so any operations that use task_rq_lock()
> which includes any property changes can't get inbetween.

Yeah, that makes sense, so the scenario I was thinking it was happening
can't happen. I guess I'm missing some ops.dequeue() events then or there's
a race somewhere, because I can see tasks being enqueued without a
corresponding ops.dequeue(). I'll add some debugging and keep
investigating.

Thanks!
-Andrea
