Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B322DFA4
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064363; cv=fail; b=Xj7LVjtJuLIXoe4Mi4xjObaaNOPLSF+HzkGc+g8hUz+fH3S2DvHFX6bXeLfuX5yE91k0iPHukCWHs0ROGL6sLsbB4ojclaZ0I3IWMQ3oL1MX7c98DGTsCrtYSbtykx/2QIt5y8j267QfuyDBRHAlb0mvmjQwLHFAsIoemx7XU5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064363; c=relaxed/simple;
	bh=IAPv7MR1p08Ppr4T7tuz/6/Xjgz2laqN4v0dT75bvPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Foyu12BqAYoT9VAdFq63qeeX7hYDFIiDSKGqKdq2CLFeskBmlRT+UHYhGsyKGzkzkyutx8/8K+QilLm0UHxfR+hkZoEKYvD0kLdEzgFBPFCw/YGeoCuX/nvR9P39TfvecFxBRvsk2/EpLlnuAUkRDX7HItDehU4kILCDZdq7nGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ceOBydqe; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ceOBydqe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGNXUp+nbEwc7QHZduNZn8p+Gaxc1/TkuEMVV9rvgb/ClSVfhCqUiXjTIWwhs6kt3x/tYU2v6lslnsopkB1NfrBG+ekkG/XNyC9OvKhJJotsl8d9oOCT3o5osyp1iOVIzLa58sIQ4Mhpd+fgwDzshKMWctvCE5GC/W9Dk4HGahprwz7GGY6EK1RVAQd37fYXkKtjvisXmrWibR98uw4s/6OG/Re/P9gM/Z3WsSOt7+zXa42ft/VVvq7RruCao6eHgc1Yq8RoITj0VbmeLtTnO7lKwZXSpgct0orfLzwZf0EukWcmpbp6+BDcSPG4cEgEXYOsTTCZ4I4paypAtSSG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO3RY3u2NJDq9XM1aY5eqbIk5XmF6DtsZHiBV1YHVV4=;
 b=tsg1TP7mh0b1tYgFFFcaRWf7FGxiJRs36MK7GIMA6lXVFUuseWT4m8J1ksNoAyN/gQClXMI7tLX2P185ob/WPoosL3b8jjxE24pp4DbmuAYteI2jf8nps4p3ycEILIia2T3yK2KQIbuKjwtRu815KxjECQzts+7Q8RDd1B58Jdvf+1K0zZ1xuPfBRa4IkyOLld9NO3e+sBHYdrk1xclbc1Bu8FheKqk7iSmKxmlTHnTCbzdAbiznjb3wBZVUogflXbMskFd92T5Intkn5duLT6087UEBLPD9E2ZO1Tizobbslir5B/HYtOp6MlIfitK1aqHRwx3AELRuLG864VD06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO3RY3u2NJDq9XM1aY5eqbIk5XmF6DtsZHiBV1YHVV4=;
 b=ceOBydqe/vs0rvhm/Cb43ZKdTO4YsX4l071FO2TUGKUSWoUkswo2l0LT24jQagbuGmBJR2Lbi6cr+zjFWI+X7u6OoBlUcS8ZyVbHsBijKgMwHbKOiWqv3+kwtjPLCmaVA/8kM6ob2nKUwj3awOAzdl6BmU+p0sOtRU+kMSbmKtq7HciXla35ZKotEdfW0Jw/vxJrjbU5XNEE2TCPAyCwvZO08T/PhgBMaBuJk/vFOWTvOl/Hp++QCtjAgCya0X8f/o64IuVwjm/VSKiinpJjizDrj3fh5c8jOMAYtLwD+NFhq6Nf88czoUdMGl3dmicDWqR564pIuHelNy27WdzZYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 20:32:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 20:32:36 +0000
