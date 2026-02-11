Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03558327C0D
	for <sched-ext@lists.linux.dev>; Wed, 11 Feb 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826062; cv=fail; b=TtRaaYFPmoP78tKglHsjmHN2Uh+Tsthy8dfOdyK6QnLw6U6muJyVKVshxTakJGLVsFE//bDLMJmjFWAUjv6yBhzjgwqRZO/vUNifg2s2yFYEBWI4XOeRUP/rxRTVMpBOmkGJOPVPP6HEI08vjdsiKS/MkKiZXgwqrK9E55UNqtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826062; c=relaxed/simple;
	bh=/iEaMKetdvox4h3HrRupWQ5Q6HFQiqoEt+EOozoMJTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RC9pjmSfCM/KE4AxNdGwheQl+cTCewP/xaMBghgovpJqebc/GYv71m9hzpcwb8jGUnj8miUSGC1NWU+MZNBsIHNvJsFZNSe/xIOpLPwKntFKMKxVhXN9FNvaw2EwT8lcn1fnskQWvWpDc1BWn5CgiZ3/6koNWX/kihz1ofAfTHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGR7WcsX; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGR7WcsX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4CZFqUXTTUtbe+pumQF3/kyf3BCTezt6lILS6aeiMa9sBNB/KoKJ6+J/+OpwpxG3iB5zR9ouCu1AG5JOvW91X824IBFA1c//ORWr6VOIss045qkD8nzSgapdbNWenHXogfvlbfX8wHmNf2Al/4FDMIjXsL1IiZZXHmEIY8v+VQ0GpjG2K2kVfIowNQ0gsomWybns1BAjl8zXhI95GvDr/GtGVRsageJBPthBsyuSdRTFrvjzMvxTU+7993pMc2DSQ0+tXRPvXsaW/HZ6nqtIQAZ1fWx9LEEL6HNhYWm6soMANMCo0DWC+Jovko+Ej4PyxYnZkUVpD3y76jIpFt7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Znd7abxKuNf/Sw/yCY2najDntNewOJy/9FWuy8aOFtg=;
 b=fn2cD/O7PfDMW5Sjfb5pZtSpZ+l0rbouZyWwXETJCfMF6gxOYY+j02ZmPBr8Kd9t7xwZRnA3Wx4FyYx9Vda7AgeYTWVb4Yuo7LFHgQwVwN35m9taG3E6KVxnCaL9OislaPDW4Wyr73nh83wACCaQlpLtjDWVFahKOB5Pw20j9c2PHvE+AwT7VLlx2EQCNKqYoCOv3NSQOos322n8UTXlgYDUYNZ7TjTXn8WN3XAtU33VIsmzYDHyKkCbFNIbsYZ2fDK93OxWw3u4ngotIQ4q7Y//ShEYGYqBlccDFi4W5m1Qzbuvfcs3ko7Q2+EJt0dsILISPspZAmqSAZCXy3CZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znd7abxKuNf/Sw/yCY2najDntNewOJy/9FWuy8aOFtg=;
 b=bGR7WcsXDgkhFFRJ3zOjavDMMkOPcEFRh1k+04JLZMJcjrzKkrYKHHz7zyMl4mepjKJ/i+OD/byTjXjTy603Lzfd8Upe2Xm/bv4vv4Ivw6HkjNnN8Yvu/LC5Qy1VJBqYgfeGfoewh5K3bzBqhTMDYrFoAXOu1+MqTY5S5WPJf53sYnlzKijNJokVGeHJ2SvJYTjo9s5IvhCDJYxt4UTqd7oqJClGj+Yu55MMhZawPX8Z0YEpoI+rvkwS9gNDhqEBU/wMm0+Yy4luSKlRYVjFrsOOLFakc6PNQwGEl8s62mlqgNjQbsnV1qNMq8Q9Ih/L9BMqOmVPelF+5n68zuH3lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 16:07:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 16:07:33 +0000
