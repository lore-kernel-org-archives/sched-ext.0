Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEE1A285
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656185; cv=fail; b=KPj54a07+oZEJjnL3+JUvj+0v4MX5yog4cGryxl5k0+Cl78Yv+4ZrKIMQTwPH/dx9ghV6mZhmLtinF0kpBay65s0IP5XBeETbVq5RMMzWtDma0QvCs5dHO/DeUQf1AoshxtIFhlYTB4ZKWT/G4JlrZdT4J8f/FCm+kT1xubdaRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656185; c=relaxed/simple;
	bh=1Uw02Y16KZ8FEfk7RmA+YMSb/RtQGoCK3I5zJ7w3inU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OK5sp002dVXoMFhvu9YDUKrDqXf2ydsJuHLvACzKNtWyHyxUFOSQLbv0QhxkUNE5BPZf4yoLfQZTWQ7e6kOAOFKQjVRwY0l583MyQH9hFPDrVMX/05xewhWLizAM5OTbVDu+3I+D2EsCrKKlByv/6+PzYm/pe/Ebw8amMeIM3MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JQ63HnM2; arc=fail smtp.client-ip=40.93.195.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JQ63HnM2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEApXMZ8Zg5ZkkWy+6JahmbuilxwumLHOe4HKn6tLF6TwThCmB2Ha1d7Y6Btv6Cj/yQsG9kqVAPYyawIeU5ipkX/mHlQHYNxdaJ8yA8jRQ66cFz7ugv4tLxRnkGecACJPXHskrVc4a+T38cuVZEwSbFqJ5ScQ+RcpSfNinCIwyEujaCnvGb+4Nun9p9TAjuZsX/nao3TI75bHNNDgFJ1wIrjVsafowzuuONDSiBBYCTmVGF69jZp0odx1av0PP8HgDwXxhAT6UorLYuD1Q5PTRFDEHdCmW3DcZv1piOucdGshLipw0xj8lH1LToYIEHMS4osz/m4gy3PEOLtc9lJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gho9k663FkQ6ROwszfv/Tundy5ywRskyCjKxXFWyzhg=;
 b=YMjOyR2ZPFiQryGBXaT+GKo3NraJ5i2kSQHg4jCgWrikumtxLZeqX6Iwdo/S2j4AJ0SUde1Cpd4gNbM8XOhR8j4MLfYGktI3xsw0ZkkNw/pOrivkL4hxFhlaBvP25gG3N5WHQBFyRHS5cjE5iDeVRYHqhe06cawS+mPKPrFXjV54yO6lpcrA7hAdiqUJZ+GZKtmaN3VJz/9ssmE9qHxHkqoGJUQ5qviRw0zuRqLBpRCghJKCb/3L8ptUABB+FctoF63C4qEJJi/mFPfXUwOEiCBZD3Xi0X2nnkQu1+7XxJ7SD7qfPl45/pf7Z+A+6v03UrPiE08raE6CXbTSESzZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gho9k663FkQ6ROwszfv/Tundy5ywRskyCjKxXFWyzhg=;
 b=JQ63HnM2HF8WYzwS3Qr4vltzL8X9Wqe+89vPnIcneGMpt53xqcgO5c1Q6KM++CfecyEY5sN6+OKOqkP9eVQavElTteQZm9bQ7xOZCu3hEfHjaQr6NJ4bdWc3fkkl7iDDVWkNtTVTEnQU17Pb6ZBvUZKbbSLBFNDSKpi2I1mT67s7oC6wSEW8cB2BwarjgHUoVseGkZxprysoNgPV//JEY2rMPKnqJekktF6Oeah0Yx7u2uf0nEu3/CRWfqmQBXfhtl41WTOmJjnEiwy2IoQZw/utpGIAnlXmsxGnAg4c4HL50288pLwsTOiChixcPhQxW96WgQZi615/NVTF6F8KdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.34; Wed, 8 Apr
 2026 13:49:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 13:49:40 +0000
Date: Wed, 8 Apr 2026 15:49:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
Message-ID: <adZc8caEfOZw8TLE@gpd4>
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4>
 <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
