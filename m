Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA533064F
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327174; cv=fail; b=cBCQDzHvu67BVqmF0UwCnGnk027KgvbzcskPcqf2EGKghZAg90qgaGAl6hizpoRc+4iPy5bIv2bu2S7spLzo/TJExxZr9GHuSLeVtHN57wJEVwGu0Qm/Rn5cCkvdf8zA3Dm3hnvE/TchPRmzX4+Lko6yQHqLHiAv+s9pRWfWNvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327174; c=relaxed/simple;
	bh=YCkLEsAqj6XZRdVX01Yxct1r6rJAvWWKB/p0+TitP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BaGS87Sp0OfjnXYfAvSOFVaFbLQvEgWeY1dcxXG0IkL4bRF2IKm2oKnyAOPp1Gq9L6oMJrcWnltf2KTnM4lmXuOarFF2m9I5zYxy1k62z46CBby198ebcEZmnx3fHrFZnc0g2KIvmeNXjB0XFgGYrgJ9W9EHASUb4+KoHiF0M1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FMwqNp2l; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FMwqNp2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKNGCHKvAvLY652WRx8WOYsoinpC8ceoXEEEZ9ovrjvBJcH6KHMwu//ifoyRTaM9XDrMjRnsmS9Iu+/j0ht35qcIBvJmC5vWK2IEVDdWHAmrpNSwqm4kKWMAyK/yBTMRIC6xwB2m+AtyF74e96cA+U915AGjO4gi40ifU+l/cCrVvrI4OFrzsKEVn+wIjirGKOmF/hkmD0TykWfViQB/a6n2n89acv42WcoulS0Lu9wf0k+PbzuxOA3UuXkqtbc6XcRKMIaq+1EDuUAzgsJu0JOE5CXbqRvIHA5LP/rsfrv5aRSIils00dRyIBNdCo/HWDzWWFGxmP4WU5ENHENaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xL4MfQ5j7n2Q3rEPE1H3GkSnMYepUpzEbvIdUcr/G8=;
 b=vP/lLNhMcVmJ1U53XKZX9MynqtaITVZVdpccpFPfgssSIF07z9RA3lbP0OFyta0AGwuOxEuMVHQBJYNaP0ZCOjD27cn/RuuEqbSxEV9x1FoujKVQKGZo+P0ql/xTKYj6vxDsDvu5ZTXRhXJ9DKsE8w9Z5Kt8Q3nPmmLhYjCNpfjuyeMF0N0wbCZD71JtanywwRp+lwa6MGtu7tBivQGfTx42rWnTemZaVM+ZgYjOWvgvZl2OSiKKJhEJ4/YV6bXwedP3YqCr4yPNF9PE/WMdAhs6SmF9sbPQlCFXNxtxXeRyBX7QYXQlKz3m8L1DwGe+2VV5Heg9qi51Eq2A4FvT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xL4MfQ5j7n2Q3rEPE1H3GkSnMYepUpzEbvIdUcr/G8=;
 b=FMwqNp2ljmgGKrZsAw1/1inxgH0F3k2u39CuFFHnHzXGtXuv+pLfhrEH4SD5kEKDyazRr4bVxRSgiTkWL4mao5if1BbGuoE8PjU+Kq1SJFETJhXJs9t4ssVcPJC1qdAoOqc6DeFhflH0v8wBUrQ3YmHOhUN8X/+r0XhaGpqOpE0eIY4ZBIsrh5GnaAL6BsOHp5X0PoCLrK1eApxKyzC0ENgGs795GQMNBPaaA73b4IjwohXA/cRWR2on+aNDulxO5F8iIVOwX5iSfL4D5EdA0djoomCISEao97xv2QyXkH04Ey8RMR6LN+NZYLwEDOe5QaFqX4TugE1tTlLYBl2nDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.14; Thu, 5 Feb 2026 21:32:46 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 21:32:46 +0000
