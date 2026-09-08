Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E0511E6B;
	Tue,  8 Sep 2026 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862529; cv=fail; b=tS0AjPcgqSTTBqm3YE8ZV6YnxTKcet3MigjBdPXT7qvSoEr3m8/iL9HFyHaPndlhL+n2l19CTu91QsxwXx+V7e6KXu8mnX+kKEjP6fkpoVzXpeB8/k0aPA4do2a38Eg4dDUTy76RKGN46FF69azlkMzb+/9sY7azHjh3CiQPR8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862529; c=relaxed/simple;
	bh=qdxNJY8LQAkrSpzxi/CWbC09X+mNJHgURER8d6AZaH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E7JITkZNleOj34UpOr3lFnqrPB0WDNt8eEOf5a32eAgnJVftn2duvTflNFmJgWeE/88RIVpAfZdwd+Kiqpl2pK2fUM6pHp0hYC2+ceP5p4i6/lqXfd5SB7v5CfOJDpvdecPXRb22SWmSSgjgiRXkb9FK4HbgfweAmQEszVH1ZDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P636B40n; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P636B40n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcHofESGgj/mh1pCQw0ViR/Uf79DTVnni8fCMSBfADnZ+bmkCSoZj0jts/N/MWH/ZD/3/C+/Lp2EhbNfTewq3enC+YHfW5PjuXWSYwO0C/fnwPLFldKH6608R9dRcH/8OBEkEem7wvn1uOD07mX9y2SQvUzOyOWJ+XIxRyC8ZSd4j8r4Gf2Njrz80Le2VjD8VdoDwzdOQ+nM9cOlyNWVaMlfFvEwbI02Wkw4394XEER10GudBOKCdu1cAY4oIacBzqrLcSKJaRaPK0AHiL7C/2pIuNbS7wLq1o8Xet+PnW0nw9/gDT7uXv8FryNgzQhM6fYAdS8GHaIwZmrGkV8Tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G93IJ9BakFmlikr4IcoVkPWFRm5RizAv29wt26FuYo=;
 b=F4XPSAikzKfh7F0SrAifdzOxO5819NS3djP8+xV5XxHbqwhtBiuI61wZEuDrUQLV5vXKEyp0hOR3ZQYnc29yfdgDR6fFy1ki97z7Eqwq8BqPobKa8UmNbVT2SyVayrzmM67hMEhaRl3/p5/Kq2rSlt37bzAr18sRCM3lPRDhtoDQxMUxVAjHDYPsfiubcdSWRL8ngycBSZ07W4sdA35j1kqb8Sg5S8dbqT4tIQ42CvzHqWrQyt8xOsHy9JiVK9r0RpoQTMVNqCxY9LPhjkLNoLDJT6sXnfWUfNvFYl7tUajr8YvHeESql7fvlFxes/8jQx2zoEqCBlHglorRliEndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G93IJ9BakFmlikr4IcoVkPWFRm5RizAv29wt26FuYo=;
 b=P636B40nj7g7rbq5ub3nmnrkx2KxgvU28ur5zw3RtPE4Mcxb5OZs2Mo10MFFGeK5X/BX+t1BcQ2lwtGBVin4NrLy+vSLuVIcBscEnr/JpW0R4vT3YI3bRGegHWK8fPVcuUzeN6V4dznxMFZJysYHSQKGaoH5SKTUF1HXAI3eJnHUWgu3vdMQGuyQOBlcshxKPm4O5HW8aoWtND21CCnDhn14o6I8tsg/l+xL+pW4eQjPDUpxSoSZQJjcFJaARpx0JE0JilbuIydDss1L+HbIFQrwEvMIvm4E3Cct/eL1WU9wmL6x1to+akSvyltlLfJzBpLnaJd92k+LYe9D4ayuJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:15:24 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:15:24 +0000
Date: Tue, 8 Sep 2026 12:15:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 14/18] sched_ext: Split curr|donor references properly
Message-ID: <ap_gMp2soO8xZLxa@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-15-arighi@nvidia.com>
 <20260831174907.D6F001F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831174907.D6F001F000E9@smtp.kernel.org>