Date: Mon, 2 Feb 2026 21:32:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aYEJ4BCyw1tE7xOC@gpd4>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-5-arighi@nvidia.com>
 <20260202195035.GG1282955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202195035.GG1282955@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 19245fa2-8325-4a3b-1f37-08de629a3353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkEpHDJ9r7PPHqzkoWk3qQ0wrN49SNgSD+DTuODzpqugpwcuR35uRBiE832l?=
 =?us-ascii?Q?5jkS6fGquqqnv8obWgg0sKFCqaIF3/DvE2pxvxj9IhGThmvHuEpIWFWUyxnh?=
 =?us-ascii?Q?zWS8VIILa7Pf5QcoR2RnWhBRAvKZXaBQkzbKhq33PeNS8iw+k4izU7qoZZSp?=
 =?us-ascii?Q?oWHWoOeoJHcYgS6l3RSvVU5FlZ02HvHEaIGfw8pjlv1g3V/LYRnxCcl0VSMh?=
 =?us-ascii?Q?ohjfbRe7MlO5mxtZoeGgZk+5dTpCr2tJeX2yCN/vBCcIvqsDWcBtVEHWigq4?=
 =?us-ascii?Q?XaN1FCgHGCiValr42iuPWrT2VCmQTT+01jQLNjYoq78iwmugQdbAmZegC6lV?=
 =?us-ascii?Q?4ZDOdL6QHl6TUrpztplI+kXNLZAKY6O5XvifQzhzT1+vrhXxj6mZ6gY1fZvP?=
 =?us-ascii?Q?zrhyWj97aylL0fHwcFz9VE1cgcFhZYmwOqqW5D7U3iJJCqD9MzANcf0UrAtk?=
 =?us-ascii?Q?++cyPtFU+XyPXInsQ/5NZL0z3gR8OQvaCOhVaWJDQnsvPyZmtXobNEzOlTq0?=
 =?us-ascii?Q?TIepiNnm2YGFkXZcBx80WhTKYh7wB8/wzBZ3Ga5ApVs1YAHdvxSRnadecyrr?=
 =?us-ascii?Q?iOyMCj/HpY2qSMREAJRsLAhfYcM6PzvOQCX8kAcgfNrQgXLWckclpOO83++m?=
 =?us-ascii?Q?PoaPyaXxjcABaCmQP21+1JtzdzooXqou8BV/y+BiPKNwkn9cms71JxznwGjS?=
 =?us-ascii?Q?pdSb+VLAHFAVYaU9rFdYTFjAeyMNBsdc4IfBxJMXLY/4xxbb9TPS8ctQsnWR?=
 =?us-ascii?Q?bau+sy+aVZXY9bIbXZ8UqRFjXMHNGP344FzYdrhA1cEo0s6NlOC1wHl0zcCA?=
 =?us-ascii?Q?4/kEBSQOH0Z/5QJUuaA7gui0FpleyO4iD9Ca0rXqTcwHCCp4BBXO51Ke5Mx1?=
 =?us-ascii?Q?rTIOIZ3KMF+1fPeLKQNLTSjY0OS7XxhntL5cOXHhNpMIPD2P9ltF86teYPUD?=
 =?us-ascii?Q?I/nmcLu2EdUVR5G9bF0vnoVhRjYI39NjavD8ek1OgqwceAxCHjNMGzYKr1vg?=
 =?us-ascii?Q?n/xGEf1xp61ptm042tAfbn233+HruIeh6OUIr0nAI3HYWy+yXxvo7hTo1D49?=
 =?us-ascii?Q?IOjyMfBPNWcDUEHgyUO2qWiMU7H02mgx6l6tWeOiWZTUqfUNKQkO0YFo8PWL?=
 =?us-ascii?Q?THligbngaePwSi0dNQ15/dD0PETxWPypakRDAfzgbSij6a0fnb6CHEehWU0f?=
 =?us-ascii?Q?xY4Sd7iSJwuXkRIk/D5L7kI5ro7ARag6o4A6aI+3Y0rkoYRPcMQLe86mhV++?=
 =?us-ascii?Q?06A4K45u8lHJtgBZ13bPQThEPPf4Yx1nqpMN5QxxfmpOkzoWi5w8kMojkr+A?=
 =?us-ascii?Q?RDMcr/joe3oMf45V5LqPFxHU9R/D4cdELohsiBwKXKkwiUi8QNurmFeBkBN7?=
 =?us-ascii?Q?D4uxpvKKCLSdaWP4AgdfQX3Ww3en6nECQt8ngCMgEpYpMOQ+qCY50V6iUNBo?=
 =?us-ascii?Q?FI+spUiFnYPTtnFDtM/HK2vnsR5YwdGF3zXR1/35gU6jAurYWGNnB443Uf3B?=
 =?us-ascii?Q?Rt2hvgv+olboKczUbymHNh5RbG/1yS+ixcdCpBiJ8/2CUfHgE5BLs8F8TvDU?=
 =?us-ascii?Q?a7skgpOF1qzq7Czbt0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tySKt2jGtT4Un0jV6idbvjXSHlgGR4Ye/XRrK0tdshsAt8LwJjRfr0fIziRM?=
 =?us-ascii?Q?VqSLRwmOBkxLvziqCsIoR6Z9xQN2zrN02RSsF4zVqMjCbgWoGhS/xmCybFN0?=
 =?us-ascii?Q?sFBxJQRpFj7ziW4HP1oAkUWPbTBVzkDnSODLXBin6SEDljpyxqBWaYEk2Xl3?=
 =?us-ascii?Q?B4e+8uov0dWs8KLa8mAFfOD1znfMxktKnaqQqSx5zkdFqkUAHoOsEvvC/by3?=
 =?us-ascii?Q?+DCBKHJtbxFSVhZk5ZsU7OPJdYGR3XpGDWfPjtM9MbFb44LfLLwzLP0WrkM7?=
 =?us-ascii?Q?QzIzvAAyRGAbTBtkM5hMPBoAjg+213C0p6oNFbdvleV+4qwf0CTTuup9g2Sd?=
 =?us-ascii?Q?2sdCMA4eh5UQiqnN6zB5GXuT0wrsyaKKNp7hLOdNQVb1xJeu9ZUrFw7d3GnP?=
 =?us-ascii?Q?pIXWdM5C313Y+scLfseNSptp2cKNFBmfW/oIxCrzMkLgxdCV986po1+rLHWz?=
 =?us-ascii?Q?TEF5HHOtL5s6MT5AKwyDCKd5mmym7O92rHpKEJ7iZz5oScNqgyT5dPDOmkd5?=
 =?us-ascii?Q?pgie0ZblHCbClF9aUX/08zcMCyKJf4jwEArTKYPb8UUTJ3RFznkE8B6olwL/?=
 =?us-ascii?Q?dcVhnlpeKdcftcvyXMclBhpwfJcltON2wP261E8OTP8SqDGEK2uGjaO/Ip+H?=
 =?us-ascii?Q?1/fcHl1ezZbq5TMkqQ0pR9klCEin0bcV8+Hge0KYusFYFbYSVLUfbHsHFJZb?=
 =?us-ascii?Q?LwEYOIF6RqxLoc4pJimVJiuqtCgNDwNE3S+KHUoXnlMyk09/5z4eFhZLDcWY?=
 =?us-ascii?Q?n7q+6vXxY2H++Xd4+/OCyS4IKIcc/Zw3cPJXVFTe5Rdo4/MEOq7dToAJQdnA?=
 =?us-ascii?Q?uQcEJpQzHdCE4ybIQfftzyS/0ow6VMz0JC7HhKnBMR2wCMC2rUmNWgiYw5eA?=
 =?us-ascii?Q?bMwJBZQDGM5rIiT/bEdc+uTzVsLUw5o4NzlZegWtzOU71mDMELPojuPcXxfV?=
 =?us-ascii?Q?+9dDRAQ9RJd+nl9FnPIPTUMO6v7e0VAPUFM3IT5oVdUandTtguFEPrgwZlBD?=
 =?us-ascii?Q?9+raHguiuRCGS1KxaRI9FYO/asu/jp8PYDvH7y53GEKT+Fpvi0cuQNphM+GP?=
 =?us-ascii?Q?NoEgemG/C6X2fLlIRL3a0cana6gul4IoX862BpKj8UDgQzfOMsG7Ue7MxGBG?=
 =?us-ascii?Q?EFxU36krfVabm6PJu0467L6H9Cc7RGSsnxH9II1UNFCaetqkgpyjuC3HFwV3?=
 =?us-ascii?Q?1eaZNE954L9C5QfVHNoML+Q7RAattY98gCQLmTFizkeC93YJ+z4utCdrr98U?=
 =?us-ascii?Q?xdYCPCHJ0TTRhCn313XDpjXV3EYdMKfxXzLU4Su3BvZ2sZiLmeX1c+Oee9p8?=
 =?us-ascii?Q?atKnaXXK3kPWvA34X43ifoOdnPu6lzMXr1S8LrURJZwdvGotYbbjrgVzgTJB?=
 =?us-ascii?Q?htZUnc6lRvQDeay77wbMJvF4tKL53ixxdi3+JwnAmrlLRequwmu0ShKtIoW8?=
 =?us-ascii?Q?rLddVCP6cJQuYTzPS+NizMDBdF2ecK6JY/w8izPvqP4JnaT/OFh15gM2FsFP?=
 =?us-ascii?Q?5ZYAXbcnnp5jEtZwJOhWWyZsA/WvRUjtidwTslhzdHNvqa7Y79VaHPg7XcEA?=
 =?us-ascii?Q?lWfEEcGI013pAMQwZnTG6zWa1r/o1YaALtPLbDg/2tOTQwHugcA2Q6vzTS4Z?=
 =?us-ascii?Q?gM4SAYY4EGeQltBwqkaBT2mUU5Lj+RKrgUaa1yZGjfxPE9023HqzG66OcbmR?=
 =?us-ascii?Q?OPfXIgORK0l91b56EeLZUtUieuzVf3CtfyAbd/D+nflzTre7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19245fa2-8325-4a3b-1f37-08de629a3353
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 20:32:36.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV4JfK/u3Nodmacs2y0k7T+DC3CE20kimHoucuJQNgZOUK7Tg/6ikzxiIe0ca5ndQ84vt6HtvaRZRxvq+9tNRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

