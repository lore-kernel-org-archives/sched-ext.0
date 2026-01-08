Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB678275844
	for <sched-ext@lists.linux.dev>; Thu,  8 Jan 2026 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853550; cv=fail; b=XCJhkSpxdjsbNlOTkZXMl6v82HmBDUGT0SFYGDNrR57zaUaXTfKtG//+TH5hh9HAJCuiY1OGqB9nXzRFdse7ObcvCO3nUlGozdpTQj9gasJpdleyjhw+Grq6jeqgDZ/qsPvATkY5PJgT/wpXuU/lhWN69wiWOsdWBuv34+uTL5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853550; c=relaxed/simple;
	bh=eiAM0cKFkSRKZhCOJU5SIVEAI09sO4E606JHEFlipkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtW++bAh0Ps32YrCoYzUi7NjINdaNpfwa2oHrZBKcKVncFESLPLCGvaPpMBXK+li5OOSxPhauuD11f8So0rQ3OwA4DMJGt0N7sRz5+Bzzuy0EioYVsi7Gbtm3bBrM7JmZx1G9bqdK/NSIv/U33PMAq9NaCEJ4MABjyY81z8BlyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+82Xe1J; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+82Xe1J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9fRTNRs5kntW7XPQwbas02QpJNJCIwVceNlv+yfN1nERJ5KGM5G4uxXGV/3KCZmosPVWkvoPZGSTx7yACA9HWw8hqVU2VuVflwRV5AWhCJFvBNgpobUlpGzM0+mjyAahz9OFx1jYAfouP/098r/tQTr4yKw5ESdv0VMXVf1ibE/M9BsO+3fi6mqpSY63/EaSYPLgJLdZ5OyTapDgixMXBv1kQ9LZdgVEIW5s8yZPC5VAu7uFFl6w9l28UMvuf4iVtPdQaoizeCcWl/ae/TIKE5gWYqKnFRuXrryjEENcW/3by0RjknKycfbnTeCKBJuhq8fFMG8GSPRBMz1QxhoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aep5hOCZjvUGzlmo3ajhEUpfkJUOC6mp2NBoWyrnlvM=;
 b=BvJRGfHGREmtiY2HCHNcIP/YgU7Bc162v2bYnqX2vmEujT313OrdzxKv9DfsuQ9Wa6TUaB1kN+cz61TbP6OntQ63Pq0ABhpCQVCKWB8nYhGE2yMccBovNhYO5e++R5MGT3M/G5x4KfjLuUUXEdXXaEI4MgQB0ZA2rty4rmqMs/h8Hush6D393b6N8Ul6tm1DldCKcVy9Z6vZNHXexFFio+x+uRui73pa9c3kxtmD16Nd5bEBs7FJ/igC5w/yvUb6lpsHPvOkGYg8Co0NElUVNlKwakRze3b9MIFUJtBxpIgYayON/CY3Z3hcTsxMgit8g4p6FTbJe8MpS6KEToWmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aep5hOCZjvUGzlmo3ajhEUpfkJUOC6mp2NBoWyrnlvM=;
 b=L+82Xe1J+PTUendbP5b++/CrMROq05qYH6C8XeswYOJB6TVI+Zd+hAZRny/N3t2dcnRtIcprCzvk8TIWknkAnH1TKqjWzg33e+RE0y6o4udFhQqVOjZhageXwurFjWxB0jpzjHf1Abl66aI86i3pcyiVfGoet5ClDE47LkEh9Le8gvzPxfbg3x+YX8k57zAqtAjmheRLDr2AvtQoyplK20EMmwODhfRUFdv9I/PD8LhuODn+dZ2yfAv0Kkh3OJH8Ywaej1pAKSCZoN5khheBZKI8O0kUR4fTDJeX1gkdJe55d9oojkN5Dzcn+sBvvmE54IPGGcDnTJTQMhJ8iFgVUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 06:25:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 06:25:45 +0000
Date: Thu, 8 Jan 2026 07:25:41 +0100
From: Andrea Righi <arighi@nvidia.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: etsal@meta.com, changwoo@igalia.com, guodongtai@kylinos.cn,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	tj@kernel.org, void@manifault.com
Subject: Re: [PATCH 1/1] sched_ext: Add error logging for dsq creation
 failures
