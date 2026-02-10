Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151833066A
	for <sched-ext@lists.linux.dev>; Tue, 10 Feb 2026 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708555; cv=fail; b=L15sjerZlLMHeZLRjx51LQU6ZH+/+/8aaluiU1YCV7+B8OuMNq1eI6bSDmg1fy/3kvJc3ndsKWUvTHY8ilE45ENla4+oJTYEx79QBuruaBNLsKPTTP6WH8P0FVqypdEw2IJgBhApx86ZiGHNCr6EmpU+MjFKuRp28lgsvoJfEmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708555; c=relaxed/simple;
	bh=0rHYUHHcqQVJfZwQGNJx34EFum0SQ2gHqoQztS4UD1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFe0UMHN+1HayIaBL2ClGbP4pL/HnqqrcZulSu1Cm3BfYTs8kWb+96vEAnRgx38bYTP8C277FFo4sUY2krqT7Q/PJRV/ltXL6hFUShcte995uTFmO9+13h2ZNXhnt6Un9PkD5svZ/w9mlleAF0+V2y+4/w4PibQ95mjgBiPlN6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mg2FPfcz; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mg2FPfcz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYOi6L8BsSPqGjzWRTxcM2YEflkS6J67/UZPxebrgSjcXY3vabvVT+9Ta2pPDzGJCVW4KEqXQpw+O4cnqYriDOReixmmcGzQw8FIjJzo7u1zSS0YlSmu2c1fbVxD3GpItaq6zjpjjKRpwxyolmseuGJimJYPKmnugqf2W8C2YVYK2xYSG2kpG/4n+U8fVRokk7aC/VHBN8wzVxsbxKCSK2V9Hp4etbIlsYt5VVK5qxdG4pEV5XfkNF524e1kwE1AEt/r869HfQ6v/RnkkFopuse+Id6rqaOCANCR+IoBW0izILjMAh62usLCtlX5niFq/oIrUuQut3N1Xg4JRxd14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBoW5LeZNq3dVdvSTrTzHrWUvtr3v3JbtBQ3bao3IQw=;
 b=B0kX9aCzWII11g52R87LFLvj6dx8hboauii+xFHgJ3WQU0yy0X447nrgygdvUjMFNrvatqMonjc/0S7Jsk3+qbgpoib0ukJyMk0RSSFMlAJ0mb97imDCPfvCfx9YM52ma5lg/ZqN1dcks3JmTZJL9CIcJt1cFopNXHxCHB6vQl8G5beWW1Es6l0YnNII7zyngeoyvdHC4mcEnANdgLxKaHFzm1ygKr2fEObuNxPpJKeCzZMz7DijZVXBfC1iaN8nLiCJqiyarnRhEsuOYwBUWRfsF/Sa/nmAeItVEV57JBTrAIpJRxNC0HAVRpMvkHs29l0eK8nqmgweV7UMD41jmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBoW5LeZNq3dVdvSTrTzHrWUvtr3v3JbtBQ3bao3IQw=;
 b=mg2FPfczuZWZq1o0QwQYOfizFrMAlauclcyEQk/CR+4HfiBkfOYPfTTTWzIkCGtVg62aaQlpoaosa0SEtF4b1V7ivOhOZfGbR5jBwABN+G7OAxjWJjs32bvEzPxXw6UNUr4/XRcySDlR3AX54KcbDtA68Iwsfd+xNq0qFWGcsaLgXHQ6VHun5FdtFlRRIfLGbdUl8Cb7RTMNQQXJjRT6B9yRFx3SDrhQHBS1p6tzSe13wbjMbnQ14Eg/FfZ1lb6YD7PQn/NG+8fkfFkU4rszn4IgQBtQlSIj11QPnIC8mz4pFctHCRFS6GB6GCFePujt8SaYxR6WOT2SJPXBSTI5YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 07:29:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 07:29:10 +0000
