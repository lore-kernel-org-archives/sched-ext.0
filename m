Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD23E1693
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917997; cv=fail; b=qlpbkmz959Y8j1/wOFXOoghUfORI5peWbojo/f2hs6ANcg+2QmDKReIXFeO2LQz6I396Md1gnXtwR72RVvtsqF8HDIN0JxYDhGkXFa3zER2noG0TrALRlqNOHklbKQnOeijT3JuflBgnc8Cq/aj3/s7HzhIfCeUG/PYflefEjaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917997; c=relaxed/simple;
	bh=ddyj1sZGcG/88eHMn8hjXrtgvb8kEWMIeRObCu9V494=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PPH5LMq/MkDm10zAtBmJIcNwnFQMRKacHTG3yOYL9JqKOZ8Op4cWr9kH2V01xVWiimwBbIYir78ErebL2vgqJJBjIgKYsXmE7a9tbjVAJhSOXZN7RjS1clJaM4zryDqZHSSx5EXQvdrfOcZoa16YsAMxvzVi9wykjcdbDPeY1aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dhlp3xIl; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dhlp3xIl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2gFIYFlBkUqgQ7vbZlit2dJSxNxvge67tkareI9pX3dlb3pNL3gp7PUgo9MKK/8PUoH04EMUxmTCRebzblWcuOH7W1z81RMNOO02Agh3Xz2QUAo0arpufauepqhh2Urynn1c7W2znyxzQbdgdOeO+3Etq1ulqUgaz8n2yKzOex2UuFtrmThWJYol6S2KTgf10FH9hn8qX0JETB510lIbJi/CMw/y8UvMwVjzmltg/ZGJgP0FBeDN1lFcYyLB9nhHAudLPWelnC+Z3LPQov1Yv8pOWdtkpI/Q3GLc5OxzJKer+oBrSXCBHAqGgZh0F3KrlkUh04NlZEuF2wkFYayMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWTBwBg1AywR/QqfsqwX0wD8qXco+pwTVWV7drclYQQ=;
 b=o+glO9ZToOBMQ3sB+v9WY44asVJ+Wl9um87YZDJ/878ow7GAHCdAl5HoSFPAKsAviaNyY8kJXdAbkTZf5oDrQRD9UYFioklGKNwLw2FxZvU1KfIdBmKzr/9tvImq2PRMuixw2xKlNO+h/RngGX/5/GBK2UDM39wxg1Ee12ue2MshbDv0iq19zD9C56fGP4x395BvW1cNSsxcQHU16HNn+ad7tDBPdrGNrrxV9656/Z6+XR+xBGD3+Du9q9odsvp+jK70Tet0Nt/CWMRJmSrSGGQdB/xHcRnZ0QZ+4Biq9/HRJcPa2C1Co2EH+QoJAx+gZpqY4XgH5be5nmGev7pYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWTBwBg1AywR/QqfsqwX0wD8qXco+pwTVWV7drclYQQ=;
 b=dhlp3xIlx7VTnaFu4+GLIZwEArhQBZJg43/volNvQNWphbM8Pgjay3yG6yjO0F0ArmS5QIyf94TPNGBFwWt3m3r/u5cn9w3LWOnUOmRNLtbsSK/jCoCztJCtXYK5XaNq8573SwD61WgZC6CR9Xs0yVFS2mi3lmrrClFBcqSVT0O9MfGIp6dK7DWhLiibKf/MINu0I1YctsftSdRQ6PiMEjt+f3makYc6oKyvFrpqd7EafOfVDF02j5SWb0KQcksILpWZHHfRN5NXoQHt8/dQ0u+n2mTYZ0MSX0bVLs80tkO/D1oxnUxj5eUxjwBXSWt7h9WqaLChN86bFSvoIvWL2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sun, 16 Aug
 2026 22:06:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 22:06:32 +0000
Date: Mon, 17 Aug 2026 00:06:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <aoI0ZGIqYmc0iI0Q@gpd4>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-9-arighi@nvidia.com>
 <aoIsZGwElUYmeePF@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoIsZGwElUYmeePF@slm.duckdns.org>