Date: Thu, 5 Feb 2026 22:32:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYUMeueUpqakv8lR@gpd4>
References: <20260205153304.1996142-1-arighi@nvidia.com>
 <20260205153304.1996142-2-arighi@nvidia.com>
 <DG79ZKS630EW.IUD2PSCREXDF@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG79ZKS630EW.IUD2PSCREXDF@google.com>
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbd6d5b-bc44-4a4e-ed93-08de64fe1a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVTCkBtmAvZx581M+7A1t6KMFAQdh9DXuHIGhzeOkoEsPmBqwb7iqINcvZla?=
 =?us-ascii?Q?BboudPYuGbsHLWFcRRCErvD6hfuNrG4UraYaXJ5TIreGjpBDa4R3GB7lEckq?=
 =?us-ascii?Q?zRSotDbWDFLdIyOrPVgrU3saHlR4cfBghyeHaNl3VGjPvaL2njTyMKxuA0wx?=
 =?us-ascii?Q?ouCUywtphJYUKSsGJpUsPHuLZdTwlMIsDa5G0u9ltaXYYPsyYPzbWzNrcDAA?=
 =?us-ascii?Q?xWCBvBGHvHQK/H8JC688R7A3WukeCLVU55hFH+8emB/jq4U0a3PzmeeURkTH?=
 =?us-ascii?Q?cBe1yJTPBCC96ss4ehkbWj9uAv24QmK2iQlXok0i5Lve90Qe1RjnoOPPEQy/?=
 =?us-ascii?Q?E6kH8ReTIYtmUr883rzyLfA3a0jU5PSaUzFvZ3uo7jwgxwr6dpZI2DIdZxt9?=
 =?us-ascii?Q?DRyPeaCMA9GjFRi+W64Rhdo4pf72R295mPtDCnOyT5UGwzpktaycbnjZc6OT?=
 =?us-ascii?Q?45s0cOsJHGORKFsz6cCr/iECDBED5d5vmm880DvJDTfxFK3a9+n3N2LmgVqh?=
 =?us-ascii?Q?ZsmMnO8PfpUc9hf8P4Uh7nKwXY58cmDjM28iCStbKNZ0l3CavFhmaGxSJh/v?=
 =?us-ascii?Q?EoMBf44/DjR8NvNkTZvM0MhiAQXH7d5nj0tUN+q+lMUEAF5LDTIAcuz7m8W/?=
 =?us-ascii?Q?sUMcLqg1nhoVC3JHnvaSv7NAwTTn7gd1tcZl4SneVevbOT2Xb+TrwawNU0ht?=
 =?us-ascii?Q?UOrQa+EYpasaNzIgy0N0Pcb1XF2tWTwOUDiRI684z+XSLQHz7V8Ov2gfwTOs?=
 =?us-ascii?Q?lLWIVrhO7N/XDwf2ZbEWUtOpy9cMhrUoGZNw6S/Qv48rdtM4UpTlHezmi8GN?=
 =?us-ascii?Q?eTvlGxZVuMOXF9bJ33fjvauVc5BNXjCSHBGAOHBB9Fa+0DyA/GNThj0xdi7H?=
 =?us-ascii?Q?/8P+3rP8HBKCeN3iQKmkjdYKl/loosrsc1TJVTpkDNEf23/un5Rb0UTF09cE?=
 =?us-ascii?Q?5v/A/lt5J6htboP/jn0NO1Nt8CWALlSiaq+hfZ4FCHsNSyGOg9e2Ng1vH7cO?=
 =?us-ascii?Q?2V74milLiq6zyb+U7Z3tX6MIJoSj39fafCCVLau9gwAzQQaQVRXgbMfu5QxJ?=
 =?us-ascii?Q?btB1mSDqemKbZJistgKeYX+nrBiYJwfTfHGCG95mQAbHz6/HezQ8aJz1cqhq?=
 =?us-ascii?Q?2e82UgDW9UCZQESl5afYsiaH8jGQviw3vqzqQE1zJNzsmA01Nmd8FlsKFbF1?=
 =?us-ascii?Q?AZwcdo9ptMYJdAKw/jv9wWYjinBDmysy+IZMGsv6sT2d7eY0YT05X43B/ZsZ?=
 =?us-ascii?Q?hqikbQgJBssw9Qr7v0sDFnP2n8uH7qYTWb9D77hVbQSBGm0Ux2ewjOmSZWMN?=
 =?us-ascii?Q?87fNHFUSCMVnYdO1vt4e4XcGas9jtvAx/Gc+GwckTGyW/f9xOsYsNPWMROl7?=
 =?us-ascii?Q?njNHs9CDEssWtYO824LYCosbH05pL4qvufxDKy+M+i+3fEuOItCPENJLObws?=
 =?us-ascii?Q?4CYPSbYPqqed9dSqDjeYa98unZJNMjGTTxBezl/qrw3bpZiBBjny/L1Zk5IH?=
 =?us-ascii?Q?47+BVzA5stkQVKZuqVg6h9+szeWBnUJbnaob+t9ZYW61IVVsAw2B9w40wkN6?=
 =?us-ascii?Q?eTi9fHDkoO18M9fsmnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fE2z1SxhCJ0rKMrm0u9lKbgCBuyOg/6EdUUgV479Wf7uNxuuOYny1bKeodtv?=
 =?us-ascii?Q?tEWqWurS8YjwCpLdoJxEeweI+H5Rlw4l5nsk9ZEmSIMxbdGP+NXhwHPKXJ2P?=
 =?us-ascii?Q?gk3Fr8PkOxuOs2ziAOGnrC8VB4kfC3s7YxQ0EWmv0LKTjVsgigOvkCRBFu7K?=
 =?us-ascii?Q?KlQzbI9hJYFK1HnJ+ruLvXzKDaDYhPoM6dnPGC2IR4vvH8FTC+ffxPZuoIN6?=
 =?us-ascii?Q?6sMhrzsfHIJouN1zjr2qdSwp43NhbDN01LGF8mZn/EGENuIsS/o9HxJKQOcV?=
 =?us-ascii?Q?Jd4pcLJ8EdMRnqnlZaRHSOw5SQq16iJDo7PO7ALYqwY9agDC12YNXJqIS1Cj?=
 =?us-ascii?Q?m81j6iBdlDQL5HUc772yFAER81CXg0qOTK97hxMcPwk1hYVNTG3BDofHo7D5?=
 =?us-ascii?Q?Gka3cGchK+H7t1H4eVuxoH77iFTjGLIfr8btZqU/2dtPgJmvy2xEkXpISakw?=
 =?us-ascii?Q?o0MHqEqDws/RHzE0SjO/OHhPD9h1NSQDfdSNBknAiGS+duvtVPSs6gMZk+ZF?=
 =?us-ascii?Q?nyRvLPaxtnsET4fzDuOAa4nuQOwwmmtYVzfPz2PW7X7gKQ2r6iBLFynb6zXn?=
 =?us-ascii?Q?9LqRXwXhBR3gyOxDEKG2casQnuf4M/0Aq0VX1pujzhEEQCbfgBf8xgUY+2nP?=
 =?us-ascii?Q?Jf+qrLGbrHlf9OL4k+mCBGUJNznTOZocj8pEXXG+ZNGA4EnWIK6kcZoO6znQ?=
 =?us-ascii?Q?rYJxLib2dyA1kIHDaqkY86hNZ1DZzlMGQntO+Xxkld3s5mGqIRxSoA1d1ejS?=
 =?us-ascii?Q?j+VDrudgXf7IPi4v/7eHfdFjldR8SNeEdZU5UXVerSicPJVNhUEVyWexf/7r?=
 =?us-ascii?Q?Ctm8yC4vSYcbvJgFjyhYM2n0Dl0FVilhWxMkqRoJesi3MiO9eBr6B/Xp5JyT?=
 =?us-ascii?Q?w15gvcIJwdyOYoDA0RneaYgM6DByC5aOHGUXVugVF7s0kx+VXFX5RxXNTg84?=
 =?us-ascii?Q?gddlhN05UmQr2o/s67R7FxmQxgKK8l91OsUzst1TjcpqhWh8rzo/Q4gh67gM?=
 =?us-ascii?Q?enddAdHldZE6kgZNz+VLrzRR8uJMq9dbHZ3XEN7rtFS4vZlzJYGwHCEQ1ZdE?=
 =?us-ascii?Q?oL0+TcXHTKnEzTFl2Pa8PCeaJFO3EHTDZ7yeQMBVcWc/O7/s78so5FoSn+lV?=
 =?us-ascii?Q?sGyfNNLVmP9+WnPWO/hLPAbiXn7DeRrvxzKqtiVTm/+sG3i6BLhJJx+2+4o0?=
 =?us-ascii?Q?z7sb9/C+Lh6MdXT7ycY0oQnz0VWTQuuQLx7pEDpbB3rYGpczJDHtNWPRuZnO?=
 =?us-ascii?Q?oFY6hyEH+K5qoP5yUQEbe/FmL6fkL8q8HDblQb457AwwDMkPMREn2VebazMO?=
 =?us-ascii?Q?58Wizr/Z3nv2MYl5aKr62DBUYRLhkN7xBDFWtI5uWPDmbL+i01fEfVIjKDPF?=
 =?us-ascii?Q?DxBI8NSnooTEtKB2KcmWEbiwrZsoQMxIK8HWOO+ido3R5CGQdri4BKk1jsMw?=
 =?us-ascii?Q?VkgHVay5zksyTqz/evdgUx4fwW7Kdj9yDXDHWHJrWPS3QB0Q7LweulJSLBEK?=
 =?us-ascii?Q?qC1PRqbCe+XQhGJvhNICy5mpqTKtxjFEwVZ68eaDtK+DTeQB9FdFJ4/9yeK7?=
 =?us-ascii?Q?0bDBaLhIyuN+2AEyquSoFh04AQx9RlyU4D2ITTJitmpab4LPqwyu3ywjn1Oc?=
 =?us-ascii?Q?tLLQq+qYUT7BxtMr8eAh9FsL1U46vDvUMSuBT4xvkVwqYdFPS7c5bKsWfu9f?=
 =?us-ascii?Q?KI2uT2F+fF76srDov/o9sYsdFPOchnnmMNH1VBemZV0NI5dD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbd6d5b-bc44-4a4e-ed93-08de64fe1a3f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 21:32:46.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKDLw9QUud9xaUnjKo4Y7qLBPrw9baqMnUTmFPQtKs9p4glHsMDp3izdgTAa0jf/yEjVPWPB3wyo/rzU2CcLCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