Date: Tue, 10 Feb 2026 08:29:06 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYreQnz5h4E08E4a@gpd4>
References: <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
 <aYoAmES8tKNZJkdx@gpd4>
 <aYoYECCY_k1IrGqp@slm.duckdns.org>
 <aYoyxIkzp0E5dL1g@gpd4>
 <aYo_NsAkKvyMoXYv@slm.duckdns.org>
 <aYpeG8ZUHKizSLAE@gpd4>
 <aYp-3IPOWMsEeEq5@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYp-3IPOWMsEeEq5@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: e9408844-7043-457c-85b9-08de687614df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yns06RtTWRn1IwofFc31JuOH6hPCuOt8sxXWI6dYX3+qMHYrG2rPH4398vSV?=
 =?us-ascii?Q?+hhPsna9OruPrE9k9FBIB3vKWBYYULEVSUP/nqvioEZu5HSU7avahdo+IRmR?=
 =?us-ascii?Q?Dd7QRFxMQpx+LiGspWGjvZA1Nrg3wC4vzB+G9MKnAIDjR6g9SOy1xKlhHeJ9?=
 =?us-ascii?Q?GQeFo8xNxiwPXtnIha6tJz3t+iOXyQvTSnzB7/ny6oE5JyYfDDZKTdtXNVK3?=
 =?us-ascii?Q?Uh6u8l97r9EnlgsFdTwW8mzDI45LwC5x/pQ7i0BjtUedaQDnfrsEEaOLOSd1?=
 =?us-ascii?Q?URX5cvwnLrK17llB7i4Kzj/7d+aXo5+Zu/5lmHt5Qw7zq05dzXSYb0IRSJk/?=
 =?us-ascii?Q?RJaZsSC0XmGkrtcBtziKi6dusnRbR6+skyQaHkhNwJLjLe0L6zacUxe9yWKn?=
 =?us-ascii?Q?NVplQM/+cVAPEuG59RrvHF8yWdrObyB4EGJ9PF95tvJ71PA88SIs+yX/Gb7E?=
 =?us-ascii?Q?+ycgaU2nG62p4ZxbtjA678c4w8NOyG93QDOlxaGcPJqIii/BSa1eiONEKPM1?=
 =?us-ascii?Q?29ZS9zfdkoY0bPtZsKMEqTvr16b79S0IA+5uxeCtBpVXwLuq1+znfB/Roow0?=
 =?us-ascii?Q?X+rm9b9cky/ZmXATb97bFtUbyXUZVa24ebK9Up0/Ax6YHs1oZ1Gkvp9LkKr+?=
 =?us-ascii?Q?aZvZEkysBNUBSteRINvUwWqylA68BIwbRYT4i6JfAOii397ggohCsX5XSPZL?=
 =?us-ascii?Q?PMgf+RZBlxdTYA/fp8fkoOxOV5OmCgCKIXr+mELToQ/UkcMKzfloy5VtVyNM?=
 =?us-ascii?Q?8LjR+8IVuyq+MKMnfY7/sKrLaJHWNbxt8hyv9k4DI2JRm80MQv0DHSY27exe?=
 =?us-ascii?Q?0+SKn+p1c5pGlAK1PXHF3BuCyrbh1TPiXt0nnFTud8OaU6ubhY9TbGyMSGkD?=
 =?us-ascii?Q?3eiriHGqqlQfy6rd6K42CaZmcYTMRtTsSX5g2GsQX+ozJmbylU/g7p4dXRCF?=
 =?us-ascii?Q?uKqUSi1L9shbXMEcdhEJHSzhjSM3eEV1vmkxfBDwEQktCWheJ+n6IB9fOlVW?=
 =?us-ascii?Q?uVLN5CDGTbS99v9XP5GYnPaSRk9hsp4H8m5dtofFIPIyJtvQB6cmhmsCkWFn?=
 =?us-ascii?Q?WiEpsLQteLPLI399foYqxlNvhCZ6CLq3ue0dfwQazf897ZCgGoTK764r/azJ?=
 =?us-ascii?Q?dXstDTCtCbudXwWbD3AeNoFnc4WFvI6hbwyArAI7jrWN4GH53xYIrwIpGGtK?=
 =?us-ascii?Q?1ak7JkN/jtnPBovO+G+GilzDyhRC+BJ6qwGdA+lq3tuR6lO8f7/l/GZvhxjG?=
 =?us-ascii?Q?WlycwqQjTwRgMu7AFGH94CBbF/mvQeog0T/mIimr1+ZqQ/egEkBGhySpWTX2?=
 =?us-ascii?Q?pR3INVE43gJv3hb4NLdi8NRGphth4pUx2c50vanJy6kOLv2JuoIFP1igJ1r2?=
 =?us-ascii?Q?5KEvcL3MOeUO4FzV8SAvAfSsfaO+GxlPMPLQLdWrqguV0dUJKTF4zL0pjewT?=
 =?us-ascii?Q?PZTAogF/5/j62W7afBZC7AlTnYFDSMNq9zUnx+LZ2ogJeZ5/Q1HFFEKQVMb6?=
 =?us-ascii?Q?2e2Dp8Pbnif/llZFcIIp+xt3KyMYSdTf/wuypQefiqJzQyZEvl4JI7GmjDkT?=
 =?us-ascii?Q?Rh1sA8EWjvW/T5VeEbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V9WHFEuZEbvMk/NiZjgzyr3d7BSaH82IY00JVnZEP+/s45ELq88ZzCAdWi/t?=
 =?us-ascii?Q?CY2ZanQFabQs0kYIFAoC0WyOlczRyJet+TRWhs+mV+QCjIuEM7uR/d1k1Hh6?=
 =?us-ascii?Q?EjcI3hk4ulbcfYCAnHnKmMPCMGzWHqEPklG76GNl33zHtFcMVI5XgdhGWt+5?=
 =?us-ascii?Q?TRD8NZTVoB2t6rlE3O5lLwKjbSDNZ/CKKZLwmFnIbS72d4yDwtlGmPhQrA6F?=
 =?us-ascii?Q?yhY5Kecd+iByXwE7y9tRrg5kNYT/vUduaBs2Mmb32FtJx4COCKuJ0kDLmwce?=
 =?us-ascii?Q?DKcFYDPzSvRZRNFyGZYln3bO/OD0885FstuH+Qw/ksf5YSfnwDRpA820PpGG?=
 =?us-ascii?Q?3zyA6YRpHOVJ5Jcxc5DHG39c7ZoClEA2ipv1xBKy79gYoQhDxxtlDkULtZcX?=
 =?us-ascii?Q?H5uA/cE0oMUwT98KpJFc4Igwjf+5YxTvfGCo1xyqpvcBEdeD+U9KLKx9rw+G?=
 =?us-ascii?Q?skK0QOKhmxInwVd5K2WWicM3jkW7a1lT1RnB5sZzeoqNIiIC5YWjmQ1D91Ip?=
 =?us-ascii?Q?IukExCT7Xt6tjkd73Yp5EKlnODz1Cx6rKYTO3B/mG1ZpKkCQaSHx8rcJ/Iwa?=
 =?us-ascii?Q?s+oGf9TLn4Ou0mkB/PkrHVcwojRLWIrZsmYihyRYUZFT5JGJvwz8OKrlBjyf?=
 =?us-ascii?Q?KXOcf4h96kN2VWMwScr6VE9c0XCbr+fmyoqyr6Mk3BhsMfBXd8b/9bDN/E0F?=
 =?us-ascii?Q?+kYkUw7diBnUtrnwrsbAtm/LfmtlSUuHR/IYWroKNx3xvYwcwqaddq3/WTDi?=
 =?us-ascii?Q?QZbbWbgrxgLnwlM5zT6O07tkyl1MpKJ2JmO1didWK5sVSPTINn+BWP429xSF?=
 =?us-ascii?Q?Qgbxs+KsAqix9vxmxmFDZde1Xmbjw5/15r4p/sbHLPJxdEZasU5vGeia3jSQ?=
 =?us-ascii?Q?rSyCXrrOMIkIG/HMQun6ehCQ9VANX+3/JQxXVx6PlGTGi/iRVRnVk7fBG/sB?=
 =?us-ascii?Q?wqvaEBEVVsTDkcffJTN2cDMMwmdg8w/50AlYti7XSOeX6O/HqHtcjkX9PxWD?=
 =?us-ascii?Q?qtU15zgvnpT3wrvVvkNQZQPjCRkO/XOyROJVfFCW0w821NqnPOUSbA8cMzx4?=
 =?us-ascii?Q?lPfoPxxD8Xry88+HjXVSUpMpdFeyEGhLIb+egDYb/fLe5cvz6+pOJoIT4PAm?=
 =?us-ascii?Q?Gp+0uGtxtvIi4OE0NCPtqT6bMgCOfT96BKnw7buHRRumpJwCwH0WLViTY8Ug?=
 =?us-ascii?Q?h0FD3bTmMGXhlWjNeho6DAKByPoJi2FP2YcWdSNrBBTu3paPEYz27+ggFIWj?=
 =?us-ascii?Q?rSl2Y011BUS0ojselyW08/A8bwZzOweHZhRKZjcqGr17C4tBUuGja4occtZ6?=
 =?us-ascii?Q?dScGSP61vyGpDJlPl7QKrKfpsWIgDr0yYHYVVcPqiBp1btbQ8cyvNxqKXgKq?=
 =?us-ascii?Q?OSQdzlGfhRXopZ5+qSdD9q4bUkRKEa1S4SiW8OigvydR1crDtnp69QF4LPA5?=
 =?us-ascii?Q?Kq66OlSenRqeb+9q0eg03sU2c9mC0wQJom5FxymqmttBFvLXgtnM1reH3APl?=
 =?us-ascii?Q?mAxiTbBi1SB3HIKHRl9wTWbHmYgl0SvGpTJg/7yGafHilTMO8lgOTC5dMexP?=
 =?us-ascii?Q?aGgUe+O3io+Che8cjqVrv+iDVYs3d6udTcXbN9cPvPGFkrCUSevBER6k8L5d?=
 =?us-ascii?Q?M8lH7x/PId/YQ6+FpzrzblX/SYZeam7CQX7R5SSCx4wrzhztglXjW3CXuliF?=
 =?us-ascii?Q?hZaELf6dB5NbM6AU2r6UhTwJRr+ZHdfQUhxiu0wkE8wRbt7L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9408844-7043-457c-85b9-08de687614df
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:29:10.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8V12mj0VLSkIRMSyZbQKjC5TLlaknbontX8XJMVWa56Wcy6mQP5ImG+vxAgTgpXWknJbXIccmCkdVa1zu7fcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

