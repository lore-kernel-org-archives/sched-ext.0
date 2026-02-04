Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D363EDAD7
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219429; cv=fail; b=aHgEdLjLdvYguN8QGnwDlarcqbWJbvzAAdigI1yEdg17ULqRJ9aIqr6i2iN1GslTt+V1u3xUvCfFY4gpApRCRCIbN4Ry0xrt28Qjb9VGKdsPdIAUQWtxfr96LODoHpMxd87bwwr/XkjfHRg4tfc9Pmtp2tGOImijeoyTp/qsRP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219429; c=relaxed/simple;
	bh=/Vr9fo4CeDoSXca0lfW1j3EC/3iaQcO5/Jp9YO2kKAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oBiDsKukdk0O+UjZMp3RbQ/CT3A3sQE/Drqxa29FjLcxqZiMrg4too0QVwwad0OdWhYnhy18bb4+gtCBY7XTxUDtPte3Ukgjjvdq1HJj7uVNH3sjdpa3niEDkxKtuzU9FsgQYAQMW5uKuDF476PpJNpgdrGn+vQYmqh0XGnoGh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OUnhgLxG; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OUnhgLxG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqWoY8Qk5UXxZSqiEYlDsM1pUHRrOb1+rXpQUe9GAqvG+KfdKFMxa+v1v4SDggz2qTtqnLQT7lvkNyMSu8LcyC54boUOsXtl8suO4Yaxxb1mLpJlxwFZ4eGl14GpPckar09EuyRRR7lz5WC7DoGFy1Yj46XeyIYV9bI8bXUtxgxIvKsZU627cchfvLv2DyqF23zEK1/m1ZgrvBbFJWvVBkGY7YpOFixwYe8X5vCQlo+GjoacDUi76OHAg/vsEMmeJlV2eGRLM+UuAogXZoJYWuDsjXdV29WhS/maKo3ChblDN1Ii6PjfeE4crhhVm6l81wK8DY5p6BkoH4MWkB8xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKerSuJR4/cxObQe/Fqed/og+XqTDTvXhLzejuVD+HM=;
 b=TGM9jPB4DAJTsZfjPjzx4dX8nYhu5hqr2keZ9gbV4BbJprt8QoQzwRtoh1v4SqC2LEoUKPKKkdP97E+d6kFyMArFm58L06DynU4Rugap3B0RC2YVBsqcVxbUKcv4RC29R94CB32yv68G5MaHBqUD5d6K9aHR33WG/xCkqJLA65Ebz1UMjlkrBtMY1vPE4w/sH+RDMsa2Xre3pcrXpzL7rd/lDg2wRrAMEHQ+U+BHcjrMNaEh3umRXG02lMt7PRL6U/jjJS+vTn//qbpIXoS9W/DqSNQPgUTy/69zUzQxthQ1/Kce0WegU632zQEL+1q9JxchHLqb1YN7PUdSV2o9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKerSuJR4/cxObQe/Fqed/og+XqTDTvXhLzejuVD+HM=;
 b=OUnhgLxGdv5l6ihtIWKTtMmxryFprnZZ/sDO4Uq2DxBVtVySVxYpJTkE6UmlX9WGINeOaDVBT+k/2RIMDTTXwpEAVprtp68T3BtL2c/Se/4s1dB57/Yujq6z0HgcjVGLyXYxHLAqgBIuIy5MIk4iz5UjZ8hxLj81fxNG7Dvt0UdCNlQnM49VNcMZbVc+AnKCYeyff4QmRbVzy/MfIxQM1WYSyJSWr+YmxKd0SALBm/Qb9JT+vLX9lmDncFtvM8CyLbZR+giQpmKed6LpQPC1i7vn47uAvidOCvj4RvcHQuy2QVVQU+V4+xE8tBV2ZhSRBZdEvgx2sc2zgJq/s4hSqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:37:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:37:04 +0000