Hi Kuba,

On Thu, Feb 05, 2026 at 07:29:42PM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Thu Feb 5, 2026 at 3:32 PM UTC, Andrea Righi wrote:
> > Currently, ops.dequeue() is only invoked when the sched_ext core knows
> > that a task resides in BPF-managed data structures, which causes it to
> > miss scheduling property change events. In addition, ops.dequeue()
> > callbacks are completely skipped when tasks are dispatched to non-local
> > DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
> > track task state.
> >
> > Fix this by guaranteeing that each task entering the BPF scheduler's
> > custody triggers exactly one ops.dequeue() call when it leaves that
> > custody, whether the exit is due to a dispatch (regular or via a core
> > scheduling pick) or to a scheduling property change (e.g.
> > sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> > balancing, etc.).
> >
> > BPF scheduler custody concept: a task is considered to be in "BPF
> > scheduler's custody" when it has been queued in user-created DSQs and
> > the BPF scheduler is responsible for its lifecycle. Custody ends when
> > the task is dispatched to a terminal DSQ (local DSQ or SCX_DSQ_GLOBAL),
> > selected by core scheduling, or removed due to a property change.
> 
> Strictly speaking, a task in BPF scheduler custody doesn't have to be queued
> in a user-created DSQ. It could just reside on some custom data structure.

