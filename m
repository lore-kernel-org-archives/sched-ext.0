Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FE314D2E
	for <sched-ext@lists.linux.dev>; Thu, 18 Sep 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211621; cv=fail; b=MEFKtBjteng5qwKlU8IiNTSTr7U6x+XDaLe4vFKwB4YP/y3zQypBrp2Agoo9uhGtKDHT49kEhIicZ81qu0FWgwnRAJW8fEodl93DBGLt82+pHx8LJwUAEK6Aq8VW8I1wObjy2e1dmb9O7s4dMH7Jdh2O+LLlYbEc9LxsGqaWYlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211621; c=relaxed/simple;
	bh=n5JRTycOXxdkuZrROdVo3mFK3ydvg/bz3b+lG/xofYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W6eeZlHBYmXo1d7e6WNlxW/oxPIfAtUa9XRYZ7tt9nMc2pCd5vAPesPT7jJMDfQMXQAd+HoXydUaE9s+Cb4bRzVT5DeOwfDUgOmANYB1+AHaNtDqpo4J0WtBUQDse9PxKg8L0wbP/w1GxL68URYTXpqzNgXtYBdXgHhUVqHSN9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrjRiFhO; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrjRiFhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xen45HM+qBYygoi7dYR+L8uosTZQr7B99iRfOVdSELa9HHLbP4WlTJM1qivIm6gMilmYsLFlsFeBHDZBxnwhpvtwqV3TNPfDDp+J5yccBBqvsLbew5su+LyH84vJIt540fQXbaeQDzTt4iO7DGrJ15SZ+AwlnNLOY3dLeVPbIAFZ8fxFcvk7YtMfiudUShLlkSPnb9VLDxOMUIaE+R8awcTJ0m3cvB9Gdpa4CdW5aJf2DgfTrQLIaUFxkTSnZLOKgPSNd3Zx9C8YXdDcLzlgLlNWloLW/rGrvg7rTRKFFLIMcIYLJCgTvs5eHMCWBtT9t5XN3lmNKI9jYCEtBJDkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etb14JyLesto1+okeNlOaefnxKkWU3kN6es3A5FY3cc=;
 b=j7aFNj+4/nUfmM0MQg3OPXwit5ExLX+SAETLInPPyv745Z99mY/qFmhGXoQWXB3Sv/SkInfB/nJnOCm5oSHLBPrrpodkEugajkrFMgQrINStcgR8G95D+MFDomlIg93ZOPGc+BePyhVS7ioQG5okLjer5OeygLMdC9btMmKv6iS7RhwAAwudonZV6/ZROlWYD+bvl+RXBSlJJdAps4zNQ+VitSVfiAPyUyC3nHnN61csFCRSIK3wFSUqJpbBeBt5yawGP81kaus6NJ0QHNc0j3Vlmd2XkAbApQAPP90bWbMcAoVIlcAb6CWJ/3ro8wEovc+zGo0dtV5S3UqXQbZDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etb14JyLesto1+okeNlOaefnxKkWU3kN6es3A5FY3cc=;
 b=rrjRiFhO/nvaaLsr3C6JXZwd/WcbK5MGVHqQGcAsh87jUagmwOHQ27NApGVDw6wrYpo0D/f/9Ca695S+h+xXgT3TKFd05yzlJFCwhDg6sqSgiQoRgQQ7+dQTyXaIVeI5BaWzNeMbY+vG00IauSy0rCOd86ZJ9u1qE/FUaBLA06MIzRc/rhBz2zQ+EM25kQY1Ortr3rp/BJppbU4Pf0PVpPWUFzn/K9ECZl77Wy6mBcXvERFfyMNAyA5oYkcYccCIQfWYYHfLfIZCbuL74BZLpQ9YEq/2Yub7fPK1TfjwZ0ntEpavCy+hBOQE51zvMfEejrrbOWmPoLhNqU4FTz+NhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:06:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:06:55 +0000
Date: Thu, 18 Sep 2025 18:06:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Acquire task reference in
 scx_bpf_cpu_curr()