Hi Peter,

On Mon, Feb 02, 2026 at 08:50:35PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 26, 2026 at 10:59:02AM +0100, Andrea Righi wrote:
> 
> > @@ -3181,6 +3193,36 @@ void dl_add_task_root_domain(struct task_struct *p)
> >  	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> >  }
> >  
> > +static void dl_server_add_bw(struct root_domain *rd, int cpu)
> > +{
> > +	struct sched_dl_entity *dl_se;
> > +
> > +	dl_se = &cpu_rq(cpu)->fair_server;
> > +	if (dl_server(dl_se) && cpu_active(cpu))
> > +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> > +
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +	dl_se = &cpu_rq(cpu)->ext_server;
> > +	if (dl_server(dl_se) && cpu_active(cpu))
> > +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> > +#endif
> > +}
> > +
> > +static u64 dl_server_read_bw(int cpu)
> > +{
> > +	u64 dl_bw = 0;
> > +
> > +	if (cpu_rq(cpu)->fair_server.dl_server)
> > +		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
> > +
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +	if (cpu_rq(cpu)->ext_server.dl_server)
> > +		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
> > +#endif
> > +
> > +	return dl_bw;
> > +}
> 
> Should not this also depend on scx_enabled()? It seems unfortunate to
> consume bandwidth if scx isn't even enabled.

Yeah, that's a good point. We can just add scx_enabled() here. Let me try
running some tests with this.

> 
> 
> 
> > @@ -1501,6 +1503,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
> >  	if (enq_flags & SCX_ENQ_WAKEUP)
> >  		touch_core_sched(rq, p);
> >  
> > +	/* Start dl_server if this is the first task being enqueued */
> > +	if (rq->scx.nr_running == 1)
> > +		dl_server_start(&rq->ext_server);
> > +
> >  	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
> >  out:
> >  	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
> 
> So this starts the dl_server for the CPU the thing gets enqueued on, but
> SCX being what it is, there is absolutely no guarantee its actually ever
> pickable from there, right?
> 
> Does it make sense to delay this until its a DSQ_LOCAL enqueue? Or will
> it never get that far without help?

We could probably move dl_server_start() to local_dsq_post_enq() and start
the dl server when a task is actually dispatched to the local DSQ. I think
it should work, but I'd like to do more extensive testing with this change.

In any case, IMHO these are improvements we can make later, even in its
current form, this is still better than what we have and it would at least
address the recurring bug reports about RT tasks starving scx tasks...

Thanks!
-Andrea