X-ClientProxiedBy: MI3PEPF00007535.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 70946f15-14c3-4c7a-13f1-08defbe2a132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1/C0XhsRd42aJ7ZyZQkscZeAq8cjbvc8pw1dOoFDeQ2JKwCuEKXHoCwy4IXc1FrMj+hCfWUrqOfQCPBz7X9bkLPFFdl58seSAQaNOjQ7TA/5emLif9QgVYg6C5VVRpNqcBJ1XJxAqt3txIdiubI2D7bO20o1u0Jd/EocvWOhx8IMdsOczJBZvk1zWUdVlWjzAGkxi0BSt19zwwoXZAFF+Cm6JOI25MqprC4ty8CbrkSz0IYVBbd8ICPeYmyUue6+J8UiUbKbk5XiPN95tS0mVUfDWN85+UVXBqVnsBDC6Jkc95h42S1RRZRgqUnLBqCz1nEU1gp9+rzck961UtGR+Zk1lqjYzFnkQtLw0gS8bw12XuJrbp0OP/5vI3XYv8v1pciogRCaE3JmDpVrBCDMcEDUT0CwSgykz/XYlxEUJBS2y6LIuOPZkYSdYjv9uBwRAUZ008YH//f/EuT7/R2QtlbhH5PN6yTcCaw3Vjrw9JTJ7ZaqnPIizJ9qPylkVIhwPC84lU8PCUHiUWWG3I1iQ105Le94ezRndcGab8uVNWBP2mfBBsRtVCHDE0UxCIRmdivr6AnXNal8z4y/veWLITsNfjB3zS9tdReGYy3f2K/DPPy01YV3QsDseAzSw+IL2D4wyREL68ZIKf3O7CtQ5jAlRmPOd8a4WJ3fMpgmiGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsnKaU3vAjoUTfF1cKcebCB90UprigUU6HNohqAql2KQeVY8/OlOjpCe4kxi?=
 =?us-ascii?Q?83lPM1ONjJ0Q8Uxx0vI1F26Bjy4vDoyzRY17bPQrb1qUVrm0dZ9is/8GWqzC?=
 =?us-ascii?Q?ONundkZOXTQKp2+0WznJp+JUbtZT93hGp+dcIB9Dtm+UNPOUhlAyBrROUYcY?=
 =?us-ascii?Q?9hWweGDRLVKAxhZRCw4IyrP5tcKMlOoSlD2SkwaOAlVnpnpmz8rgXeZBGyEy?=
 =?us-ascii?Q?7nK2XHiOcEV6veaLIPeBlA1UvX37Ytyva+VRi4nIJn8zDiIcL85R4C3+MpUs?=
 =?us-ascii?Q?JN8ARI6DKbyDZfJz0yqxdfp5cb2TPlI9bVw+bXsNbpKeu4gBWXj4VasFq3hH?=
 =?us-ascii?Q?IQiq/EdmNjxRtFIOwqO5yPYVZrr+zEPiAJQxmY8j5zQLyoi0bNGS4OmCHPmZ?=
 =?us-ascii?Q?uFsXIcqeJG6G01SklLA+ZXY2KT7XF8Gyla7y45m+6c8Gh+pPYONP52s33vLF?=
 =?us-ascii?Q?x/nmkkdYM0R1UTU6Sky5g/e78r3IlS+NhxygCrZ3pzvfeNNA7qx0dl3Tkrlf?=
 =?us-ascii?Q?lfpVT3Sa9rfn7PQsdEgqGqU09BufzXKAFc6/7jK5nVNxZz9kz095Q21yfdoz?=
 =?us-ascii?Q?kiwjYmvrWTZB51c52g3ajmFcWrI8+P/ONSuhMqJyV8QJWitUfdkFnkRTOdcw?=
 =?us-ascii?Q?DCDE+6kEmj2+n2DDgw/b/vXEls9aaS6xXrxHoGKolM3wDL3wBv8rdLygwh1z?=
 =?us-ascii?Q?yL8VLid6l4kDf4PngCRKkcsh85JOxyNo1/I6Pd+2B9rr1lHrrtDfuT4JDhDx?=
 =?us-ascii?Q?I3aZM+d2v2dzVq8nxcQW3jq3W4Jfn7bbx0VHNXmOk4N3Q2aBKkUuLnGnxTm1?=
 =?us-ascii?Q?xDHHA3wPD5zEOdA7NwyYAw8gxTHaiQ6ROssi6BqO2/yBDZVpU/isntpRJZPQ?=
 =?us-ascii?Q?Gw17utm48mQ9hPlb14jzCW6/dCwQriif+7IZEbzlZSLEYFyg/QBm2wcLaD2o?=
 =?us-ascii?Q?BpF6zyh6cUbkYr9t+brUeuXz3bVZUO4p0cRg3Mf9lVoIeQKOPOApid/p8j9v?=
 =?us-ascii?Q?2Y0F7Q4GPfgCj50gxzlWizNA3wZLQKJeVs7T084O8cs9WEE3hSdYQp10Z2m7?=
 =?us-ascii?Q?79o7pcpt9v9bdHp4cg0nYzdaH5kB0Wy1Yayfj7w1qcWlmDGYeVjlteFkQDhO?=
 =?us-ascii?Q?tBjVYfI/EFtAQLnnHKMQT8Ekp8zZ96SYBHnAkjg13FJX15ywaXB+DDY5w9GA?=
 =?us-ascii?Q?/bx6aUfT9hKPdaIvoX2vQT5rrZqHofeGs9XHag3SByn7oRk20Qfg0oMXt9NM?=
 =?us-ascii?Q?e1BbTEsmnwVfYnq1oIrnEi4YZir7cWQoX4TiYeqUerY5PbsGs03zWBtkF3Sf?=
 =?us-ascii?Q?IwGX5OYkY+budeMkrkVCKJ3FATFdhTKwz1w8Na7bzz3BgsLVwKdqy7AMmEmk?=
 =?us-ascii?Q?1UJ4ffDENyM6pKCCaMBpa86vUehpYxso1HX27jAT4lwCyz601PemkZYUHRjS?=
 =?us-ascii?Q?DVYQmCvZZOUCp5wFFgxN5KNi9sr52MicHwbbTfgBtQS0aWU0AgvZB1lhqH18?=
 =?us-ascii?Q?fCD12+ul60ZTopDCBYUc/PSh5GMo34HjjVQxEo9euwL/0Hnp2qR/uW+mTSa3?=
 =?us-ascii?Q?YxrBDilhxBuQzDtduL2Yf9AO6IfqM+7hxKW1InYYoISS5GaH7AgH2AIRiguc?=
 =?us-ascii?Q?A6/AJqqInWAXQSnbT48Ne0ayeC5YduVqQHXrm2jSTU+c3Nh7ZWMwo4FnBdtI?=
 =?us-ascii?Q?hMpuQ0hh2w7E5paNok3UGhfQ+38OSNUslGPdAnfG8PHtUMXizrkRAWUlpARK?=
 =?us-ascii?Q?P1BYqNLljQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70946f15-14c3-4c7a-13f1-08defbe2a132
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 22:06:32.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amXd48y+KsmvhqgdGvA/fl3+F7h8lEhRy8V/DcLqRrTYhIG64Q1aaLl+i5bT3wZmKpqOb0o7yRWF43pTaEQu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626