Date: Wed, 4 Feb 2026 16:36:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYNnmI26oS7YNuMP@gpd4>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <DG67IMOVU2GX.2CKP769EXJS12@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG67IMOVU2GX.2CKP769EXJS12@google.com>
X-ClientProxiedBy: ZR0P278CA0210.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: d3045f23-e84b-4cbe-f53e-08de64033f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dn9j9EoXe7rFiGlnUTaotldWf8TbDQH95aHEBHSvzGVz98t50Zl3ROS5smUy?=
 =?us-ascii?Q?O6z7FRt4sJjGIZJmkVRZjtx1GS8aVZvBqEJxqDBrwqWpiVC3Tnl/GcmdyO7F?=
 =?us-ascii?Q?Sww2vD6K4rJdYH1QdECiYjfCrbpYJbZZUQzxr13RO5Qv1Xwq199zi477/EuQ?=
 =?us-ascii?Q?eUceI0UhMlXS0SqADvNkmpohkpm/WJq6kgNyLmpErBvbB/XNTzJf53PHS83a?=
 =?us-ascii?Q?3NyqVL7KGp3C5+N+sWeWEEqgHe/3KwgkcgydQp9g5kbn2/W1MS+vwJJdZHEV?=
 =?us-ascii?Q?m/3NBnzvo34x48sY0LejS3y1NLSaGbluQufunAvsnQ1lYlpL1DY0KD7Mtd2w?=
 =?us-ascii?Q?n1R/iw+5SO51goS5fAXsR0DSpMX57jtfg/M+oF20PzpTbc5LNGsbuROsXT+V?=
 =?us-ascii?Q?xdqj3+yQttskeB/6XI/hJ/HnxXUsVRgWKIgMDF5wslJ3tdhUT81jXsugtz2o?=
 =?us-ascii?Q?L/TV+TYzpYjZ1ycF8BVFud+5ty2GhNnRz+HPBVYyk9v/cgiH9agHF4Ccs51c?=
 =?us-ascii?Q?CEcSEn/D0K8muALSzt808BMZTVZRL6DviLyskJhfO9y3VX6MKfOLPuvzZRkt?=
 =?us-ascii?Q?WstjpT33HtiwM+XYzkaNI4XXjEKEgNVwf1z8qwwfgnQMI8KxTc/R5ftlXMXY?=
 =?us-ascii?Q?mSZVNegjwngCu5X1JI/4TX6St4GD7K5u5j0iTMNb6DvaXEA5D5lRx68IuNC4?=
 =?us-ascii?Q?SbgoHVL1bgV0BWomkuC3nEPahwbZBOxOFU2crpXVvs6yuCkLcaWMnXtL4YUT?=
 =?us-ascii?Q?qJOukXabBAlY2BiRvg/3o9URvg8LOEWZIRa4KJN4fLFkNBQOf9TDMLFeQX07?=
 =?us-ascii?Q?sDnuL/aFaCTUh/u2gyhFGiZjyReD2DoMQ2ie6jynsLmQrEElsKGqrXPigSFS?=
 =?us-ascii?Q?3L7RIlvXtcwZnCxVyDn1rG7X2L7H/GAmljOM4FnjIjgK2Pn0eFmsoIIbACSm?=
 =?us-ascii?Q?Np3BEiwkTorj2+YdkKYuxWrQ2IrPJNV1B1E6GGk8mqdQxks4AtuAcTkFMO1v?=
 =?us-ascii?Q?mh1eCT6LVu0c8H+yaFPb/dxdZT8fFP0FNRmpmpNQtcnlBBAL956NxMoUiVAt?=
 =?us-ascii?Q?8tmLlSIIyYUCAdqhpHPalbGrz8a23GU3r6be3B0A3hQOCNkJ3rFlyBeSC+Np?=
 =?us-ascii?Q?N+J8bw1InIH11TiS5RmAeXDZSeqU88xdQjqRXoadggTeeptu17oyDsKnWdIJ?=
 =?us-ascii?Q?+uLJWKHQRtbrUznBYw+AEmPLi0PjsFMbwn7xNQqRnNDkPbQSEhqvnny5t/UK?=
 =?us-ascii?Q?qKPj/IdZicz7lFCVlOcBBJOPWf2JtZJTTtgbuaRaZbF/J7LDM+uhr0Dry0+w?=
 =?us-ascii?Q?Z0c9O1TfRFi3jzIRvFBXiAO4Z75DR0l0Dl8m+8AKWkPDUZwSmbGYxWciEU54?=
 =?us-ascii?Q?msvaHX6vL6hzolC5H7867dbUIMxTerNRT9ZtiqWZO7hGpLn0WEwfoZjvEim1?=
 =?us-ascii?Q?oLkrqcJET0AxKWGsW25ivN5TugznmG2O5e6hT2GwQCaxUcqNeeUR3WwN/Zu4?=
 =?us-ascii?Q?yC81TsqlG1ZE7vyCP71bfMrZzQF4h1UZnm/suJEpj8QNd4Zqm2R20QqCUtQi?=
 =?us-ascii?Q?9Fq1RBICyAQff4etCkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGdTsO8Ne94PnO2Aa7fCQOiKzmx/k9+6YAfnnsyPQsYXQpgK760jLlEjYx6y?=
 =?us-ascii?Q?Cud0GWgmrSUCyzdpznxcWXSU4lP0jpSOxU9kUHY8ZmoQsaHs+GYnenwB5wR+?=
 =?us-ascii?Q?yYS66mlo9rxENj+maerRqORBYngXDH5zhIy/7MhidbD23qQT+/TKXEby12kB?=
 =?us-ascii?Q?Z8SpI55Yufhr4ByUqVp5wh76dBdZY1hwb+MrRStNZ3H6cc0LuB/NvSmSGthm?=
 =?us-ascii?Q?22FpQW63848N6KkFdXvdCcDFwuhgWFd/NgdRq7cDEmhoCyUJOVkbpKp4FsT/?=
 =?us-ascii?Q?WZYt/mqk1tGUJLpxAFUHQDH7jcGRs65BEli4zKZ+s7N3v56bdNfDE5Fg4Tdu?=
 =?us-ascii?Q?G3lK+VhdlaPCZaV4pb7GC3YNxVMvV7uITl6xdzl7WEBflKFHs68EwU2AJ8MD?=
 =?us-ascii?Q?p1e1+YSisr2yMi69O5+QUtnr3vHNvD6/mxaRewA2CCQV4Z74l+Fnq1j6ov5Y?=
 =?us-ascii?Q?JfQ4ywaDRJe0Qb5kZZWbU0+awRvvbhyfTpG2Zj64RACqZ9WByhm52C4P8tlj?=
 =?us-ascii?Q?7YOwaGVx/k1rq1hp2K+b8w1G9BFGhDD7UHC9Rrpm27Mkr5G/8FiYqUmWg4sk?=
 =?us-ascii?Q?cPPmzFW0dt/zi85XUiBfp/mq/0Pb/tJr9HGTv2f9JWLI5B0IfY20W0CCjwe0?=
 =?us-ascii?Q?JSMdYgjJ58K6loxzcoJn5wSUN7Y5h2T7ObXmlzgLUjepHexKBBk/kyPkNpnn?=
 =?us-ascii?Q?4wWIb5izY0CGiVTibWd+vGUtitXstZZnbZet+tkLUNu4TaGTcm7ZpPU33mQ0?=
 =?us-ascii?Q?tS41DseU3mO4zKrB2bUsoSiIsCopaKWnxunh5+vIYEgteMWL093rkp2WaZZY?=
 =?us-ascii?Q?eKJSV/hoW2NzTlYKhKm8WZf3f4s2FONJ4smqNceIohi/UU36MroB8D2e9Xze?=
 =?us-ascii?Q?h0uNshkA39HcOPI4KVJPRib4g9L3oyQg5uak33Q2kq8qyHInGG8W3vSEJ4Y9?=
 =?us-ascii?Q?CzoQXUM8cjhqYxXZxiX+e0SsyCnLqUX9qSMALar7NmqxALpB0Xtktw4a7MqK?=
 =?us-ascii?Q?2MyiarxdNIyyx2WTftQQitYMrSUqX2ZL5XNv3mx2fYf3xCsNqN/u/wHua7pE?=
 =?us-ascii?Q?Ydm8l2DRXtaiKlrvZTIIp4ujD8X5kCkK83WhgAdYHnJxzT19SuK4wHf6yR5p?=
 =?us-ascii?Q?Mmux9ckNU3A6tNBBEv2Q/dCuSj9ohiLpoiHYUmNhgPGx5qTJeibUsMkR7HrQ?=
 =?us-ascii?Q?jmqfNfeVaYrXT+fcQ9H2Z5Plcp88rwakNd6TIiS76IzhaIgETsSB1/4g2eBH?=
 =?us-ascii?Q?oKLZ7UKz00MubOLeLHhCVRQePOkw31a5ocxyr28khxhoNXM/axtwP8s8a6A3?=
 =?us-ascii?Q?TLg4edlEX7SugUhtVZiCMwk0ifYevQozksU7TjS/HfXnZkFwH7neo30sduVD?=
 =?us-ascii?Q?C6aDtBy0peCgH8/xaGeKHK62BDFCdd/lzEbRcUnPXIRY4tOo7H0vbSII9+yR?=
 =?us-ascii?Q?mqSuSfgS9oUDEzhHnTLoF48mykzSWTk2svl90PEdKIAGmNiHWqamcZw4BQG3?=
 =?us-ascii?Q?/GFicRsI/l+8L2DTKB+GVciw7ubnp2I3LP82X0BC1uJeRFDoHhCSIpSr7cjb?=
 =?us-ascii?Q?B9vADileEQfD6OuvCmc/2eEcpiK/CrciOQhD67+CC+swy7xS2yOTnOzxHT/F?=
 =?us-ascii?Q?0VxnhEjK66KkzBVodefQxyfjXKJmYC2gv2S5QkZnJuck+27Ly1bUNhArJpt1?=
 =?us-ascii?Q?s3hbSl1jjM7pH6CgOQVNvZ2lJ/CaL4yJcO/puzvcueF5FhfeBSXL5iIh9ohU?=
 =?us-ascii?Q?WMgoTC2XvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3045f23-e84b-4cbe-f53e-08de64033f40
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:37:04.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHXMw2Vwbt2HSR2fdBgHcWRLYs2Wo7twzG70TBYTEP95//ykYpXoh62aVFNVSPAxZF4PyRFhgcUJjWdUfNZ6Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