Message-ID: <aMwuFX4glQ0YZGb0@gpd4>
References: <20250909195709.92669-1-arighi@nvidia.com>
 <aMCHjFwwjqvKsZBg@slm.duckdns.org>
 <aMCRzXgDv6PGqLwp@gpd4>
 <16b9e714-e6f8-49e5-a885-3c9e85f873b7@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b9e714-e6f8-49e5-a885-3c9e85f873b7@arm.com>
X-ClientProxiedBy: ZR2P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcc29bd-ccea-472d-7be8-08ddf6cd639c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vhZs5VA/Oz6MYzCISyhOSPkYRuLr7+gwWPn7CbA8U3TxjFVg/jFdnvn7DgZ?=
 =?us-ascii?Q?gIkwnPZGebg45atdggMyGUI6nG4NugTDmH3v8d7363mJvPultO7aMs74L51Q?=
 =?us-ascii?Q?YCl8pcI9bfU3lFMs7cv3nj9dWhACQpZ+btC6mAdwIqJAwQxkNl8r3U2DIzNg?=
 =?us-ascii?Q?lR4Rl+tUb5YRD5Lwsnkz+6bTzN9eN9crllxtmwHlYEN0YvCMASMVNyG+Dk0O?=
 =?us-ascii?Q?R4+OmiefmnLPevLMK6yC9giQwupBoM0ChhKJKIEvnGPFwiDachAAbpptp6Kn?=
 =?us-ascii?Q?Zt/0Qeq6/CZuqn0Xq/u8cXUCjUKkVozqG8WToCoGxH/Hy5CMmNCcl1Q6NoMq?=
 =?us-ascii?Q?UXCpEdqc3kN4NQ877IZAcsbsui4HRyb5JGjAz8rnovBld+FvaDpfP4xREjvu?=
 =?us-ascii?Q?4MakBIimCx4w+37ns1GzDZZ/aaLwV+EDwF655HjOBzP9SqR9ZAcpre3xNS6D?=
 =?us-ascii?Q?Yqc+ljHh0BIiFsOxuhCcYY/GJw/FMItwutks4XFFQB4mw9SGRwvfjtZ6+B02?=
 =?us-ascii?Q?gbZlKVnUZlkRFsdKD9PdyQceLbGAqoAcIlv0L1wttzBsZTqGD0gBkliNXDHd?=
 =?us-ascii?Q?IpbrCnjnNvanKKovltvHHMRe6rsuHqXapkbNz0L0ReTCNeuTL09faJ3Bg5c0?=
 =?us-ascii?Q?RA5cqhcS9gXBywKaD551gmYF6fHYpP4GzlssDKVSvaBSNkjRj8p+nyP4mDVI?=
 =?us-ascii?Q?NHThASiBgQwVkjZ+fdcDOApj2nEEvy6S1LxUS9OmHGalNuE1OHSN/fE679gk?=
 =?us-ascii?Q?r7ir+6r9qAUxqYRA6bNQ2sLvSj1LNt1vxKMgVLbLCfy9UhDVvjG1y1IWjnhM?=
 =?us-ascii?Q?K+NgsM9gPMjizw3dLxa4HfAcP8AtUVgK9/493oHAbccJRSEOfXVCaku66ftl?=
 =?us-ascii?Q?rRBldx2TZADPAyAvYS1Kq6BB4YAbYBCaUsEUoYXI6DHASbIwIwjcFYyrtbza?=
 =?us-ascii?Q?8yfOyhkfgP6Lql6IjHh1vO6Yf2cFRBjIUYbtyYoCxXo8Dkd0MHxusHamCJmG?=
 =?us-ascii?Q?k6rRzLadSHM1bwckat4/WKfXeh5IczO28fwgyjgStU7Dt5wYByhd1jWjze1T?=
 =?us-ascii?Q?Fvs3gPi09Ppvtne5XfqYCAWlEjkwzMOwI3RYKypp9tJgqXRKA6l5YdlHFFB9?=
 =?us-ascii?Q?lXDiUkOaEK2OjMOeU5fVd7Frnu2ORAD2OcItCO+b4L9vcmzm+IunV2m3MwlE?=
 =?us-ascii?Q?hTWErABsrUMIrxzZsAw+qOlIiUa6BWALqQJKzD2SDXd4TTncYAxwObFkv52U?=
 =?us-ascii?Q?Vsr4UBZxAZInpOsGT48Gm9i8KuoqA1Ek4v8/n1VThwmn12Jo7TKK679TyIhL?=
 =?us-ascii?Q?VdB+4NWYzPcIVmBELFk9pAvk3wEi0jxU2MpPjyYBKzLwIeJdNXKAHceMSPuV?=
 =?us-ascii?Q?3mcxAZxEHG8t5YOM0Xu7MxgCwjaTt3qq0q/edHv23CSarYlGLYy99Q3FDfAs?=
 =?us-ascii?Q?rD+8/BYihSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWk7+F1puealXcR8QsT+KCOOsNK6fWYECC39jVFHF5ChWDqlV8GXMKxPKeCC?=
 =?us-ascii?Q?GeTo2svucKDTphirIig90uGG91G5Ubpou8khnedchkGdFMCX3xQc46xGE7j3?=
 =?us-ascii?Q?tT8HGJtz2oi5005b9D5Z35yCnHIaFAZe2quCb0OQTze0VvjZoX8Fz2LuvQ7S?=
 =?us-ascii?Q?mELKZAVLpjq9WTCkeNmeSLI9eoDtBE+sY2cHLja+V/LIgBNuT+tIm0iNwVgX?=
 =?us-ascii?Q?Cjgh1e48lzUHizhQc9dWDIFWB6cCfHmZqPlv1xZCwKeWtmFjVZttHI50ivHW?=
 =?us-ascii?Q?v6ClZScbEfoHCHeRkMxCBddjibNsjXJT7plTF7DZIJrOYOgwvPo+rL3POuEZ?=
 =?us-ascii?Q?njw4LGuuTSPysdkw5wi3sgwFxBcWKbhQeOEvvjxD7l5rdTTLNX5Xvo0vAnde?=
 =?us-ascii?Q?0m7DRRPJ9Lt+tkLxE4JYR3Zd7QM6UHIOctvu3GB44FB0okv2z398QLh3Fqzo?=
 =?us-ascii?Q?21R2HZTJKOzg03dw4rxhCi+DCvsrHPSymGMMqVkb9zeNUOTB4wcSJD1y6Ezi?=
 =?us-ascii?Q?a5PxFoms4KArDDFoRfapLfkRxr2UkojB3r8vMQ8YYU5ni6gyQqa2AZaiTCz0?=
 =?us-ascii?Q?luzhWZBtIyF/QE1tWOQMXF5jFAEd67CCx5Sw4ZNWajMTbm+hYj3IIdGaNuvt?=
 =?us-ascii?Q?wNsc4v7SF6OVbLluAmB85xcOQHrljDsvJG9BOfuqOB5iGatjZPJxlbjDuNDS?=
 =?us-ascii?Q?YwQzsHqIZIDfThBPl4riLFsEgZzgvXq+OQQw7JEpGyh828N5OlU3Sk0rYpKl?=
 =?us-ascii?Q?NLf+4fG9caktPuOyN4XRk0kIE3v1tyxbW7k39qyVyRECGnLsMtUN062zJDP2?=
 =?us-ascii?Q?ZpX/kg/LktAQrRHN8bQSbdiowIOe6ygh87vdhOVa1R2qHXvuPZya/r/Ddxl/?=
 =?us-ascii?Q?5vQ5j4ZXRcBT/YW0OxzyFN5MpNF1pHvKlv6oqv8oR0lcT+8PdycD0zKMY0zA?=
 =?us-ascii?Q?rpZH9S1XCAg3piD4pazm6Y8uwA8IRIVqLOr6F2a0wZ71B3e24qzuiPtARynu?=
 =?us-ascii?Q?FTDbbTUhcjv4+UWBWGo/8ah9hk+SXhskmVfC1xFn1tf97mitZPejbULN9w9I?=
 =?us-ascii?Q?lK2M+BIE3QR8Ceg3TuMqLnc/k0AqCU9QHfLukfc8Hm54I93NExoXFkUylgfC?=
 =?us-ascii?Q?kRIehd+htbhRF6kg0pze/gtasLPVryVRxZ14DfIKMVjuASxO42lWyssJKx5r?=
 =?us-ascii?Q?YHCQ/HlN5/FTsmQOTj2xruKPpoCYNRyc/oQjnMRQlyJr3/rBqSnIbyRrd4wQ?=
 =?us-ascii?Q?HQ35+yGNpYXbkxKOgXB7BSYVb/wVGRwX7AH6UE5c7RmaR0ST5Av3qFyzWLBx?=
 =?us-ascii?Q?+z/Ne02EH92UWIEuksvc5r+6G+eqhOjAOuAWHwpXX5CG6Gx/rvtSS+uwskr3?=
 =?us-ascii?Q?CJCZtDiJYdZC3mWie30DH5hCTl50q1DMHz0vmuixpTl2IeEGz9eshSGSOvPI?=
 =?us-ascii?Q?cqTPIE5dXQfJchdpfDjTGa2QXwj8qvtI5VjWEBeCeKnR0Evb27DSwptkG/y8?=
 =?us-ascii?Q?YOOQuvK2ZIZG7ren2JQFL82I1mHSsSKHc0BphtCRNkEIRWQ/AMOiUU25qqlV?=
 =?us-ascii?Q?d/Z+Idv4TFRTOftfCAKvBUBj0XzCY3QiIWfvvDjD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcc29bd-ccea-472d-7be8-08ddf6cd639c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:06:55.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9rBkgt76wdpp3uHbHOwfLUuRkq5iJgSMH+KFYWjA7AIfJvgiEN1OJWjJ+r4F8C1mZkDAT8dHkr0GM3JcoWGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