X-ClientProxiedBy: ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4b7300-e80e-4d1d-7cef-08de9575ae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y7ZsCh86zjsdNrOtMsxFdCX6NK1zoAdUBFxmFU2PuRh3jun+m8IiqN1acyJr34n8uFlOAAITBIClyAFKCULDQx6ZMHyHm+hUv9ls2IjqMoueq4y5Jw+JF+rCAvm8+MuidD0e4UZfZcaN/V57SkBCaMifJEsxQwaXPUEMAUJb/bJ1OPiLMhpL1KmhbaSx2xAPgBh1r0Q3Q5nxKhIxxRGZwqp+t3J2DzyHE0S6rGT7hkwzMCY6Bs74aKd5YDy5QJOl49v3igexSfdumOZ4GAR33pLGBSW/gMPaBroGyXEVgi1gVRzBfIWMlqBNXBrMfqJCinwzXkjMKt/k0C/oX9JVPaW0EoaezeCVZS4EshtBOX022eO9AniAAIvZfF2f435gH0EUbMQNVa+MY81F93M+bOkCxKWSmZjecVZQL9+7ubEeOP9q2qis6695KCz1fFV6fhtHsqaD1RelkJQLBuzeV1kkcLs/TdfV/awKsjD7qwFhRPb6vrILSl0Qx3djcx56XcX4q/wJcPY7F/E5RQz8EK0e6kyXxA/I0R2C2iTgmyf3ChSgUR8Fr32Ox8PBSLT10dw6WB5evzgwTwVss2li8YimBsAPeP0SwbfFkqO+hSzYv28t28oI9WS5sBSOG9hRKlq3glOhTBqZVn/W66KWKT6ReiYV6BO7eJ7CgFObNsOxcZ3HXTeQPryShHnzEK8BcDo3HxNmlyef9Y6rUQ3nT3wQws3qqFtxiD7yqFuZs88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Ts58KGDVAtqiv97vf5tbb320Iyo/Hmxz7EEGxdejbHP0ZLg82km8YXA6DvP?=
 =?us-ascii?Q?tQim7EOGXJjh/jbQnhR/jqE3h31nH5kI5NVUcCbTuxlyO8zcuZOrI3YrRYM0?=
 =?us-ascii?Q?eUOwCFc3r96ku32jaLyjLoPETL0JsmdZByIDblUNjQZEBkmcJqrivdzLU5CJ?=
 =?us-ascii?Q?wn5pOdADqDtGImDE5qrM6K0X1X4ssIdGZTe4iTRTwwvjMAHn6YpzO3Pz/Nnh?=
 =?us-ascii?Q?UncU4+iKf+UDnWbgsTU0HYfEXHqpO3pM4FqpHmUuefhPKnLy/z0aVikH1dAd?=
 =?us-ascii?Q?InsQNZ6CzKfypn8K0KNsLeBXrQCCdFLjnPDuS2S2mEqmPiqmIm5A8d66Wf4I?=
 =?us-ascii?Q?8/wMtZvTHQZTofjSabLpbaA9GmN0o6OVaiw53muxQRybTazndnWMFhd3HXmA?=
 =?us-ascii?Q?4ygfx9pfJ15yH99SPe+npexoELYYqOU732jG/3r+IBGKpYclceCB1vWKk8Vq?=
 =?us-ascii?Q?vPRmJ0yGRkGBtsC1mrFcw4JTdUNwgZH2/+b6dZDkFqUfAwxaIPeTvLZm3KAV?=
 =?us-ascii?Q?PGUyQgTtW06D0PQ1BnkzQd333HxPr6tKYVUOaE1WCinoQ1xYlkgyx8OcIJt+?=
 =?us-ascii?Q?KbRpSSqzMZ0h8plLlyjXL9CwEFSeD+YHF6RELU2b0LPHTQk7WXfrzei0aSEP?=
 =?us-ascii?Q?U63SX9cMaDSoWZ+aAokn6BBEcI2YOpINfu7f1D5E0lHLIeKE8uAB/KCqT9Lh?=
 =?us-ascii?Q?fw0oJbZCM8drdglW5bpvs1AC/amJbBrpLxnRa7YVkRYlxfXV6axV+SqM8HlX?=
 =?us-ascii?Q?2jAyXPOMKS2ROsm4+hLr2BvKZSJjy6PBQDeiWNX70phTrlk3FCaWkwcIFHaf?=
 =?us-ascii?Q?WeTpcngF+CKpNx1xtGbt49Sitxvi4NSgDlOdBqqQMtL/Ot96i+qfgYMBOhv4?=
 =?us-ascii?Q?jnbx/jQup+RL54b2OxJKw91QFlK4QPBmEGReAgn73Y++J/KkzECrlMRnjSjy?=
 =?us-ascii?Q?4uoFnKFA4BpLKg8euGAEBX3+sy2p30kWKJSBNQB8z5Xe28ObGZzKvC6ri405?=
 =?us-ascii?Q?GplzO5weM7lUW/KTuDjZEcp7ke6XMcdXTwmhl1clwzKRXEKdvzqspE+QD9h2?=
 =?us-ascii?Q?iQFLgrbsbDImImU/jSnWMkmZhT1yb3GllnxoUxFlZvjjYmYJdkVWVCWjxM0E?=
 =?us-ascii?Q?cFTMuSh11K1AEU110tYtt8Ub6W0tQWHrm41tIqCY9Gpnv7GOiYleSLh8m6G0?=
 =?us-ascii?Q?1MFgnmg46yF9v7QnOI1EfzfxfTEsNn21udcihus1tYGKOb3USh1uyM36Xpsx?=
 =?us-ascii?Q?T2Jz3bpEc/RIfWtZwWe59n/HqqrzOBowPRDX5ITCik/eiIIK3CLY3Wmncukn?=
 =?us-ascii?Q?DEQWEKDYBx5nzNI4rFsSlciTFmiTH3wxTEU9YprlPTt8uMPQNDFseym54Ouj?=
 =?us-ascii?Q?ionOdt2I1cKwjTMjlSiJanCKbw4O12+k6x8LOaGH4BeCaGOhiScXbwJqfG6r?=
 =?us-ascii?Q?meI3X2IDpe55Cpf1MMarctfBU7hFqqr0TTs4WjHykcpzFU5Xmt6r7x5d3rds?=
 =?us-ascii?Q?v2P7C0/AZgUALM0Irb1dbMafE5XFx6p/E1KAocxZmJ4r3zym2PMl3ed85bqB?=
 =?us-ascii?Q?nbiwal9TE6FJUrr9idEr83YxxhpIK6y4BboE38dxJtPsTB8p7sSvyhLfsJ+p?=
 =?us-ascii?Q?6IX+B5MkR5U2yULSBo+Oeg0JvoP1pn7vVfLsmvwnsrUt/yJ/ztB7q3q3uVw5?=
 =?us-ascii?Q?aqbbCM5SQIV9G2cXo3IJpuoT+JkusojdUVw7wkVn8z2puBQb5FkO4flMFM6E?=
 =?us-ascii?Q?dHdxwl3uvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4b7300-e80e-4d1d-7cef-08de9575ae38
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:49:40.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4jqzLJV5+pBgX0PFrf2SoOx17OCwk/RGF/ztYLpfl9j0y0F0XU4h8kkIy25VrMEnwYCexmf2a3pjKC235so0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