Message-ID: <aV9N5UxymrzJ9jSP@gpd4>
References: <BL1PR15MB531447D39DAACF121532E6A8C784A@BL1PR15MB5314.namprd15.prod.outlook.com>
 <20260108032328.85947-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108032328.85947-1-dongtai.guo@linux.dev>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 709c0956-9413-41df-53f0-08de4e7ec13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGdtaDnRNIzbdLD3CG6Bo7Gp4ALmJrb56cvh92a7Jd+IbSm9gJF0/SbVGvz0?=
 =?us-ascii?Q?fri48KL1Ci/OOM3wDOq2dBqkkgUrwTgmxDgsP6ctG0u+nesjwPc4Ve77hoJL?=
 =?us-ascii?Q?gsPXWNff6tW6syrnYmhvmZK2EPU3/dJMO3QQKLivLnkca3ZKCoHgIWem0C9/?=
 =?us-ascii?Q?irSLxQCOyDZn3nE2sRghQ0Dc0NlIjQrC8pCrRa5bDwnqoG7ruDP8F/ii/3Sv?=
 =?us-ascii?Q?C58y6lIxjrYmGkvJQEz8MwBFdRp+vtqOB+e1ApeI+SmYN7vfLTxzIYoZ9xtq?=
 =?us-ascii?Q?sYBQm4GwP33DpBHC7lvLnHxRY5bD/vv+kSLBYlT7Fd9fSZBi6eOzs0+KsSrh?=
 =?us-ascii?Q?DPSpLAiAaDrd8qQyEZpYLa0f7r3jD1QdARM4E6Jrycsq281JsMggyObIKfWJ?=
 =?us-ascii?Q?x+mQb6K5l7qseP4SCjBgL3hMDf7GCanODakoYvBebGS8BTOTCFqGhd5kIk92?=
 =?us-ascii?Q?A9C0xFGOZNP/eCS2oxd8wGEKy+HSb7kpewy/JcIKUooUOV8wMrFOcp+BpRVE?=
 =?us-ascii?Q?JbTvpSlGkYfvwx+YkzDaMU4oBWq6Idv99PF3lUykiOuXY0IH3q3W7jbn56z8?=
 =?us-ascii?Q?y5FWFu6B/PA35fylKuXrT9PA5wAJyI18L1COKtf1z912AOEsexdpekQW3AFw?=
 =?us-ascii?Q?mZNLohVRooqIKl8KjHTY8HilIBX+DGuuzlC7MEDj4REMW87BrtpRaegQWukv?=
 =?us-ascii?Q?S2gKi8d0RhoJOd39HnHHUzXkwOK8em12X3kSn+XUw8vnsYH/nciAUeIrmCn4?=
 =?us-ascii?Q?4wim0Z9Tk38vWCWc1akM/DqialIHNCkaVDIaRN6OZu47oRq5107gBw1bDxUp?=
 =?us-ascii?Q?TSkU/CiN57GeIU5e8dr8CUpvcXxN1PfLEqcRReWZLOiqO3Dt0uPyRb7ZDHHH?=
 =?us-ascii?Q?6Ip8kuVCwFnA4gTERanXra85Jf09dy0n9GGSslkUBeSjAQlQLeEpxG9TQS8C?=
 =?us-ascii?Q?RRD0IVjjtF1NlbS+dvisjyjNJkbbfj6XXFTG7fDc7fYlPmfmsOGQA7SxU+RW?=
 =?us-ascii?Q?vjb27vNExvCgG/YMP59ecJxZE1G/jCylx84JRQlBXh36Tk8wRsunstjDnIak?=
 =?us-ascii?Q?7XaaTh+/vpFSyGl1ru6ZMp3MVimdB/O5bqAl7faauxdL73V6e9otoCOovvcO?=
 =?us-ascii?Q?3NqSFLR7+OmkXAe07Ru9qrKi4HdfTgfLhdewIG79io7fcXq4Mp3Ax5CR7gja?=
 =?us-ascii?Q?xy2LRW3VncndOMs+UGZTdZPbt5NwJCpvRoVXyBLovEb1mRteqZQ0ibWB6IQG?=
 =?us-ascii?Q?sIT+kPzm4dwyWVwSgWwwPMizVAQNLU5eE7hKODoPY7DhL2jezuhzHdl6eNjC?=
 =?us-ascii?Q?RJpDNlbSHc7X1xXEK+7hKxMNyhQUPLWGDjbpSJUaOa4i3h8Pu9/j9AVN7LBh?=
 =?us-ascii?Q?5Sw5hs4l1ZE2zS+pofPDp4IjFlvRIS8SOrTlcguYfZvNaYBly2cbMTYufETX?=
 =?us-ascii?Q?yTNDpOVM9EictrvGJJJqy1qssNOhnVkR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fh2/CbXa/C96POkGtjL7Xy7c1NMn5jiSkW9Hm8LhbmESZDCskhrJznhGR2zR?=
 =?us-ascii?Q?1PCK3w3PmloG/mj4/U9uh0ygd9xUNDUh9IN3e+loCX/rtth0khs6Hyf68lAq?=
 =?us-ascii?Q?KrnYKEbnTOMNATOmBl1LG8apO7wJPjx4UngHarEaYSQVb3lT/92eBMHQ1ujf?=
 =?us-ascii?Q?hy/LhvuYgsRC9tVfTtoUMooNDRN4zftRI9kxv1SEZOB17v6OU+H7r2JAiKBC?=
 =?us-ascii?Q?t6ffAaWPsz8PWyZGqgE2RJd5E3VQxogeBjIjj0/7em1lONc0Ly2XF8VkvA/p?=
 =?us-ascii?Q?JD6jcBRq1u0irmhYKZvXIoztA3W8lbgkFzNi8m6cU78Nzg4GGZtluUR9tIx1?=
 =?us-ascii?Q?2jm3mvMuqZmBDJBtrn2XsMWSbY7rV368i/2uEZ6859P0PrxuM6d+k9ylTEvg?=
 =?us-ascii?Q?YlkxtoUEvYTidhpKjmWTxJl6yJ2N7JRlB+ErapNDT0Rirfe43hPd2QXbUVS5?=
 =?us-ascii?Q?Ps3W6jBEcg5Ez+FtpbWQ8C4gAUzZ2VKdrVlWBYyJfLugMROqFxVuyaF6hMXI?=
 =?us-ascii?Q?3kOLad9TWNjGT777gDAZieTDvWWW1CrDM9iJVZTwC0wg4dXjDyWvR4cHinNL?=
 =?us-ascii?Q?rURtpMpt9i8dQUxs42KaJb8UVG7jt+7qFNAac/7Sa711CuS/AjXi4jPDIzLb?=
 =?us-ascii?Q?tuAK5i8hbhyMGTEhLd/JnmrArSkIl8JQ9sWrn6eNmpGwX2hMVO5EsWXM69td?=
 =?us-ascii?Q?YoXtd43GuL8gbEPvDsWZmWn9AyzTkFG3vZ/O2mN0Ib+gNt+HoCoacGoSlW+j?=
 =?us-ascii?Q?kkaIkDvREctRt6DkAOJWJhn9IEBCGAlyRmkp619uYoWZ6FvmPMeZrtWgxNT5?=
 =?us-ascii?Q?C7UZOBnICjkd22qQvnNR8kAozaRdeInfEWZMMGXLnOAjmElxaFoxXc7xNfEy?=
 =?us-ascii?Q?sOueBs4OZo22bKDLg9DjMF4fxPlZNC+RgJdN5AME30r4GSmlvWsQS71JOh3s?=
 =?us-ascii?Q?Gt5/7fJcvU/7zgk5rJqSDpqCQPzSJmWDqe9oj3+tQ/uL0hE44RMdnSOtEKtZ?=
 =?us-ascii?Q?gnnXGMJOvLj+r4jzc9P4TEIgcfQktcbkWuugmGwJy+1nuhvMnd5bJGwonwBi?=
 =?us-ascii?Q?+F4KHtGehAhrqAtfI20I65hM9ofXRAfij7r85BDCzr1mCg4QnSzZgnYcEPOA?=
 =?us-ascii?Q?dk0egANfzZRMXts6azh6OZPmllJm3evOTwNx8++fSqEX8B6Hruo4oj7QZZPC?=
 =?us-ascii?Q?XOTCRb4vyzCz2/2jMyhvp5bWuja//dY7NNz7h0W7sCwnYUlmtstQNblxV5Mh?=
 =?us-ascii?Q?l1eYwoGzQ/RsS1JpBx50bplGCRTJtQQDs6pcMeAvrbns/hbaWHg3v4+dGPGs?=
 =?us-ascii?Q?PjqT1j7t4hs+PagrSZkjjDLlRueoAjcdKLyyJNdpZAIyC3yYcWuoeuGxqQNs?=
 =?us-ascii?Q?XQRSYT5D2/PP2e8K1dNhaA1Lh84+4z04d2TXzYNh90mFLo/kdCLTNNfPtp9W?=
 =?us-ascii?Q?CE3rOR3oE4Clu9U2RVZi/+dxheR7VRlGoa1RDjyAuhqRXGN0efCkH8XekX0z?=
 =?us-ascii?Q?KrF8WDMCSbtPdhXRC2YGw1cge1Dn2WyN90Wa7q/uXIcUynBW5qGzxJEezY4g?=
 =?us-ascii?Q?5paCPqYyk7pTvPOCyh0TdJPHoIenKsHsrIjQfJPdr2gqTBEKNZe4jKtfhsxT?=
 =?us-ascii?Q?OvIpJlJOWv3MKXLliUJk2y8RC8ZHCg0yAmsTUg/8IzQx4ejcm1MYmahN0m0U?=
 =?us-ascii?Q?jWM1+0vqNfPe2+tv0DBGvBclnV3j1BOG2bvLp553UL6IGjON?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c0956-9413-41df-53f0-08de4e7ec13a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 06:25:44.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j2Ox8iuFQzkdCmaWrjxA1VOYGtOgiQBZDkDRHdpKvXuyW1pXmf4BR7eKNN/qLRhIpi5tX7VbxG+NdEurDWrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110