Yeah... we definitely need to consider internal BPF queues.

> 
> >
> > Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
> > entirely and are not in its custody. Terminal DSQs include:
> >  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
> >    where tasks go directly to execution.
> >  - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
> >    BPF scheduler is considered "done" with the task.
> >
> > As a result, ops.dequeue() is not invoked for tasks dispatched to
> > terminal DSQs, as the BPF scheduler no longer retains custody of them.
> 
> Shouldn't it be "directly dispatched to terminal DSQs"?

Ack.

> 
> >
> > To identify dequeues triggered by scheduling property changes, introduce
> > the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> > the dequeue was caused by a scheduling property change.
> >
> > New ops.dequeue() semantics:
> >  - ops.dequeue() is invoked exactly once when the task leaves the BPF
> >    scheduler's custody, in one of the following cases:
> >    a) regular dispatch: a task dispatched to a user DSQ is moved to a
> >       terminal DSQ (ops.dequeue() called without any special flags set),
> 
> I don't think the task has to be on a user DSQ. How about just "a task in BPF
> scheduler's custody is dispatched to a terminal DSQ from ops.dispatch()"?

Right.

> 
> >    b) core scheduling dispatch: core-sched picks task before dispatch,
> >       ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set,
> >    c) property change: task properties modified before dispatch,
> >       ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set.
> >
> > This allows BPF schedulers to:
> >  - reliably track task ownership and lifecycle,
> >  - maintain accurate accounting of managed tasks,
> >  - update internal state when tasks change properties.
> >
> ...
> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> > index 404fe6126a769..ccd1fad3b3b92 100644
> > --- a/Documentation/scheduler/sched-ext.rst
> > +++ b/Documentation/scheduler/sched-ext.rst
> > @@ -252,6 +252,57 @@ The following briefly shows how a waking task is scheduled and executed.
> >  
> >     * Queue the task on the BPF side.
> >  
> > +   **Task State Tracking and ops.dequeue() Semantics**
> > +
> > +   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
> > +   enter the "BPF scheduler's custody" depending on where it's dispatched:
> > +
> > +   * **Direct dispatch to terminal DSQs** (``SCX_DSQ_LOCAL``,
> > +     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): The BPF scheduler
> > +     is done with the task - it either goes straight to a CPU's local run
> > +     queue or to the global DSQ as a fallback. The task never enters (or
> > +     exits) BPF custody, and ``ops.dequeue()`` will not be called.
> > +
> > +   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
> > +     BPF scheduler's custody. When the task later leaves BPF custody
> > +     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
> > +     sleep/property changes), ``ops.dequeue()`` will be called exactly once.
> > +
> > +   * **Queued on BPF side**: The task is in BPF data structures and in BPF
> > +     custody, ``ops.dequeue()`` will be called when it leaves.
> > +
> > +   The key principle: **ops.dequeue() is called when a task leaves the BPF
> > +   scheduler's custody**.
> > +
> > +   This works also with the ``ops.select_cpu()`` direct dispatch
> > +   optimization: even though it skips ``ops.enqueue()`` invocation, if the
> > +   task is dispatched to a user-created DSQ, it enters BPF custody and will
> > +   get ``ops.dequeue()`` when it leaves. If dispatched to a terminal DSQ,
> > +   the BPF scheduler is done with it immediately. This provides the
> > +   performance benefit of avoiding the ``ops.enqueue()`` roundtrip while
> > +   maintaining correct state tracking.
> > +
> > +   The dequeue can happen for different reasons, distinguished by flags:
> > +
> > +   1. **Regular dispatch workflow**: when the task is dispatched from a
> > +      user-created DSQ to a terminal DSQ (leaving BPF custody for execution),
> > +      ``ops.dequeue()`` is triggered without any special flags.
> 
> There's no requirement for the task do be on a user-created DSQ.