Hi Kuba,

On Wed, Feb 04, 2026 at 01:20:52PM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Tue Feb 3, 2026 at 11:06 PM UTC, Andrea Righi wrote:
> > A BPF scheduler may rely on p->cpus_ptr from ops.dispatch() to select a
> > target CPU. However, task affinity can change between the dispatch
> > decision and its finalization in finish_dispatch(). When this happens,
> > the scheduler may attempt to dispatch a task to a CPU that is no longer
> > allowed, resulting in fatal errors such as:
> >
> >  EXIT: runtime error (SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[13565])
> >
> > This race exists because ops.dispatch() runs without holding the task's
> > run queue lock, allowing a concurrent set_cpus_allowed() to update
> > p->cpus_ptr while the BPF scheduler is still using it. The dispatch is
> > then finalized using stale affinity information.
> >
> > Example timeline:
> >
> >   CPU0                                      CPU1
> >   ----                                      ----
> >                                             task_rq_lock(p)
> >   if (cpumask_test_cpu(cpu, p->cpus_ptr))
> >                                             set_cpus_allowed_scx(p, new_mask)
> >                                             task_rq_unlock(p)
> >       scx_bpf_dsq_insert(p,
> >               SCX_DSQ_LOCAL_ON | cpu, 0)
> >
> > Fix this by extending the existing qseq invalidation mechanism to also
> > cover CPU affinity changes, in addition to task dequeues/re-enqueues,
> > occurring between dispatch decision and finalization.
> 
> I'm not convinced this will prevent the exact race scenario you describe.
> For the qseq increment inside set_cpus_allowed_scx() to be noticed, it needs
> to happen _after_ scx_bpf_dsq_insert() reads the qseq and stores it in the
> dispatch buffer entry.
> 
> We can still have the cpumask change and qseq increment on CPU1 happen between
> cpumask_test_cpu() and scx_bpf_dsq_insert() on CPU0, and it will not be
> detected because the dispatch buffer entry will contain the incremented value.