Hi Christian,

On Thu, Sep 18, 2025 at 04:48:14PM +0100, Christian Loehle wrote:
> On 9/9/25 21:45, Andrea Righi wrote:
> > Hi Tejun,
> > 
> > On Tue, Sep 09, 2025 at 10:01:16AM -1000, Tejun Heo wrote:
> >> Hello, Andrea.
> >>
> >> On Tue, Sep 09, 2025 at 09:57:09PM +0200, Andrea Righi wrote:
> >>> scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
> >>> given runqueue, allowing schedulers to interact with that task.
> >>>
> >>> The kfunc assumes that it is always called in an RCU context, but this
> >>> is not always guaranteed and some BPF schedulers can trigger the
> >>> following warning:
> >>>
> >>>   WARNING: suspicious RCU usage
> >>>   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
> >>>   6.17.0-rc1 #1-NixOS Not tainted
> >>>   -----------------------------
> >>>   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
> >>>
> >>> The correct behavior is to acquire a reference to the returned task, so
> >>> the scheduler can safely access it and then release it with
> >>> bpf_task_release().
> >>>
> >>> Update the kfunc and the corresponding compatibility helper to implement
> >>> reference acquisition and prevent potential RCU warnings.
> >>
> >> I think KF_RCU likely fits better for peeking kernel data structures than
> >> having to acquire/release them. Can you post the full backtrace? Is it being
> >> called from a sleepable bpf prog? Or is it that we just need to expand the
> >> rcu check scope to cover regular rcu, bh and sched? And, everything aside,
> >> if KF_RCU, should we be tripping on rcu_dereference() in the first place?
> > 
> > For the records, as discussed offline, we should be fine marking the kfunc
> > as KF_RCU_PROTECTED instead of acquiring the reference to the task.
> > 
> > Right now the kfunc is marked as KF_RCU, which is not really necessary,
> > because KF_RCU ensures the kfunc *arguments* are either RCU-protected or
> > trusted.
> > 
> > KF_RCU_PROTECTED, instead, should ensure that the kfunc is called inside an
> > RCU read-side critical section, that is what we need.
> > 
> > In this way the kfunc can safely return a pointer to the task and sleepable
> > BPF programs can wrap the call in a bpf_rcu_read_lock/unlock() section.
> > This should prevent the RCU warning while still letting schedulers safely
> > use the returned task.
> > 
> > I'll send a new patch with a proper fix.
> > 
> Hi Andrea,
> is this patch still outstanding or am I out of the loop now?

I have a fix in my tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git/commit/?h=scx-6.18&id=225dccfba74877ba7c74971801f8d8f47d124373

But it also requires this fix for BPF as well:
https://lore.kernel.org/all/20250917032755.4068726-1-memxor@gmail.com/

I was waiting for the BPF fix to land in bpf-next, then I was planning to
send the fix for the scx_bpf_cpu_curr() kfunc (I'll add you in cc).

-Andrea