X-ClientProxiedBy: MI3PEPF00007545.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d1) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a96329-10f8-4101-a13a-08df0d92189a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Myo7/yXMVWe+7yJ4wizBW3OT9b2mFEJ3tZu+E662dxfixzWgKkwESq3jyemFrsxYhDvxCMIfaB6afd3tj+M9cT2BdV0xvT+uY9awNGzecc+KqskxBvfdC4MBy0J/+RNVJsjzHsidV06m/6IFhnEADPwvPLbHOUyJK8O106D4El7f9NPv3WS/ktnNbF/vDitVMI7J9x089rdjnJlMyvOSoJdnZ8/kDrESuGj5GTsxvOKVjkjFyY3y9ysB0gz7HDNN8e2wYFif9rkgO9GmEQVXWNKYaHW6efS1t4eI+gbd41QLPqHRmdlfoCbhubylq7lOfAgQEeaIDgXeIt6pU2+LmBhJizdE4oVVIU0WUBaLE35IwtsnuTNjtdt0qXO7RdfPwIE8l4Ox2m9CChsJSLdZjX98NyK/9JKRyPsOgsmLIZZTX5IIFQJiKOp6aunwxFqOrBYa92Nc84qAya1kYI06hluAso8CP72m4WdqbPGYdjwK8+6jhrEKNDw5XalgsgysehfakrQtkDIqHfFYtp2eVuLjfT/cotxr9y8KZ3/WbHDZNZKJgO24LDsM/tVySzRaVtVhRMY0hYa0/CKXEeKyIyW4AuZWGJ0q+T8gsY6ibQ4XyUyE9Lm6Hig3Dj33XGJsxMrtnx9Legoow2/5ddIbVHfiJX8TOhNpswwK4SkBdQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQtuA62dM6JKpqlCPCudJ89uH4iaQNwJAlv+h0PKyFenlq3SgS2z+/XH/1BR?=
 =?us-ascii?Q?k9QxoCd31rk5H6np6GCTbTq6EvTdM8a+2T55tATBcA+PfJd4iUAcnen2A/R7?=
 =?us-ascii?Q?xS0S4XQqLtVqMkSypBrTYYn+b/3JafydAtZ5tCQNa/g2R5rGvHtygBW4iq3a?=
 =?us-ascii?Q?sNXm0PW9dlUSE73F85Hm8C2XOIaNbzHSIrLdOV0wAVJPChnOGJAeiuspf2NO?=
 =?us-ascii?Q?c7kMwysxWBLmBXqUTI7CS+PcyJY3/yIHN7vMxeqZyjIFgPnLNYeUpSMqjWc4?=
 =?us-ascii?Q?p3ISg1MPkPGSqr2P0JOHlzp0fz+qhaPqPw3iADBJFqFrKBWz2QFbMmwmAARy?=
 =?us-ascii?Q?kCg1G+6NSjDOOTvAti7hAZez3Bj6up5L8j9JpVVb5proycTyevW6aWaGd8In?=
 =?us-ascii?Q?9r+gd0WuJYSL/j1xAmClhKf8agiWkQo5n96nn+kX1sjbCSa5CYX9VV0dTtn9?=
 =?us-ascii?Q?bQ/2HTRZWzELBtk/mZSI7FuspNzSNLkVT4FTqYf0Ag2I5oYk46azSlM9Srhb?=
 =?us-ascii?Q?aFjgbtmMGmNbTBWu3OmH6ZBYjyiCIJvgVCxX1QjWIgyXUfOj2NH5e7Oyi4LJ?=
 =?us-ascii?Q?zfnjz961kRl+Eg7DjlmAV1cvBxiwPyE5Im8s12hjmjQz16Ru+uTBWHbfmMeW?=
 =?us-ascii?Q?x84j2TKs8B5i6sxNDewu80ZEnsWCcvj4aMBAATOt9hZ0pGh0aWPFYnjgwtw/?=
 =?us-ascii?Q?3kHOAVShJrkhgoMIzrb9z2zBwo0GNlWkt55pEwLiuyIQsdIIBkBZCF1KE83K?=
 =?us-ascii?Q?zndzOvuyLwSZpOL9dX51awkEkF7zy5wN1ucv+hKDcX3A4i59eZdlEtEVCyoZ?=
 =?us-ascii?Q?v/OaaAuaaoUzKvWuCURPWZQ/zTlBU5ItZ0X6EKfipKJmCtXW1kmiWaKSfqPj?=
 =?us-ascii?Q?FKIcT3VzIpgAr0FniUkjg6iZLOiVzOL1IiEDkDmhmL9mvz7VkFq+97iy4kYw?=
 =?us-ascii?Q?f9TzdNg1PKlSkELCG9c0hGZaAlW5bHYmz51BVEYLNeKf6X8co7gw63Tl2XIr?=
 =?us-ascii?Q?k6jQ7AkrJagCbeibRz98EA+v1w2t7JEEzvJ+hGHkKJmDREyAu4X+w7RDSMPc?=
 =?us-ascii?Q?Hbo5ljs5H2MK0qdBytsosKb4hGN3UlN+myYffRLn4g8pEA/hNCbdxz0Jr5Ll?=
 =?us-ascii?Q?NFiIyfu3z1xzRtaJDTIDpyCkT+1O18O8J7bNwuhLq/8AGaJZzFz6hhS23Vxq?=
 =?us-ascii?Q?SDySWOiqKW8ykhg5rq0uxqAg3s6awlN3MtBnTNeM2ZJW5bYCeS1ES6cxWN8n?=
 =?us-ascii?Q?FZfzJNLeNuTwIVRBdXXbtAIfJNcAMgjhwOCw0bOsx+KUgjGfdnHAKQiUm8hT?=
 =?us-ascii?Q?/2fgcu0ovi178zSq6G2WEP5JObF97Pi0LglkIvFWtKfl5ut2yUk4UK1AWRux?=
 =?us-ascii?Q?GPZ75aGWf9uV+bGBgCI62gHHszp0srCIGWH3rFjaDdkKkBeUEkjP3xhENcnq?=
 =?us-ascii?Q?6afDtNoaC7Pwzcn0ZwMTE3SAKK73z3098p4lw4OHnp+WmVVLzCzZLUuX7GTU?=
 =?us-ascii?Q?TAEfSWTd64Ei6NehlQ1T4+oG58OSOD8OM0+CD7O7q+hOp6wRIfaPmevhPxjT?=
 =?us-ascii?Q?mFuO4puMxPCLkqPor5BnDX17KoHS9QohhUt9OGkOz9dpfrCUjvfFJVBQ2mdH?=
 =?us-ascii?Q?sSbu2cjeOJWuirkx1yrmoyCFQNsCBfylOW3eNz1slGpFbvJ/b2hGfEW9eZRC?=
 =?us-ascii?Q?H4/iX8PmTWF5oNdYJIz4dz262i2T2EA5WwPeUI7iTzzgwIEwZvJIEbrRAm9K?=
 =?us-ascii?Q?b8rIOXTW/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a96329-10f8-4101-a13a-08df0d92189a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:15:24.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tyb8OX7wfp1tQe3LbD+WwspXp7Iz1T8pmUkcUCNOWJf4XNcCshhZLdYecylYnvcV6QrCygCuTQTBgOoLnWjHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