On Mon, Feb 09, 2026 at 02:42:04PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Mon, Feb 09, 2026 at 11:22:19PM +0100, Andrea Righi wrote:
> ...
> > Ok, what you're saying is that a direct dispatch from ops.select_cpu() is
> > just a shortcut for work that would otherwise happen at the head of
> > ops.enqueue().
> >
> > So, while ops.select_cpu() itself is not "being in scheduler custody", the
> > semantic operation of dispatching a task is still the scheduler taking
> > control of the task. As a result, a dispatch to a user DSQ from
> > ops.select_cpu() should be treated the same as a dispatch to a user DSQ
> > from ops.enqueue() for the purpose of triggering ops.dequeue(). The fact
> > that this happens in ops.select_cpu() rather than ops.enqueue() is an
> > implementation detail, not a semantic boundary.
> 
> Yes.
> 
> > Under this interpretation, storing a task in BPF internal data structures
> > from ops.select_cpu() should not trigger ops.dequeue(), since the task has
> > not been put under scheduler control yet. However, dispatching a task to a
> 
> Also, ops.select_cpu() putting the task in a BPF struct doesn't affect
> what's happening in the enqueue path. ops.enqueue() will still be invoked
> and the task will be transferred to BPF side iff ops.enqueue() does not
> perform a direct dispatch. Imagine the following (unlikely but possible)
> scenario:
> 
>    CPU A                                   CPU B
> 
>    ops.select_cpu() puts task in a BPF
>      data structure
>                                            ops.dispatch() sees the task, dequeues it and
>                                            dispatches it to CPU B's local DSQ.
> 
>                                            finish_dispatch() runs but the task is still
>                                            SCX_OPSS_NONE and dispatch attempt is ignored.
> 
>    ops.enqueue() runs and returns without
>    doing anything. Task transitions to
>    SCX_OPSS_QUEUED.
> 
> Afterwards, the kernel considers the task to be owned by BPF but the BPF
> side thinks the task has already been dispatched. It just doesn't make much
> sense to do BPF enqueue operation from ops.select_cpu(). The only reason it
> works for direct dispatch is because the kernel defers the operation to the
> enqueue time behind the scene.

Makes sense. Storing a task in a BPF internal data structure from
ops.select_cpu() doesn't prevent ops.enqueue() from being called and it can
introduce racy behavior. So, putting a task in a BPF queue at that point is
just extra overhead and provides no real benefit.

In other words, the only thing that makes sense for ops.select_cpu() is
direct dispatch, attempting any other form of enqueue from there is
pointless because the ops.enqueue() path will be invoked anyway.

We should probably document this behavior to make it explicit.

Thanks,
-Andrea