Hi George,

On Thu, Jan 08, 2026 at 11:23:28AM +0800, George Guo wrote:
> Hi Etsal,
> Thanks for reviewing!
> 
> > While the change looks correct, is there any benefit to it?
> Yes, definitely. I found this issue while adding sched_ext support for
> LoongArch. When scx_bpf_create_dsq() failed during my development, there
> were no error messages at all, which made debugging difficult.
> 
> Specifically:
> 1. The failure was silent - no log, no error message in dmesg

Which kernel is that?

In theory you should get a clear message in dmesg. For example, if I try to
create an invalid DSQ in scx_simple I get this in dmesg:

  [690301.673313] sched_ext: BPF scheduler "simple" disabled (runtime error)
  [690301.673324] sched_ext: simple: ops.init() failed (-22)
  [690301.673327]    scx_enable.isra.0+0xc8b/0x11f0
  [690301.673343]    bpf_struct_ops_link_create+0x141/0x1b0
  [690301.673352]    __sys_bpf+0x1c0c/0x2de0
  [690301.673357]    __x64_sys_bpf+0x21/0x30
  [690301.673359]    do_syscall_64+0x81/0x820
  [690301.673368]    entry_SYSCALL_64_after_hwframe+0x76/0x7e

And in stdout:

DEBUG DUMP
================================================================================