On Mon, Aug 31, 2026 at 05:49:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The physical proxy execution owner is spuriously exposed to the BPF scheduler and loses its personal slice during SAVE/RESTORE cycles.
> --
> 
> commit 9c0210f5a5bf78476570e1133b4136f7fc67852c
> Author: Andrea Righi <arighi@nvidia.com>
> 
> sched_ext: Split curr|donor references properly
> 
> This commit separates the physical execution context (rq->curr) from the
> scheduling context (rq->donor) to support proxy execution in sched_ext.
> It updates various scheduler paths to use the donor where appropriate.
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index b2e6be4a887de..f23e9f1ee2f3c 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> [ ... ]
> > @@ -2170,13 +2177,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
> >  		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
> >  
> >  	/*
> > -	 * Restoring a running task will be immediately followed by
> > -	 * set_next_task_scx() which expects the task to not be on the BPF
> > +	 * Restoring the current scheduling context will be immediately followed
> > +	 * by set_next_task_scx() which expects the task to not be on the BPF
> >  	 * scheduler as tasks can only start running through local DSQs. Force
> >  	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
> >  	 * IGNORE_CAPS to force entry into the local DSQ.
> >  	 */
> > -	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
> > +	if (unlikely(enq_flags & ENQUEUE_RESTORE) &&
> > +	    task_current_donor(rq, p)) {
> 
> [Severity: High]
> Does this check fail to recognize the physical execution context during
> ENQUEUE_RESTORE?
> 
> During proxy execution, the currently executing task (rq->curr) and the donor
> (rq->donor) are different. If a property change (such as sched_setscheduler or
> setpriority) is requested on the physically executing task while it is actively
> running, it will undergo a DEQUEUE_SAVE / ENQUEUE_RESTORE cycle.
> 
> Because task_current_donor(rq, p) evaluates to false for the physically
> executing task, wouldn't this bypass the SCX_ENQ_IGNORE_CAPS fast-path and
> erroneously expose the actively executing task to ops.enqueue(), which violates
> the constraint that physical execution contexts are not exposed to the BPF
> scheduler?
> 
> [ ... ]
> > @@ -2342,7 +2350,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
> >  	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> >  
> >  	/* see scx_task_slice_ended() for the save/restore exception */
> > -	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
> > +	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
> >  		scx_task_slice_ended(rq, p);
> 
> [Severity: High]
> Similarly, does this fail to recognize the physical execution context during
> DEQUEUE_SAVE?
> 
> If the physically executing task undergoes a DEQUEUE_SAVE cycle,
> task_current_donor(rq, p) evaluates to false. Could this spuriously trigger
> scx_task_slice_ended(), incorrectly zeroing out its personal slice while it is
> running on behalf of the donor?

I think these are all false positives, the use of task_current_donor() here is
intentional. SAVE/RESTORE is preserving the current scheduling context, rather
than the physical execution context.

-Andrea
