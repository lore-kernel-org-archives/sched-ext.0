Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854413957E
	for <sched-ext@lists.linux.dev>; Sun,  8 Feb 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558919; cv=fail; b=XYCtO6/PNf6Z8HRLpz/VI20+NCx5ecxDkB+qQoE1FrGVkUaqPOZqR/dnHFIyeVeW/qKgqFzxXsBRLEz9QbWEBYQnxTFWq6gJqmBB84UdQMXu0XzSmYhQY0am0welSe9a9csmTFZJrhcbffQcmwPvtMFxN9LP5XRhF7vML9yESYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558919; c=relaxed/simple;
	bh=M7n0vJQQqU4UnaXp8i6LFzCuk+iTLjAAUyKgKy1CK1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgpAvLjs8o4N3iW+ArvDi9ttiJgrSogpT2BlSsIhR4N/8lYLDTYf+pLObM/OGZ86PATjYlAuWAlrXC9EGJaqZ3h7SJuqCVz64+c6xC37KKL3lZmBSdwZtKqRKr2REz89yZ5X4UoRblvtB59RmA3ykLecAJzCcSWtw83iuQY5YGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qs3oP53I; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qs3oP53I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7HRccB+d9NWWNfusk6Aa+MQCAhUxh+zYUxlPi0PH2IxdqBlI5RfvqHjTDz89ObJbifN8pE5MGfmzzCanvPueHjwfnv87CMpZJWcWKyGR/1S4R6nFe4Yq30dVljmByoK53SwCgHHUu7YMOqCMlI92/3Y6IBmIjbN1B14QIeKGWY0o1DC1E5UrUZis9J5+Qi5h32dj5w5EFmuzguiMZwT9gYDk0E4mDMJsul7FmvZER2qxPTGwdEQBlP4q+VYBxEnNxVvtOKMuJhc6dPx8JQ0Y5M+0sr8BkVDgdqw4arAWMIMdWUC9hWedf0j5fBnpot0DJlPBRCEMdIhhJXsvVNRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko8BnomRmI6fG59+5VLiP0V4qTlqzCYW62pKdSc1MrU=;
 b=coItEGLCLYGjee91RVRYJunZ2E4LlASKFV15PVK52nVd/LO9s8t3mYSS8fUcmi5gogkoN9/4nhlhYyz199maEgugpDSumu76tTHz5jbUus3vvhJfIMO8ZCegF95bjPvjFJw7CCcY6essqJ5hegEKihAi8XhjNO1JdiN9G8KnyDMJvJRFyAOxzFp5GcEGdoc5aRNmEz0XoSEwlkmu/DnfXPNlU3mJ68KMCVOTaK73skTTn9qv5Fg+sDZrk+AiqG/J8AcvqH8cWO4alky4fXMplhc7q3IzIO8MsN+ft7T313wMgY8t8HuDN7yUt3nYdHOSKpf8ktllWssxHXwb5JMhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko8BnomRmI6fG59+5VLiP0V4qTlqzCYW62pKdSc1MrU=;
 b=Qs3oP53It+JrSAGSmbjMLuY3DAPpKfcAQebEre0MG17TSDW8c22IBqACTCcbDya5WukiFhZhSkUJ4leDleOAXUExd7nqJhwcyORWf+xdN0aFYr1V1KqNbnd80Ab2csyWOg451K7n9/yeSIKCxaj/vJkkPpHLhn92LRQP6hUY3AKwSfRMpmFGSvj6etf4s+o0pfAY2rDVCull5RTX6SuVxY8egJzC7NYomuCVS2k26LzaNDMGFt8rPfb/DOKpAZT7gNPLH0Mp1ymMGUtgBAIAEBmOrNafyKFu+N3WLdegj9+we9CKzvtaX8ij8RgTprxxs6O25kTx5oEwC39/cZ03qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sun, 8 Feb
 2026 13:55:15 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 13:55:15 +0000
