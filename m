Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDB27456
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946873; cv=fail; b=nwwBVOCOA18MtKQg1h8kAwD3psaDRwQi/cD8hq78GuOR6b8DT/SUKAdFCkg0eVKH0l4UdIqFPPOOD5snE34YPAgv7m/kZtaZRHKsie9kCjQj3JRNoGF3N1UZ6BPk2RDvxHSm6H7AqAa+FWiSHy/sMTOnM01KR6XPcuaE7rSTRD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946873; c=relaxed/simple;
	bh=eCBFRcsUU4PEe9y5etKk16X/qho5cN+hYsAsEnodu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YmpXze32I9TixzZOonwe36LoHLog7FxhZhvRyC/ebtIh4CYQ455hDZ/TvJjBjQ5+bDSzqD5t4t3/3VGkU0TrwpYUI7aIyxf/ThrCVwpIts13YRUkNbQXO2MdcLnRIfzyzKhq2/P08sA1oxs6jbRY/aLzD7VhR4I9aq/70lDIwCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPWLIIIh; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPWLIIIh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL6mUpYYenns3TpCCWosjUBcagVWxaPy4qZRNZf1t+ga2kbaFuuX/5PIe9Bo+4rz8aGB77o9Ov+B4Kldl1gIASZ2Vv9d9u5NkDCjVTVTa2m7a71Ezd35AhuR81yVtFQbo1Qrz2asyw+K6ffyt2U84ISD8tHKfej78gyRyQjq50TnnxZFjFxyDpTxBCanSkAoRndwgiFS5nDScbB8BapWtbxDQ+v8PuE9D1q50tAU7Ruvi5ftP1ocQVrp0q+QHKHOpzvZzjJwPCV5xLkl8MeGBDOYrdbImVCbmmjG/Bpq/FKeWTfRTHD4LdRfYxE0r9FBpTO9xBdI+xyOtFpUojzUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P387r/bOy9COSchAQ04fL2hoc0gbcSwvCfSWW2swDdQ=;
 b=mfb1c/12odgRI0z+Z5EHEmwuUTvcNsW87z2aS9VsvxRRX5vJ2AVCD0mOVjyLhWSZ+dPe8i6gDf/SzO/u9x3K8hdNVUXAxtacZ37fC3cz4kvnYThSNakZf7LfrSarow3ZoYiZXAvSwtbNaiKkGLczaw3VfKg5yU8xqfqK/LETooMp4yUQwQqjb9/lfBTER1mNcWnpjRfF8s3nh/XAqNm1lFVLMYgqaAgYZ9MR0441NyRIDhG9R8UK58gUoDoVbMQqvdOUPMafqFqDnJqJSkFet/0YjPkYJN4O/rgsEbU3cq1bC0orKLPwPhPrl63+cnHDU4+qOhQGFRXV0hrgk1P98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P387r/bOy9COSchAQ04fL2hoc0gbcSwvCfSWW2swDdQ=;
 b=aPWLIIIh+/bnMo+qgOcBhMvzo5ktpZ/34x4rnG5eEL+WY9dJtnjCVaYCq19ivafpR79vzjTiSY89Gml5+wiIrfGOnlRk6m0iPTqPmidTG4dffEt3oPbksEvFUUGLzS9FYTs8mYDnz6PkWBmqSUVIwRyfECEC5sFq6dU35geZsUj82qnkBgFz8igPLu8hdCo5OxDDBTozkl/ZYGsxBPNg2+KdKjQ5zeNF1jdpMzmVEptgmVNaPc29iuFUozwMka1R5CTqNnNO+VqT2cGFI6lUJROkuwuYt9ZUO8XBZT5Bj3mVpZWH3n+AS/jPwcKIvWQau4yIiRcXDZyAlbAEx9lp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 19:01:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Thu, 19 Mar 2026
 19:01:08 +0000