Ditto.

> 
> > +
> > +   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
> > +      core scheduling picks a task for execution while it's still in BPF
> > +      custody, ``ops.dequeue()`` is called with the
> > +      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
> > +
> > +   3. **Scheduling property change**: when a task property changes (via
> > +      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
> > +      priority changes, CPU migrations, etc.) while the task is still in
> > +      BPF custody, ``ops.dequeue()`` is called with the
> > +      ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
> > +
> > +   **Important**: Once a task has left BPF custody (dispatched to a
> > +   terminal DSQ), property changes will not trigger ``ops.dequeue()``,
> > +   since the task is no longer being managed by the BPF scheduler.
> > +
> >  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
> >     empty, it then looks at the global DSQ. If there still isn't a task to
> >     run, ``ops.dispatch()`` is invoked which can use the following two
> ...
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index bcb962d5ee7d8..35a88942810b4 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
> >  /* scx_entity.flags */
> >  enum scx_ent_flags {
> >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > +	SCX_TASK_NEED_DEQ	= 1 << 1, /* task needs ops.dequeue() */
> 
> I think this could use a comment that connects this flag to the concept of
> BPF custody, so how about something like "task is in BPF custody, needs
> ops.dequeue() when leaving it"?

Ack.

> 
> >  	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
> >  	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
> >  
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 0bb8fa927e9e9..9ebca357196b4 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> ...
> > @@ -1103,6 +1125,27 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> >       dsq_mod_nr(dsq, 1);
> >       p->scx.dsq = dsq;
> >
> > +     /*
> > +      * Handle ops.dequeue() and custody tracking.
> > +      *
> > +      * Builtin DSQs (local, global, bypass) are terminal: the BPF
> > +      * scheduler is done with the task. If it was in BPF custody, call
> > +      * ops.dequeue() and clear the flag.
> > +      *
> > +      * User DSQs: Task is in BPF scheduler's custody. Set the flag so
> > +      * ops.dequeue() will be called when it leaves.
> > +      */
> > +     if (SCX_HAS_OP(sch, dequeue)) {
> > +             if (is_terminal_dsq(dsq->id)) {
> > +                     if (p->scx.flags & SCX_TASK_NEED_DEQ)
> > +                             SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
> > +                                              rq, p, 0);
> > +                     p->scx.flags &= ~SCX_TASK_NEED_DEQ;
> > +             } else {
> > +                     p->scx.flags |= SCX_TASK_NEED_DEQ;
> > +             }
> > +     }
> > +
> 
> This is the only place where I see SCX_TASK_NEED_DEQ being set, which means
> it won't be set if the enqueued task is queued on the BPF scheduler's internal
> data structures rather than dispatched to a user-created DSQ. I don't think
> that's the behavior we're aiming for.