Date: Sun, 8 Feb 2026 14:55:11 +0100
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
Message-ID: <aYiVv998mfMGVMCq@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
 <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYhkv2K99aqiuwr5@gpd4>
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: fa457fd8-4e09-4335-6d36-08de6719af66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iWsPhFGQ8taV+Zm98nj7tUGJTvprMkoHV2owAobiRoIAd0SG+FxZm/4YetHl?=
 =?us-ascii?Q?O3ZakL6e7ud43+E7DQR8vcLN5XOvDrruEWw8HdoQ07Xi9am7orJMHCtTKstM?=
 =?us-ascii?Q?XkkDExVJebSjdrOd1tz2sLavQ8xeGHTKSIaVJMmZkyyUHvDK/ixQoDMpjEDw?=
 =?us-ascii?Q?SN91YA+MDijZCrK+2waimhZFW1mROSwVbsliBwtuRVPz7hm3m3td4YeZ8OZh?=
 =?us-ascii?Q?vHBUPknTPgem6En1jyTlafd7mejkbu9oKgOf5uD8hGR9Emt0Mf8BRp4slgVO?=
 =?us-ascii?Q?WLR318H6dzP5R/uHNieyg4OyKMDvTxI19ZRRXe5IDKm1Yfd6+1bLFjLUfyvF?=
 =?us-ascii?Q?2vdAZhqweArZEnhA4u5bgto5izfpGHSNY7jgqqWrJy/GlEanJ9Gh3SZSC3Hl?=
 =?us-ascii?Q?R/4vRMAg37nnkeFepWxqxWF1PXVYUWZMtPhpoo5e5deViKesTlR1ahUWAPtN?=
 =?us-ascii?Q?LvkRpnN5ewDmg2kbRfVw6oy05GSzV/WssvFPl9KODBOw72li6f4niiK68pjN?=
 =?us-ascii?Q?rf7WfsapYhvxOIrgK2+uoy8Tian41UAWM4e+wblkx2/6RHbHflYZTv9bnzMC?=
 =?us-ascii?Q?jJTqJUt9e/DzySqBn5VQBN3MclJeuSa93Oj9ZtYXeFFJ35t9b1bRW+AhKCh4?=
 =?us-ascii?Q?/adu7br+6Ac4G8nznhEjoz7iYWnTJGgsX3CzLPsE/CeEOJWY+R0PrnGmdGx+?=
 =?us-ascii?Q?ES7jOh5j0eRsdAsWe32ojfffL8TC7uQU7nXQbX4AXcodgUqsWFdfcJZjVjYf?=
 =?us-ascii?Q?6ct5L1YZGFTYWfY7xx5nkPkYI3fiKbTE+zJBqBmZ3etjNMXWw90ElROACJ43?=
 =?us-ascii?Q?8wYnftfELys3V0vPe90It1lqqysgWaXMemV62Jpb9zeXJjKJxq3kL3eIPYPn?=
 =?us-ascii?Q?YogZLRs1Tvh4YhdlmgUcEhDaUbHGkmNUi30KUm8532FOF0ihv19b+efcmGor?=
 =?us-ascii?Q?xd3M5VPD7o0/xGheErYSkfipGNGT1gTvd6F3WruYbIEpXP4NOhZ9zj1k2EBT?=
 =?us-ascii?Q?zYajfod0H/ZBAbx1Qv+WPuD9R0FZI/Ze0P6SqCbkUVNeNd0epkS2ZYNY89k5?=
 =?us-ascii?Q?/KeJGJ8rNoLIZoxFT4hPAXIZ7a+bgKXVIm0YKjeF5/ryerDlF4ellXwryrWX?=
 =?us-ascii?Q?XKRAWa/du6tkK/q/na6wyTwKo5VoH7JxY138wtQju0mlcxQS8BIiYsCllYOP?=
 =?us-ascii?Q?RH04D1452Ruxy92lVedW2R8fenj39afhWxA87PVLKXHo9mOuoHRGp5/K0bgI?=
 =?us-ascii?Q?bQZuxycOpbEt9dh9N4khIQGQPwC6Jw/oR0vyNdNE0Kg87WY/KFTtOSm8FiKw?=
 =?us-ascii?Q?lYFdyUw2WHyhIwkBlUnEWxICWQsRuQL9kK4miQaX6kKJ5BuLC4rEoTiSfjdF?=
 =?us-ascii?Q?i7a1U5qsZ32hX9X8PAlHhQiErc/1XKq7akbsjUrYbHyTPz7A2uuUUBqFIVql?=
 =?us-ascii?Q?rrcT/BPMU7Zlkwur+pWJVuj+WIPy98TWWZCqNm+yxjQWagVUxLeeuB+s4oQf?=
 =?us-ascii?Q?nmVyFSACCAxjbOXtlhRa7hO2RGaEpCErYGy/PVigBh6eD1IWlIUPL2tI1Tkg?=
 =?us-ascii?Q?Ghi+5UIQIrcQy2TmcNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1hEFMCwGvV3/6yaGQcMCGVIKfrDyFrp6qA9j6w71+RiFZOolYTLeTAD7MMp2?=
 =?us-ascii?Q?bQ9qMp4zZWAs0wcV5yNQiY+bf/XmLRTEmo6w5b0yP3IQFXIlu4+oSYJDbAuU?=
 =?us-ascii?Q?yjPml0TQnFSg9FXN2n/uR4BEH9e2/xKvjg9hQ5PlDeYEttYgNw2EeR0ngI1q?=
 =?us-ascii?Q?zzAAFKVgkHg5x2p2W3m8leDYUGmKZ0bI5qQee2rvPhY/zMuVZA2UY8EAqWV3?=
 =?us-ascii?Q?vUZT2nDHLbiiusUJ2PkAAkYp1/bhHufGg3Ws7cr5GG6OLg9K0bNShnDBvCP8?=
 =?us-ascii?Q?zJfWo8MXEf5YuZGWxj0MPk1Gg6MbRZ57GAnI+DbDdno0+3WDnlQsaofHZia/?=
 =?us-ascii?Q?wfSvFY9KbxYcTWwu0PeIfvnjRlELzuE2051+PoCtf/9F/aZRF59ilBDLR7ZJ?=
 =?us-ascii?Q?98CUF27LbGwSSOvSfazddMM1mkt6KL856vy65RsjkpwwqQOq3vbZy7GMie9C?=
 =?us-ascii?Q?LTbwv+YegJ9B5tG0f1CKPvHS30fOD2O3zcYGtvwk1py7lZQAeVRH9mNmmSdw?=
 =?us-ascii?Q?iKZNbU7oUFEtyvyH2x9/fUfkoEuFYrpw5G91rW+EGN3Q+DjAIlyaM54k1FFR?=
 =?us-ascii?Q?WZtTf4+xH028J+Ik7BDFz/T/xT9RNHMIH7IlsP33z2zG/6CI+vAKtOUwkhbp?=
 =?us-ascii?Q?V+dMIh25oSYdvLF44GF+oqIBZ97pq/zaNslQgquCpG6sPzSKwC+wI99GTZuh?=
 =?us-ascii?Q?6wzFGiVMDPNpxi4vTfFpYqHlJg/SUt8ykNXzXkPhDsBSjCp0XiW3rBBVAY33?=
 =?us-ascii?Q?ji5uo5kKzLurS6Df5RNuMHbyiCAAsWXNvLSV2SrGx6DVDnNuaMc2ioQGHhWO?=
 =?us-ascii?Q?FMVCKM808ASN4SuOsuJPjnLWC3JhJV1V8brHQtupEtFtnuWtSRcekhhjGihF?=
 =?us-ascii?Q?Wtsq/ULvuLnAjmPMLPqGtPfcTIpMk6E4Pa3Qy1q/KW0hIKSeco07HbEjY99N?=
 =?us-ascii?Q?czU7EqjUKRTC5evO+UOq4RxF7yakvxeuep3sOnOTrYSevRlu/UFoZbyLueUZ?=
 =?us-ascii?Q?43wcfZKH/1ryGN9mV/QYp/fH+VfLPl+XwQ3gBjhGLhWSPCCr1eobUI8R7fX9?=
 =?us-ascii?Q?LqkECW7FbRy9nhx5hKfLU1Uh6VRj7KriIu+RX+1NzsQeoky0AJLPXgi8ZJOc?=
 =?us-ascii?Q?JYre7Q1V2RaiRyKEXQPC1aIntCT9+6o6AACQgVeVpMYa/SQdxZZ35nHGdFTE?=
 =?us-ascii?Q?bn5r92FEvz2qblVYNz/2Yn85EnMICuDYNGocqi0IwQuxl+BVag20KJcCerIf?=
 =?us-ascii?Q?AHrthwhLXmWf9fwBaiWdywUPn7YA9HoOvut4iSlDMzLnxEXoOMPEKNLFXjYt?=
 =?us-ascii?Q?Y/st8uuALC6PgniLu9jBFVFLHMa2ia/t7t+TqoSDC35AVv4aHXLHJkRBgK1q?=
 =?us-ascii?Q?X41Y+bjXtT7FmOMzxn+UR66CwkEc0Dm8ehvWx81ZKSpO/gDUOCI0ZcY8NkQP?=
 =?us-ascii?Q?kzVGLGYQPRNfG8yHXwTVcbsNGlJeFVXE9JGwujnNJvH0D8EGz/ChD5LpmKEu?=
 =?us-ascii?Q?E7IFB2HWMBlBYZaTxmqDowaHGzxb8/Sngevoi+gjkfRKTAfRFSTmCGrzyGJx?=
 =?us-ascii?Q?PygDMOC5ACwQgb5h08nlU2Mk6S/+G20PYVdHttseKZ6Wdt2ncyOv4eZOoA1M?=
 =?us-ascii?Q?v3t2AAkIh/kleIi3WGLisXZrprPz4PyFi/zS1lwsBV/L8JgM953Vt/GUiviH?=
 =?us-ascii?Q?8wxeKMMaPIjyzA6wycPJBsfnD6F+ZsUljPop+MfXPRTyUipQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa457fd8-4e09-4335-6d36-08de6719af66
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:55:15.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL9eHjCkI+uvjY/XJC6+db7TSjfJZ7hYpfUIpRRaSh7RIi7Yi6o/VbatoVaSxWLgOTv4hfroV7L9e6w9VaTZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