scx_simple[364999] triggered exit kind 1024:
  runtime error (ops.init() failed (-22))

Backtrace:
  scx_enable.isra.0+0xc8b/0x11f0
  bpf_struct_ops_link_create+0x141/0x1b0
  __sys_bpf+0x1c0c/0x2de0
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0x81/0x820
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

CPU states
----------

CPU 2   : nr_run=0 flags=0x1 cpu_rel=0 ops_qseq=87907495 pnt_seq=66861592
          curr=scx_simple[364999] class=fair_sched_class

CPU 3   : nr_run=0 flags=0x1 cpu_rel=0 ops_qseq=85461608 pnt_seq=64229201
          curr=pacman[364201] class=fair_sched_class

Event counters
--------------
              SCX_EV_SELECT_CPU_FALLBACK:                0
       SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE:                0
               SCX_EV_DISPATCH_KEEP_LAST:                0
                 SCX_EV_ENQ_SKIP_EXITING:                0
      SCX_EV_ENQ_SKIP_MIGRATION_DISABLED:                0
                 SCX_EV_REFILL_SLICE_DFL:                0
                  SCX_EV_BYPASS_DURATION:                0
                  SCX_EV_BYPASS_DISPATCH:                0
                  SCX_EV_BYPASS_ACTIVATE:                0

================================================================================

EXIT: runtime error (ops.init() failed (-22))

> 2. I had to add bpf_printk() temporarily to confirm it was dsq creation failing
> 
> So the benefit is improved debuggability and faster issue diagnosis.
> 
> Thanks!
> 

Thanks,
-Andrea