On Wed, Apr 08, 2026 at 12:40:09PM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Wed Apr 8, 2026 at 11:28 AM UTC, Andrea Righi wrote:
> ...
> >
> > Looks good, but I noticed another issue, should we also change the condition up
> > above as following?
> >
> >  Documentation/scheduler/sched-ext.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> > index 29d36e248f58b..99df4cc982375 100644
> > --- a/Documentation/scheduler/sched-ext.rst
> > +++ b/Documentation/scheduler/sched-ext.rst
> > @@ -423,7 +423,7 @@ by a sched_ext scheduler:
> >          ops.runnable();         /* Task becomes ready to run */
> >  
> >          while (task_is_runnable(task)) {
> > -            if (task is not in a DSQ && task->scx.slice == 0) {
> > +            if (task is not in a DSQ || task->scx.slice == 0) {
> >                  ops.enqueue();  /* Task can be added to a DSQ */
> >  
> >                  /* Task property change (i.e., affinity, nice, etc.)? */
> >
> > Because we trigger ops.enqueue() when the task expired its time slice or it
> > becomes runnable and has not been added to a DSQ.
> >
> > This also represents correctly the sched_change() scenario: a task being
> > re-enqueued after sched_change() still has its time slice > 0, but we need to
> > call ops.enqueue() for it.
> 
> I agree that the condition should be changed, but I'm not sure that this is
> what it should look like.
> 
> Is the "task is not in a DSQ" part of the condition there to handle direct
> dispatch? Apart from direct dispatch from ops.select_cpu(), I wasn't able to
> come up with a situation where we would reach this condition with the task
> present on some DSQ.

The intent is to represent the direct dispatch from ops.select_cpu(), since in
that case ops.enqueue() is skipped.

Honestly I think if we change the && to || in that condition, everything should
be pretty accurate.

> 
> A more general comment about the pseudocode: I think it can be useful to
> introduce someone new to the general flow of the callbacks in sched_ext,
> but the documentation should be clear that this is a simplified view that
> makes assumptions about the behavior of the BPF scheduler itself (flags like
> SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
> the overall system (Can sched_ext be preempted by a higher-priority sched
> class? Can scheduling properties of a task be changed while it's running?)
> Without stating these assumptions clearly, we risk leaving the reader falsely
> believing they have a complete understanding.

Of course this schema is not a complete representation of the entire sched_ext
state machine, if we put everything it'd become too big and complex. I think we
should just cover the most common use cases here. Maybe we can clarify this in
the description before this diagram.

Thanks,
-Andrea