On Sun, Feb 08, 2026 at 11:26:13AM +0100, Andrea Righi wrote:
> On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
> ...
> > > >> >  - From ops.select_cpu():
> > > >> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> > > >> >        the BPF scheduler entirely; they never enter BPF custody, so
> > > >> >        ops.dequeue() is not called,
> > > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> > > >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> > > >> >        not called,
> > > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> > > >> >        enqueue/dequeue lifecycle tracking and state machine validation
> > > >> >        (expects 1:1 enqueue/dequeue pairing).
> > > >> 
> > > >> Could you add a note here about why there's no equivalent to scenario 6?
> > > >> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> > > >> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> > > >> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> > > >> own tracking of enqueue/dequeue (plus it does not make too much sense to
> > > >> do BPF-internal enqueueing in select_cpu).
> > > >> 
> > > >> What do you think? If the above makes sense, maybe we should spell it out 
> > > >> in the documentation too. Maybe also add it makes no sense to enqueue
> > > >> in an internal BPF structure from select_cpu - the task is not yet
> > > >> enqueued, and would have to go through enqueue anyway.
> > > >
> > > > Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
> > > > a scenario equivalent to scenario 6 (push task to the BPF queue).
> > > >
> > > > From a practical standpoint the benefits are questionable, but in the scope
> > > > of the kselftest I think it makes sense to better validate the entire state
> > > > machine in all cases. I'll add this scenario as well.
> > > >
> > > 
> > > That makes sense! Let's add it for completeness. Even if it doesn't make
> > > sense right now that may change in the future. For example, if we end
> > > up finding a good reason to add the task into an internal structure from
> > > .select_cpu(), we may allow the task to be explicitly marked as being in
> > > the BPF scheduler's custody from a kfunc. Right now we can't do that
> > > from select_cpu() unless we direct dispatch IIUC.
> > 
> > Ok, I'll send a new patch later with the new scenario included. It should
> > work already (if done properly in the test case), I think we don't need to
> > change anything in the kernel.
> 
> Actually I take that back. The internal BPF queue from ops.select_cpu()
> scenario is a bit tricky, because when we return from ops.select_cpu()
> without p->scx.ddsp_dsq_id being set, we don't know if the scheduler added
> the task to an internal BPF queue or simply did nothing.
> 
> We need to add some special logic here, preferably without introducing
> overhead just to handle this particular (really uncommon) case. I'll take a
> look.

The more I think about this, the more it feels wrong to consider a task as
being "in BPF scheduler custody" if it is stored in a BPF internal data
structure from ops.select_cpu().

At the point where ops.select_cpu() runs, the task has not yet entered the
BPF scheduler's queues. While it is technically possible to stash the task
in some BPF-managed structure from there, doing so should not imply full
scheduler custody.

In particular, we should not trigger ops.dequeue(), because the task has
not reached the "enqueue" stage of its lifecycle. ops.select_cpu() is
effectively a pre-enqueue hook, primarily intended as a fast path to bypass
the scheduler altogether. As such, triggering ops.dequeue() in this case
would not make sense IMHO.

I think it would make more sense to document this behavior explicitly and
leave the kselftest as is.

Thoughts?

Thanks,
-Andrea