Date: Thu, 19 Mar 2026 20:01:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <abxH7cC-IOE2PqKb@gpd4>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6UY7YCS6LN.KMPOKET3PSF9@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH6UY7YCS6LN.KMPOKET3PSF9@google.com>
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 7866b8c6-ef0b-47f2-64ef-08de85e9e10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C8UnkD5bus4s38RV8w5GKif6C3IhswcXa6vOL21JaIoNn8Gxd6MlhETVWow2j2AWJgKlKUI2qBPUSUbMImsSM99XYV2njSn0iIU+TY3o2gZrKCPQ2GraKSawe+N5k2EfxjtHBKIoMG0QVZt75lEy6BzwjRw+7cnYPjXaOk24DEBR51H2EYfzSQ5qj6ZN+n9CV5pLb6eRrBVgy6PvSXreew2IhZEhC3UfCYN6sdbLxSrgVxILQUmVxZTH50cenzzH4D10JKS2roPP8r8yHIHSx3ugYAm1QSqUvgT9/u5musyttkq3ff/o/rxVlOU9shAOt2XFqNAgAer0PDGR8CpPW1cA2fefojK7r1AEsMLPE2esZdA69X2PgYAcddGJ8PysDBEGBWEGMkZRS/THt2Yis/xCnYFECfEHzOCQj2EJ2Px3LwYmdURCEl3fD0QKfPTIIyCXr7I1dW5xD41YP1+k26b3Zu/MyvQUgN/PifBZ5Q5BcTaJvVjdmKR05FUDBoAurjBBO0UqTcoAIaWy489lnDdVVOJF96ijtqntDt9mQ4zSXjbFlidviNJHdw+nIyR5yxi4Js8kxm5DvBLMqnHFVMDK8y8UQRvVomJB4+aEQeHqugPm8LwE2odl88bZTRghh1gHzTA1/ZHCDmE9nmaUjzl5MRaLrOPdRpyx5OWszyTP7NUjIsOwYta9wAagg98dyAIR4gz/Mux1MKcGOH8mtUe2WIG7a7MfL6QyG7vwoQ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OLLhv5tEPB3GPb5OhZ/uZyf7X6qtfobeVpoKMA4MKjx/IgTNgpiu3a/l4IQW?=
 =?us-ascii?Q?HxS4J8upTHekrOSh68m5tK5nFiXTXquq9ZuNjZuZ8r11NOVbPhvyPRA0gPPL?=
 =?us-ascii?Q?cobLa4hR9erTBGsPEZQdHtbc7MHku5u45vLN+cDisGP5ZHrG+EKnoMoZzsxZ?=
 =?us-ascii?Q?hFI8+gha0jr/20TlYa0ZEOZO+G/6w2xjSq3bQP81sCx4FgihN5eeHFNbkSUm?=
 =?us-ascii?Q?r+xSTEjhOrgCat/zlKWbqDRvz/bYVRuyhz12FiePGdVsZz+ldh3bjrR6i4/E?=
 =?us-ascii?Q?W83RGUTiJE7hMrWeX/Fja2ZpFbVBjU2qmLaHsIBAXO6MZSNyYOXZlLIlxqL+?=
 =?us-ascii?Q?V4ypvbd62leVwfqkwxs1v7CVEQd7tzDDnUTGtwT1hhVtdS3M/qHbJ8/ODqtX?=
 =?us-ascii?Q?BoIrUYKCWLXJET+iiuxbFEnfAk3IqkFtlYXfgbONudMxtCG2lcO+JsqdSbJG?=
 =?us-ascii?Q?NCZ0WZYdbUTPqyBnzVFstHbb+6++T4M1kzeYUNyW40r37hVN0eyY2SQWBUfQ?=
 =?us-ascii?Q?qm8vCUk4ZGT5dMXYlHoTQE+AQOH2IuEQu6XveQgRJ620F1+b8ECFcR/c0h7w?=
 =?us-ascii?Q?yIA9JTxWAWwCtpi7PAWpy26VLLW0tZLuqBJd3VmDFFSFWXQWDUmMLBdoBsxd?=
 =?us-ascii?Q?2a4YPRQu/3Adqc/X0vWrrqrMbJmUNrEahNcuGPf5zRWoJHliotYHiOrtvFof?=
 =?us-ascii?Q?zbs/jopgkqhWk++ShhfLlKq750bjr1RPl7m3XGlnWiKsRBOklNDMapEi5i8H?=
 =?us-ascii?Q?/TdSj4HSSYFLH3yEPxSevulKSUNfe2EhY5xIHKt1JpRtnb705+f4Mt8OPzfy?=
 =?us-ascii?Q?ULSVwXayGISZFL3mij7zBt2mgcgMtbTRO8jmz7qMsND3UcQGf6EAgRPbs88g?=
 =?us-ascii?Q?y9liOOdzm3RwKy+GwZl3msyNrRPI7J06WwTqMzAiJw/+O2oIcfPux7IQGrvt?=
 =?us-ascii?Q?TEvuhwMDbV6f5bdh+f+ER7NzTCTEr6Aeij+id4QZKaE6tXsuN4XqiHc06Rsk?=
 =?us-ascii?Q?Neo7hoZijZCrEpCIB/02IjIltM06vu4NndsSiDP6XrEHXezxUo0cO40NBOCd?=
 =?us-ascii?Q?a4ex8mVbX0R2NXNIQiA0I7pP1LIxTFMPYbWLbwWCb+Zb2p6cavlRi9Ty7dEr?=
 =?us-ascii?Q?ErMaOElg8+R2woPhHVMNzoEbgf9lUUGlMfLFLEeDB7qt9HlOR/teQvdDcTp/?=
 =?us-ascii?Q?U2uDzHYYwdDCjyre89MdE1ESL2Z3U4IGNEj9XrO3GFSgfuBtOhs7sT4GqiAJ?=
 =?us-ascii?Q?EigvQQWYogBr+Nw4mYWJ96v/bcCPL4Y67+MJTHQM4jSTspFkHn4RYRHwEdLr?=
 =?us-ascii?Q?sGJ83V2tNKzSjhEA5FUkybdbo626xVzqR2vpe/f9rKjHMx+gEx0Edya1XZ9N?=
 =?us-ascii?Q?b1Y3QDtwXtvBamstY96pL7nSfsnSQ8qElTlsWPWD2gQ+/sYGnaFcVz0BPDKo?=
 =?us-ascii?Q?wciRRgv0Kx+BGmtlpkcf6df/1bbW4WDDY25W1+Mk+i47aC79lz3opPugZ/u8?=
 =?us-ascii?Q?it7/aHojZQm78OsDHAvQiXMJQSXzXuUz1tNDXKXzvMkweIEHsEEuwr+xSFiL?=
 =?us-ascii?Q?Q9VZ85B3FkG0j8MOFjmlxzYRtuEs7zRyK7E4T4OSCXXjraPx/M8tGXMwMi34?=
 =?us-ascii?Q?B4Om/Inox1vfMZRZ9rpIGkBf+af6YJTsvXzop9HiNYhlait/ZbbQYk8fdrdh?=
 =?us-ascii?Q?lV3TcyD6lez6ha1BZd26Oz3c5n8qYEkY3WAv3CU3nTY2ueLf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7866b8c6-ef0b-47f2-64ef-08de85e9e10d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:01:08.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QO1gFoFEpg7wtP18Ul/FpjXbcPC10BEVVt09L3/xGr5PRaxrDF0InFpdAZ2ARxiLBDR52/TcLwOQASBWWfdRXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