Yeah, I think you're right, it makes things better, but it's still racy.

> 
> >
> > When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
> > and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
> > re-dispatched using up-to-date affinity information.
> 
> How will the scheduler know that the dispatch was dropped? Is the scheduler
> expected to infer it from the ops.enqueue() that follows set_cpus_allowed_scx()
> on CPU1?

The idea was that, if the dispatch is dropped, we'll see another
ops.enqueue() for the task, so at least the task is not "lost" and the
BPF scheduler gets another chance what to do with it. In this case it'd be
useful to set SCX_ENQ_REENQ (or a dedicated special flag) to indicate that
the enqueue resulted from a dropped dispatch.

> 
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 58 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 47 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 0ab994180f655..6128a2529a7c7 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1828,8 +1828,9 @@ static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
> >   * will change. As @p's task_rq is locked, this function doesn't need to use the
> >   * holding_cpu mechanism.
> >   *
> > - * On return, @src_dsq is unlocked and only @p's new task_rq, which is the
> > - * return value, is locked.
> > + * On success, @src_dsq is unlocked and only @p's new task_rq, which is the
> > + * return value, is locked. On failure (affinity change invalidated the move),
> > + * returns NULL with @src_dsq unlocked and task remaining in @src_dsq.
> >   */
> >  static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  					 struct task_struct *p, u64 enq_flags,
> > @@ -1845,9 +1846,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> >  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> >  		if (src_rq != dst_rq &&
> > -		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> > -			dst_dsq = find_global_dsq(sch, p);
> > -			dst_rq = src_rq;
> > +		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> > +			/*
> > +			 * Task affinity changed after dispatch decision:
> > +			 * drop the dispatch, caller will handle returning
> > +			 * the task to its original DSQ.
> > +			 */
> > +			return NULL;
> >  		}
> >  	} else {
> >  		/* no need to migrate if destination is a non-local DSQ */
> > @@ -1974,9 +1979,15 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  	}
> >  
> >  	if (src_rq != dst_rq &&
> > -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> > -		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
> > -				 enq_flags | SCX_ENQ_CLEAR_OPSS);
> > +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> > +		/*
> > +		 * Task affinity changed after dispatch decision: drop the
> > +		 * dispatch, task remains in its current state and will be
> > +		 * dispatched again in a future cycle.
> > +		 */
> > +		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED |
> > +					(atomic_long_read(&p->scx.ops_state) &
> > +					 SCX_OPSS_QSEQ_MASK));
> >  		return;
> >  	}
> >  
> > @@ -2616,12 +2627,30 @@ static void set_cpus_allowed_scx(struct task_struct *p,
> >  				 struct affinity_context *ac)
> >  {
> >  	struct scx_sched *sch = scx_root;
> > +	struct rq *rq = task_rq(p);
> > +
> > +	lockdep_assert_rq_held(rq);
> >  
> >  	set_cpus_allowed_common(p, ac);
> >  
> >  	if (unlikely(!sch))
> >  		return;
> >  
> > +	/*
> > +	 * Affinity changes invalidate any pending dispatch decisions made
> > +	 * with the old affinity. Increment the runqueue's ops_qseq and
> > +	 * update the task's qseq to invalidate in-flight dispatches.
> > +	 */
> > +	if (p->scx.flags & SCX_TASK_QUEUED) {
> > +		unsigned long opss;
> > +
> > +		rq->scx.ops_qseq++;
> > +		opss = atomic_long_read(&p->scx.ops_state);
> > +		atomic_long_set(&p->scx.ops_state,
> > +				(opss & SCX_OPSS_STATE_MASK) |
> > +				(rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
> > +	}
> 
> Will we ever enter this if statement? IIUC set_cpus_allowed_scx() is always
> called under `scoped_guard (sched_change, p, DEQUEUE_SAVE)`, so assuming the
> task is on a runqueue, set_cpus_allowed_scx() will always be preceded by
> dequeue_task_scx(), which clears SCX_TASK_QUEUED.

I think you're right, we can probably remove this.

> 
> > +
> >  	/*
> >  	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
> >  	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
> > @@ -6013,14 +6042,21 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
> >  
> >  	/* execute move */
> >  	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
> > -	dispatched = true;
> > +	if (locked_rq) {
> > +		dispatched = true;
> > +	} else {
> > +		/* Move failed: task stays in src_dsq */
> > +		raw_spin_unlock(&src_dsq->lock);
> > +		locked_rq = in_balance ? this_rq : NULL;
> > +	}
> >  out:
> >  	if (in_balance) {
> >  		if (this_rq != locked_rq) {
> > -			raw_spin_rq_unlock(locked_rq);
> > +			if (locked_rq)
> > +				raw_spin_rq_unlock(locked_rq);
> >  			raw_spin_rq_lock(this_rq);
> >  		}
> > -	} else {
> > +	} else if (locked_rq) {
> >  		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
> >  	}
> >  
> 
> Thanks,
> Kuba
> 

Thanks,
-Andrea