Right, I'll implement the right behavior (calling ops.dequeue()) for tasks
stored in internal BPF queues.

> 
> > @@ -1524,6 +1579,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  
> >  	switch (opss & SCX_OPSS_STATE_MASK) {
> >  	case SCX_OPSS_NONE:
> > +		/*
> > +		 * Task is not in BPF data structures (either dispatched to
> > +		 * a DSQ or running). Only call ops.dequeue() if the task
> > +		 * is still in BPF scheduler's custody (%SCX_TASK_NEED_DEQ
> > +		 * is set).
> > +		 *
> > +		 * If the task has already been dispatched to a terminal
> > +		 * DSQ (local DSQ or %SCX_DSQ_GLOBAL), it has left the BPF
> > +		 * scheduler's custody and the flag will be clear, so we
> > +		 * skip ops.dequeue().
> > +		 *
> > +		 * If this is a property change (not sleep/core-sched) and
> > +		 * the task is still in BPF custody, set the
> > +		 * %SCX_DEQ_SCHED_CHANGE flag.
> > +		 */
> > +		if (SCX_HAS_OP(sch, dequeue) &&
> > +		    (p->scx.flags & SCX_TASK_NEED_DEQ))
> > +			call_task_dequeue(sch, rq, p, deq_flags);
> >  		break;
> >  	case SCX_OPSS_QUEUEING:
> >  		/*
> > @@ -1532,9 +1605,14 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  		 */
> >  		BUG();
> >  	case SCX_OPSS_QUEUED:
> > +		/*
> > +		 * Task is still on the BPF scheduler (not dispatched yet).
> > +		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
> > +		 * only for property changes, not for core-sched picks or
> > +		 * sleep.
> > +		 */
> 
> The part of the comment about SCX_DEQ_SCHED_CHANGE looks like it belongs in
> call_task_dequeue(), not here.

Ack.

> 
> >  		if (SCX_HAS_OP(sch, dequeue))
> > -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> > -					 p, deq_flags);
> > +			call_task_dequeue(sch, rq, p, deq_flags);
> 
> How about adding WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_NEED_DEQ)) here or in
> call_task_dequeue()?

Ack.

Thanks for the review!

-Andrea