Hi Kuba,

On Thu, Mar 19, 2026 at 03:18:38PM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Thu Mar 19, 2026 at 8:35 AM UTC, Andrea Righi wrote:
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
> > With commit ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics"), BPF
> > schedulers can avoid the affinity race by tracking task state and
> > handling %SCX_DEQ_SCHED_CHANGE in ops.dequeue(): when a task is dequeued
> > due to a property change, the scheduler can update the task state and
> > skip the direct dispatch from ops.dispatch() for non-queued tasks.
> >
> > However, schedulers that do not implement task state tracking and
> > dispatch directly to a local DSQ directly from ops.dispatch() may
> > trigger the scx_error() condition when the kernel validates the
> > destination in dispatch_to_local_dsq().
> 
> The two paragraphs above mention "direct dispatch from ops.dispatch()"
> and "dispatch directly to a local DSQ directly from ops.dispatch()".
> My understanding is that a "direct dispatch" can only happen from
> ops.select_cpu() or ops.enqueue(), not from ops.dispatch(). Is this just
> an unfortunate choice of words?
> Would "dispatch to a local DSQ" be a more accurate phrase here?

Oh yes, poor wording on my side. What I mean is
scx_bpf_dsq_insert(SCX_DSQ_LOCAL_ON | cpu) from ops.dispatch(), so
"dispatch to a local DSQ" is definitely better, thanks!

-Andrea