Date: Wed, 11 Feb 2026 17:07:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYypQgLb6yZoBfzo@gpd4>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYvFP4T-TQHuez3X@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYvFP4T-TQHuez3X@slm.duckdns.org>
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce34867-1ac9-48a7-a3a0-08de6987aa26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EQDOgrtSjlGK4xmOvuZ0pwGIbhVPOSxkPXkLzeszuNUD1EPvsfEPm5s5E22?=
 =?us-ascii?Q?4OxySdoA14QvjkG8hEKpLpGVUuD24uNsK+WX46FQs1gJs6HCsqClqhG/QlcM?=
 =?us-ascii?Q?qDx+Q6aya+iaeYi9hTOd5xmyvHdyogtToJPRZp5kBnuXC+wZBlBI5G1hgEPi?=
 =?us-ascii?Q?px67yO4uoI0fPFORQ31ZSsOnAk/r35imkrhPK0v/t+Ne6AlJT+avC09iJEN+?=
 =?us-ascii?Q?WMgPgN/tEKUEOaYIvRtnwfapauE/gu/MlwKDC6ebl4nvQ2jiEd+TI9Nfcv5C?=
 =?us-ascii?Q?FKHcvz/EKOPq8nlYcAFJvbLUpfyURA9GN5wiynYWc6GVWLcZUfGhgP+RtwVk?=
 =?us-ascii?Q?mY5NQPvw7fnV39FXnIEb0x0ARFxnq5ZfCdI6TvLA0VAJXgIj4ScgcbTzf04W?=
 =?us-ascii?Q?hhXdhKIkN6SpDZlNKOVEpJ/MOsBU3Jg7qTNqU4pGYmvMjeWZ3asPnctxVuTB?=
 =?us-ascii?Q?yqNhPfcHLh5TG9DDMqLD1k4Ri4I00UQgqq7eRRt/r5ifSlWVZX70/DGZBWy8?=
 =?us-ascii?Q?WMFvH6WVdSkcyoikCBTwT73e4pI9OnMKwCg+CmNEMvnUtKdSV/U5Sl09rrX6?=
 =?us-ascii?Q?cYHixHOFYbHJEfWvsg3EQOP0bPhMMt5XngSrA6jwJ/DLCgnKHUZuIiQ4HnSm?=
 =?us-ascii?Q?9ZIZlpJeg0ZyWLgNdvxSp0t2p7DcNYFO3d6yQHuL27pPipoyExWXwqGag+k/?=
 =?us-ascii?Q?Xx0XgeCAdhCM3OMUPmsKPeAZ+qVcJKAGZe3O4PpPw0KeAT67NaKMWc+AkBNc?=
 =?us-ascii?Q?u1UVuIdC47S0RIpA1h6FDqR/3VAD0kF0c4vGV9h5ADQAQ4pAp39qYXi/ATW3?=
 =?us-ascii?Q?NKVtiYs9iB5g/iFx3USedrQYPWP+aiU21+v+/vciwyUmm6ICOAcTQPZprmIF?=
 =?us-ascii?Q?RlAHxpxEhcVT8S1tRSyy11qzyLxZsn6b3kOuvaSsoKBar6E3Ne00TU1nSt39?=
 =?us-ascii?Q?cOOZ4AxKkV/cbbSbvbi03v4bTukmG25RVMXLl8COP5ew0Rxh1UrgeGTzf3dt?=
 =?us-ascii?Q?JvYDehDyWcHqqHmpc3fEgxgAl4UhsJ8Wt5BZgzW6hyJ+2KVXvOdEMbHYaKMU?=
 =?us-ascii?Q?3QwMaZErwh5jlCrk1Cj2NfPnTrpGLCpnyA72fqb3gumeXJU18sefUrpRMKxv?=
 =?us-ascii?Q?GAC7l9Lh+DkYDdwKdgmL/Mt1O9tziP1P5o8QflKBIBNmeW+3moVGGi7U1+/+?=
 =?us-ascii?Q?PtT4Gv/wxRLMEAvtEcYLbc6iCHt/LGkymUboRRdYRTX4jDVYWppBZn8We/Dh?=
 =?us-ascii?Q?v5ntCnFt3/FG/toHhp5qDHXQi8ECeW0dYjTZJrj8jsJ8cnYdBS9VbkvAEfOC?=
 =?us-ascii?Q?q+4A71njXc9Bu1sflPB4I2EjLS1p0mCUjapS3Ik77DRZVc4GVoeZGK+JR66c?=
 =?us-ascii?Q?y6JxR4cW3SKFQk4lQ7lPbu6GROid/fBKV39NWU4e8PCuswZrdKkqOeTEi36d?=
 =?us-ascii?Q?L+QVmm2Hyd6znyVsERKlCzfd1aTSJwX+PqwqIslQwpaID4TI1DeNeyGsy0hL?=
 =?us-ascii?Q?+VubZZ9+CFsTz7Co6tvMa59VXnMbSakaF2IUf7grLZ7HWcqyfLB9l7/1dR/p?=
 =?us-ascii?Q?v8lNGcV85D9W+sz9qNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Xcy2EoI/lCE7ZUpdkfA9RGpj93IuP8zQwpD/03O9tPDZXgxYkb0fPChDBbr?=
 =?us-ascii?Q?gKU44SsrmdMZwS+FMs0ZhXKgfGEOYmoSsCV0DnENZqUQD03Wz3J0BCJhHgwa?=
 =?us-ascii?Q?2DytALK8ec0tQSYMwIa9CEN7JwNryhb5OKeTc1VlcFLqNpGrApsHHzwswYpd?=
 =?us-ascii?Q?bXjMKv9r9DDB7dKZJJASSTVOHf37gbhBZ8vDUXohw2w/IhjZnrceTzanu0QK?=
 =?us-ascii?Q?zjdoyZDYpFy+a2V/3rDQyzJXe8Q1XkMun3eKY1gwpDJTDUwXQlPMR+T4CbNq?=
 =?us-ascii?Q?QnEFgHaVeg4KqrNlQv4/byN8Ok1u9DrZvFZrWRD8Z9pRzt8TRg7c39B81xEY?=
 =?us-ascii?Q?5oQ7xU/17BasntL28rr5V+Ghq+U8MyrhBF6rgQktzN+gi4WWxyy9d/9ahf54?=
 =?us-ascii?Q?4AMvW2gejkhQe/kzWCyjUqnRRPnwUWqZM0SpwfUid9POlpNXcA8gRQ1UUwRI?=
 =?us-ascii?Q?TROorNWIworywE7wPGCl7+EscyB2DrXjYyEAYAY41oZBitSDaAnmxDKgPHN/?=
 =?us-ascii?Q?/Wwh7pa7nzpf0iBLyurIsSCFhMMNsYbc4IvIyuDwry6vbMdcAWRKvZfIS9Aq?=
 =?us-ascii?Q?F4/cWH4syWB8wVc80h0qehHNKPEML0EP/KMMUTssqc7DnwzpUKf21Mxsp/zT?=
 =?us-ascii?Q?YUSGnawsrep0QRjZt5METj/P6X95wcaIC2fJzejkvlDfUIKGbVAGcNzMKY/y?=
 =?us-ascii?Q?UyhbkJ2D1OPEXviL7O26QmxWl4eCVPXvNHGFMIxxHIUdorlp8iMjX/xfutiG?=
 =?us-ascii?Q?H+3f/K8wTJ4PQhJ4y/9snsJcOSoRD1aPVtyW6UPktM7lCM7etBUakpFOd74J?=
 =?us-ascii?Q?ItbAeKungd6ju8ks5BeMU9SqLzJ84RNfDj6a2YENs1crb4cZyhn2qh6ccODH?=
 =?us-ascii?Q?bYIgqFd9jm67bskWuoZ63khbzCMsqfV7h7r3J6Vx0MvYhLExXHcFe1pnaNMR?=
 =?us-ascii?Q?7zarcCj99hDIElEe1rhP9oUDk9uRjupTh+GvxwgMxBsHuCA+u0+gFzKS9Lro?=
 =?us-ascii?Q?ScWMnYoH3vzXJaDr0hXHkmoycx4RZyaFuqcgXlHnaOdObWcKEZUT+TnkLTMo?=
 =?us-ascii?Q?h9INBjLge/T2tMO5vUAmibyg00cmsKyZvFG4n/STaNcRTAOeLaW/J6PcexW+?=
 =?us-ascii?Q?AGqfoDPWIqP5tFnLJ9XWb5vtkmqBrB6PJ0h4MEptXQFP9XxfgQ+bVkEqB0/G?=
 =?us-ascii?Q?2UL7xFDwyvMqCCTkLH8SWLTTDo2ZUq/tk7lE4/L1T0S4lY8dWTHmC1rYtCnk?=
 =?us-ascii?Q?Fz4c1lV9i28qvQnaLIvPzZl3PrddwkJQxHon8NeeH/3lQRtIFN4eH3llzRrj?=
 =?us-ascii?Q?drxgAFqIWc/LF790/BagRE8zMQSG0a3ccrNkGPbIG3AxrV6pLnF5yvfWs9L7?=
 =?us-ascii?Q?1F/Bhrb6rHMj2RMjccahUNei3CIHmlwy/reriioW+QkOZ9UmAXLBWhaW3doc?=
 =?us-ascii?Q?Cw8SBeCIA1/pNzjpKQ99qI0wC6CroEixq6oXV8seMwcPqT/0lAIKQI64IU+f?=
 =?us-ascii?Q?ujtizw6vsujmF5n+wXar/TYT31mVlPpiQn1WUOfjP0KnZJjXp5rTbIvlwLGI?=
 =?us-ascii?Q?2m7YYEqfItU8urOzGTAeUDJi0sqzwF15H1WlwJMLfJDMbwa+V5Cdf3LNJeq5?=
 =?us-ascii?Q?ZiSeXArUO0SMabrDiKWO8wW2/h+h3DSIKz3gEIKRsepELVajNEBFim0id7v6?=
 =?us-ascii?Q?OdupbdJ/MmrQ0pO37Iwv4XmE+lMAJIbty6TOp8pig4G5lSn9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce34867-1ac9-48a7-a3a0-08de6987aa26
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:07:33.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAcNJRaiW78okq8+V3/uvKeJQ17ORhqyQrD78l7VR5K0/rf63z7OxvwR0VdIUlGw+cIDjrtKOUpM78V4G4RieA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

On Tue, Feb 10, 2026 at 01:54:39PM -1000, Tejun Heo wrote:
> One more comment.
> 
> On Tue, Feb 10, 2026 at 10:26:04PM +0100, Andrea Righi wrote:
> > @@ -1407,13 +1446,19 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	 * dequeue may be waiting. The store_release matches their load_acquire.
> >  	 */
> >  	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
> > +
> > +	/*
> > +	 * Task is now in BPF scheduler's custody. Set %SCX_TASK_IN_CUSTODY
> > +	 * so ops.dequeue() is called when it leaves custody.
> > +	 */
> > +	p->scx.flags |= SCX_TASK_IN_CUSTODY;
> 
> As this is protected by task's rq lock, doing it here is okay but can you
> move this above atomic_long_set_release()? That's conceptually more
> straightforward as that set_release() is supposed to be the "I'm done with
> this task" point.

Agreed, it definitely looks more correct to move this before the
atomic_long_set_release().

Thanks,
-Andrea