Hi Tejun,

On Sun, Aug 16, 2026 at 11:32:20AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Aug 16, 2026 at 07:35:06PM +0200, Andrea Righi wrote:
> > @@ -11295,6 +11295,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
> >  		flags |= DEQUEUE_NOCLOCK;
> >  	}
> >  
> > +	/*
> > +	 * Don't carry retained proxy state across scheduling class changes.
> > +	 * Compatible RT/DL PI transitions could preserve the session so that a
> > +	 * boosted donor continues proxy-executing its lock owner. Defining which
> > +	 * class transitions can safely retain that state is left for future work.
> > +	 */
> > +	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
> > +		sched_proxy_block_task(rq, p);
> > +
> 
> I suppose this prevents RT PI propagation through existing proxy execution
> chain regardless of sched class in use? That sounds pretty convoluted and
> overlapping anyway but John does this look okay to you?

rt_mutex PI propagation itself still takes place, what this prevents is carrying
the boosted scheduling context through an existing proxy chain when the boost
changes scheduling class. Same-class RT priority changes are preserved.

The reset was intended as a conservative way to avoid carrying retained state
into or out of sched_ext, but this also affects fair/RT/DL proxy transitions.

Maybe we can narrow the condition to transitions into or out of sched_ext, like:

#ifdef CONFIG_SCHED_CLASS_EXT
	/*
	 * Don't carry retained proxy state into or out of sched_ext. The BPF
	 * scheduler must explicitly admit blocked donors and cannot inherit a
	 * proxy session owned by another scheduling class.
  	 */
  	if ((flags & DEQUEUE_CLASS) &&
	    (p->sched_class == &ext_sched_class || next_class == &ext_sched_class))
		sched_proxy_block_task(rq, p);
#endif

This would preserve proxy execution across fair/RT/DL PI transitions while still
ending it before entering or leaving sched_ext. WDYT?

Thanks,
-Andrea
