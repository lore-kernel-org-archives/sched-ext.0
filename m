Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349E2FDC3C;
	Tue, 23 Sep 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617116; cv=fail; b=O6lZzlZi2WWIBo9Y062LTcHNI5wWwl6kLWMSsjvzm1oSOyIPQpiNtXFlC3GUEVrOkE/g5SWYpThZHjxQtwt07PMDKYKSWI/ONEUuYBAg//sxZvdedhRrF2vLMIlLDdA5nQnehBThvu0PmtCZdKfJk7gk5uXx4cCxISaV4MW2F54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617116; c=relaxed/simple;
	bh=xWrK0UyH8GRjeUuTXtqZJtnOjvwYtJ/aTrk0eYe5Gco=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CqoixTtU9//R+2iB36KIr6tJ4H4jXSnedigkwYs8+AH/T7860oWqCfZTFOLR8ZJ99Scl0LSL8s7Nx8ayToBRJ545iQtcdF8pyZnBxC6BGOJfYC/rbd9X1bGOxdMkUbYmX8T+UYrT0LummK7BL4LQ7WfrPFF2cetLahrBF7GyS4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkkCMDEI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkkCMDEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758617113; x=1790153113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xWrK0UyH8GRjeUuTXtqZJtnOjvwYtJ/aTrk0eYe5Gco=;
  b=VkkCMDEIj7gaS+bjj8GPceY4uigPJ9w2kxF3ArsmlSvBVPO6fqnTBuac
   VRxpKAJfdL/KeD+mjckzQGRy8eJLZB+4yrX7/IwAC4Zp/KwjK/x9CPPIz
   j/VUUPYDFinKiZx1MFU6nD1oMKx8hStQi4I7sTq4m7JzBlYHuwc7IW/pP
   uLz/m9p0JdaLAPIbQxgTjLVe7hT8OMuv0I+MakUw5Zvbd/x8GhcbBXWjB
   WTY9Za/P1/iAfXr92PQbyFuBfEW0QGtwAKZR6YHryal3x6fIpE/W9ytKO
   Ll6Ego2UFCjQ9WSlT1dSj/4J9/MDL8qHmPTUZFz0L5xQC1odoT74LzTBW
   Q==;
X-CSE-ConnectionGUID: ZG8/TeVWQk6RH/bc2RMljA==
X-CSE-MsgGUID: UlyXd1LGRGGgTcAo7/Pc4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71513158"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="71513158"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:45:12 -0700
X-CSE-ConnectionGUID: BZ0XMr+ISeuZkjZY1iDW8w==
X-CSE-MsgGUID: 1r+FLDkRSIitH0qeqTW66w==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:45:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 01:45:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 01:45:11 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 01:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EacEVbSEKeWwBh6B92jBiMFeQuBjyirRDjCsSmY5aDx+dIKfYt55I/pO02waAsMXM0Hu8ZjHw3s481Zh8s0MgjI/GFbh7fM6crBmEjYSMKtZ7EtYsFPZVE5akR16nN/qthN9DTlM8gwkBkvLY5CuOQnUPOHDLc0UHsaCpPMtOuN7iMldyl9i/OWmDW/rEt6KUkIdHW1fND2O0+RMdE+MWglJweSVvc+lVek/24GLVFsTOhtg1yuMe0jBN7wTFn8ugoz428IbtvEyG00u0/8iY3hV+F5NLcvGizQznGsyEyEjaSAXgf1mPCYdiMmGlIo2TbBJz2tYdlWUMUNHwxgUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alt7yq2J3dKV6PsmpEflIkEcvWyQgWgZc4c03Mm8d6c=;
 b=SNobiOAR3FtOBZ+UK/4wDe7x3akEQMaEM/OCVznq+dTt9PaBhaQirITcaiuB4DhOmCbMHd7QzkmcKtS3E367IXa1HSETzYRYLRUYtnbhOP7X3i/T9+RcVH2Q60TDnSL+GaMZ1BW32lqPl7D9yoUgAMeXWZOw9YdgB8Nh693gjMJhgE6Ht2i7aM/xde6hUqJXp/kGSv1zVf1N1n9Gm+dLFdwkFyxc6Z4x3Wl71MB4L5UpW/SKbTVRjBZMr7lc5Lg7aJPUzS6hL8txRfJhSt2yyVwnWqvgI4WZjAL2NAhuwn/7d7fQmgzuf/BUX+4JPk3ijF1SLMS89g3sNc0BB1TC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:45:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:45:07 +0000
Date: Tue, 23 Sep 2025 16:44:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [peterz-queue:sched/cleanup] [sched]  13ea439400:
 WARNING:at_kernel/sched/deadline.c:#task_contending
Message-ID: <202509231601.ffbd7efd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbbfb35-9c2d-4e37-83de-08ddfa7d7f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nd0ZvGikM+QWlrHB0I1igh5Mqs4qTsuwH5qnji8oGvGjneWM4uGi+wes72Tk?=
 =?us-ascii?Q?QrnUF+KlbwFtHBUE0Fjn+RtTFp5lxKuQaTraHeM1SSm5pBMEWfgXlDTXj6OZ?=
 =?us-ascii?Q?NicSsjd2owBTQz3fDNuy9/Vn8QdtRtqkhSccpTopAuUNrC24+Gh1UHN/Myio?=
 =?us-ascii?Q?RP62rAIt4B+pmFdLlRDtOBb/cWHpnfXvbdNcKE16xHhuYXyBIyPxnQPuw8dU?=
 =?us-ascii?Q?ksjxFTS+uoCCMhZQtAGFRc02m32SZTeko1HpYifGtLS0tnor7C/HxsksloL4?=
 =?us-ascii?Q?bQNFYj+U+sZbqcdmuE+wgImQ0oeXZIVc7qYPxp1gopjALd6rZKxjQ4gdmQwC?=
 =?us-ascii?Q?fyTYHV58zk5MnB/lvOzH0mrfJX8CLTIGELvJcnJWxSZHdCS5iCaev+e9chfq?=
 =?us-ascii?Q?flbnZPXgU3i7E2HIs17CniB7bwPouxMNG4GwnP/O38s5C8VRvS5jMXoEE7aN?=
 =?us-ascii?Q?NaCXB16OKtHGDeagsHMmcAwbzv5tFFlrkj5B8eHvpKsZi/lnUxC/8DaqzWd/?=
 =?us-ascii?Q?KeeZqO3h2QDTbgsQbURSPGJVen0qZuufkPHZ09ofgDDAEMlEFXyFxsYZUhp7?=
 =?us-ascii?Q?yTSX/XCX0op2b7c7qpUeSN/+t5p9VeCO0+0MBdpZXoE6dGGAOzKVJrxU9Tp5?=
 =?us-ascii?Q?tJBDC6cNdXaYcUt6tpnNm1vLTwGl09QzGVaijPyy2OlEaHEBvubHt0HfPaQp?=
 =?us-ascii?Q?/YpiGbCkF3TVcAM1pAFwZIp1ciJ/tQe8fsc1pIXOfe4/0shkGlgeujvMWTF9?=
 =?us-ascii?Q?xlVNcgUrZYv3qWoK3NncB7flhcuRteoiSqhfb1s20zP/p0gTuuasnbCFudL4?=
 =?us-ascii?Q?7dJsEWJkVA2gewwZqo+bFsLUYVElEYzRwpUxajPbRfjKCHjbczVWviR6rzJQ?=
 =?us-ascii?Q?wv8U/LbhZmIxrWMBYrHS+bmZc5JByBkiYpAvP3tJUX0545mtM56OX+16ECnK?=
 =?us-ascii?Q?Hp+wcP9QOPa5eTryzQJrG1Aa1DkKzi1oO8HFPEMwI9t+8MfDF2mk4SlALq/6?=
 =?us-ascii?Q?rTRPpsuMF7kHQSvEbGXaYEzu23b/XsmjZFN4H/iZLm09e9NN2ArcKLnsI3Or?=
 =?us-ascii?Q?bVD9oem7ks4qsPSIhiVcSdz9k0xlNDCjR+Pl6swoynQAfo/q5Fh0cIvWb9Zd?=
 =?us-ascii?Q?N7T3eLvLsaRqpaRP5DQUO4ul6qPXRKe1Ydg9osZKb8Qi+GLHc0+zffNHF+HY?=
 =?us-ascii?Q?TgJngfnC5QUI7bpnVYdo92ZU8mRb7Se693I8TglzSSsHjpXaxAJiSb69tRWY?=
 =?us-ascii?Q?vdVUfc+dNrey7voI2WuDXugl+fNN6dnZaKUUPD1+JT7Y9olgnAy7vR71c8CI?=
 =?us-ascii?Q?DWgK5zldi5cxUx+nbLMyb/pSgL4zv6rnj6hYVOZQXgDoP+V4IS0K9+UG0RNI?=
 =?us-ascii?Q?7L4iGbM04jVAtBt83k6+66i9NNEz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5OwQmIOcyQF8e5/mHnl2Be26xoGO9/nhbCMoiUcTyYnq/gCowmua/VCxIgUQ?=
 =?us-ascii?Q?3IKnjXMlQYgERD2c8jJYd3Ma9OtPWuGtmuy4lawd97kj8dMjK5A5KOXDpru4?=
 =?us-ascii?Q?pMD6lpwMDG6zVnkPiGC0j2fVEq5ke8YXoyPJso/ASVozFD2suU9VgFU7bmnI?=
 =?us-ascii?Q?kyqC+LwqT/aVF1f1A2L3q8mbSmGluCEqZ8MBt1tZuCjZvAy7YObBpZqhsJ6K?=
 =?us-ascii?Q?1h7y4p/Cbzdubgx66SjOGmaY0eFJ5PpsKorhHu6E8+RPeklhs4euodO4iDDn?=
 =?us-ascii?Q?PwOdloESIsxuhXcwh+roFZ5FYpbB5hkuO0NTryy3klsvmwEylDaJpX9taPmH?=
 =?us-ascii?Q?M2kZQCmttTE7Inql7AEnfF6lh4aVGCFshKS4VbNuQYZ6HaUFGuKmljtVJdx1?=
 =?us-ascii?Q?C6L/UmL/7SO1sOSegNAlosGWalamTVyK9NJP5fewWEc/GQWsIXp6b2xzTjFM?=
 =?us-ascii?Q?UEItQRcotejESJYfADhBMZ5JYj7sBvUJcMu4N1lIscgvDqTkuoLPgtJ+bM8t?=
 =?us-ascii?Q?oxgTobjxHtage24f4f4YtH+jgjQAd5R2tPjAdwRhf2mxnIHZPcVuht3Ydszc?=
 =?us-ascii?Q?W9hcjEnyM2LlzvQyksqk6Q8SgHx3v/tf6CDmaG5DJXOJC5uN+86CODH+DsmT?=
 =?us-ascii?Q?OfvlcYrYT2dgFdrkuETeEuwWankMrKNZ2WRN/7IRbDw0A04N0HIftc90YGWJ?=
 =?us-ascii?Q?JT/SNDXrQmyayTaGHSZub528cWyZbmQRMAv6D2QgZbHohgk6hPrWemgExREg?=
 =?us-ascii?Q?cby9E/zHhCXPx5Mr7SkXwVhlVPKMPSn0F1LkeKidCzOg01+t89995RMnMyNv?=
 =?us-ascii?Q?0AlTn+wV8Kh9y79z1EYTeWFFZMUaFG1Dy9PrQBehCbpkfubheCri0bFFDt4z?=
 =?us-ascii?Q?K76UNPEWpt6dhjRhV8IYCtv8G8v82G/eioYrhv6Czwr8yBt6vhET5uauaeFX?=
 =?us-ascii?Q?l/PZEMVni+ETM0jZTxamE+LZwhdHKPgIP9JmZbdCR5bL6KG29ePZk5IzsWV+?=
 =?us-ascii?Q?rJPMnAWe5tj1/dxV6/Ey1TPuTToJ7eDmBCkTLirl2GVVoxeKRjeIu8/cJJgK?=
 =?us-ascii?Q?CiGLttOVJgQtBaLXUdM9w6JCcOTBeOTdBzf3jqfnqbYXEMd3gJYoUD8lIf23?=
 =?us-ascii?Q?r5nkIj1Z7SKRe3DwUppbou9PKmudBS7CCxe7QhdBe3r5JkXBmHhqEP8fGMIi?=
 =?us-ascii?Q?1ziCVY8dmZSIFZZEC7mfVIpDHBYdETSD34xK4KxacRtQfLtve/vqsbgqSOJ8?=
 =?us-ascii?Q?dl4UmzuLH7sBF7DCQ5Benel5nohG7+qvHwdgMuqDrbW5IQTGziDVIhaGCagl?=
 =?us-ascii?Q?RJL12miJ7JXvAlYbIb9Rh9zbMVwdbxRVh3FWkKf0ioBH7ykJ7JtJnrXekgF1?=
 =?us-ascii?Q?5teXKob82WS9qbnmlliss+9dT9j122RgpDNnaDVlfUKbH3lnk7b7ba8Y6k6U?=
 =?us-ascii?Q?uPzZjsHriG40j7VcwpRqVOu4n3a5cNcLvAI1fQq/rqHyEKsa8OiDPrNUx0Yh?=
 =?us-ascii?Q?ualQk5ypOUoQ4ondbz2E8vr9Mr+i+q3DBGub0YyvUJ6UbB8kstlItSZmp91w?=
 =?us-ascii?Q?Bi4teKHCmSVuOGeYuYS8XTVcksaiex2v+psg+TyXfEdjK+Zn9WlWCoTJWQfz?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbbfb35-9c2d-4e37-83de-08ddfa7d7f78
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:45:07.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK9db6YffpznVPf+eEJeZiZter/Q6soFrpwiGp/MOgJMkQYTxopwQmSb6svMhoiPx1uyom/6k9w/u46wH+ArNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/deadline.c:#task_contending" on:

commit: 13ea43940095719bc22d2e129712519fdc307c45 ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/cleanup

in testcase: stress-ng
version: stress-ng-x86_64-480b81369-1_20250919
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: cyclic
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509231601.ffbd7efd-lkp@intel.com


we also observed various issues on this commit while parent is quite clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/testtime/test/cpufreq_governor:
  lkp-spr-2sp1/stress-ng/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4/gcc-14/100%/60s/cyclic/performance

f0b336327a1be3b1 13ea43940095719bc22d2e12971
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10          20%           2:10    dmesg.BUG:soft_lockup-CPU##stuck_for#s![diskstats:#]
           :10          10%           1:10    dmesg.BUG:soft_lockup-CPU##stuck_for#s![numa-vmstat:#]
           :10          10%           1:10    dmesg.BUG:soft_lockup-CPU##stuck_for#s![slabinfo:#]
           :10          40%           4:10    dmesg.BUG:soft_lockup-CPU##stuck_for#s![stress-ng-cycli:#]
           :10          20%           2:10    dmesg.BUG:soft_lockup-CPU##stuck_for#s![systemd-journal:#]
           :10          10%           1:10    dmesg.BUG:workqueue_lockup-pool
           :10          10%           1:10    dmesg.INFO:rcu_sched_detected_stalls_on_CPUs/tasks
           :10          10%           1:10    dmesg.INFO:task_blocked_for_more_than#seconds
           :10          90%           9:10    dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
           :10          10%           1:10    dmesg.RIP:__get_user_8
           :10          50%           5:10    dmesg.RIP:__sched_setscheduler
           :10          10%           1:10    dmesg.RIP:__schedule
           :10          10%           1:10    dmesg.RIP:__x64_sys_clock_nanosleep
           :10          10%           1:10    dmesg.RIP:calculate_sigpending
           :10          10%           1:10    dmesg.RIP:count_memcg_events
           :10          60%           6:10    dmesg.RIP:cpuidle_enter_state
           :10          90%           9:10    dmesg.RIP:dequeue_task_dl
           :10          10%           1:10    dmesg.RIP:do_nanosleep
           :10          10%           1:10    dmesg.RIP:do_user_addr_fault
           :10          50%           5:10    dmesg.RIP:enqueue_dl_entity
           :10          80%           8:10    dmesg.RIP:finish_task_switch
           :10          10%           1:10    dmesg.RIP:folio_add_file_rmap_ptes
           :10          70%           7:10    dmesg.RIP:inactive_task_timer
           :10          90%           9:10    dmesg.RIP:migrate_task_rq_dl
           :10          10%           1:10    dmesg.RIP:native_queued_spin_lock_slowpath
           :10          20%           2:10    dmesg.RIP:next_uptodate_folio
           :10          90%           9:10    dmesg.RIP:smp_call_function_many_cond
           :10          90%           9:10    dmesg.RIP:task_contending
           :10          80%           8:10    dmesg.RIP:task_non_contending
           :10          10%           1:10    dmesg.RIP:x64_sys_call
           :10          90%           9:10    dmesg.WARNING:at_kernel/sched/deadline.c:#dequeue_task_dl
           :10          50%           5:10    dmesg.WARNING:at_kernel/sched/deadline.c:#enqueue_dl_entity
           :10          70%           7:10    dmesg.WARNING:at_kernel/sched/deadline.c:#inactive_task_timer
           :10          90%           9:10    dmesg.WARNING:at_kernel/sched/deadline.c:#migrate_task_rq_dl
           :10          90%           9:10    dmesg.WARNING:at_kernel/sched/deadline.c:#task_contending
           :10          80%           8:10    dmesg.WARNING:at_kernel/sched/deadline.c:#task_non_contending




[   41.677103][  C194] ------------[ cut here ]------------
[   41.295461][    C1] Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1
[   41.677280][  C147] ------------[ cut here ]------------
[   41.673528][    T0] Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1
[   41.677090][T10156] Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1
[ 41.677282][ C147] WARNING: CPU: 147 PID: 0 at kernel/sched/deadline.c:227 task_contending (kernel/sched/deadline.c:227 kernel/sched/deadline.c:287 kernel/sched/deadline.c:504) 
[   41.677096][T10156] sched: DL replenish lagged too much
[   41.677288][  C147] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel btrfs blake2b_generic kvm xor dax_hmem snd_pcm raid6_pq irqbypass cxl_acpi ast snd_timer ghash_clmulni_intel cxl_port binfmt_misc pmt_telemetry rapl pmt_discovery drm_client_lib intel_th_gth intel_cstate snd isst_if_mmio iaa_crypto ipmi_ssif qat_4xxx nvme isst_if_mbox_pci intel_sdsi pmt_class cxl_core drm_shmem_helper mei_me intel_th_pci i2c_i801 soundcore idxd intel_qat intel_uncore einj pcspkr isst_if_common nvme_core cdc_ether i2c_ismt intel_th mei i2c_smbus intel_vsec idxd_bus acpi_power_meter wmi drm_kms_helper crc8 ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad pinctrl_emmitsburg pfr_update pfr_telemetry drm fuse nfnetlink
[   41.677103][  C194] ------------[ cut here ]------------
[   41.677338][  C147] CPU: 147 UID: 0 PID: 0 Comm: swapper/147 Tainted: G S                  6.17.0-rc4-00012-g13ea43940095 #1 VOLUNTARY
for Remote File[   29.908797][ T2053] EDAC MC5: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 IMC#1: DEV 0000:fe:0d.0 (INTERRUPT)
[   41.677280][  C147] ------------[ cut here ]------------
[   41.677341][  C147] Tainted: [S]=CPU_OUT_OF_SPEC
[ 41.677282][ C147] WARNING: CPU: 147 PID: 0 at kernel/sched/deadline.c:227 task_contending (kernel/sched/deadline.c:227 kernel/sched/deadline.c:287 kernel/sched/deadline.c:504) 
[   41.677342][  C147] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
[ 41.677344][ C147] RIP: 0010:task_contending (kernel/sched/deadline.c:227 kernel/sched/deadline.c:287 kernel/sched/deadline.c:504) 
[   41.677288][  C147] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel btrfs blake2b_generic kvm xor dax_hmem snd_pcm raid6_pq irqbypass cxl_acpi ast snd_timer ghash_clmulni_intel cxl_port binfmt_misc pmt_telemetry rapl pmt_discovery drm_client_lib intel_th_gth intel_cstate snd isst_if_mmio iaa_crypto ipmi_ssif qat_4xxx nvme isst_if_mbox_pci intel_sdsi pmt_class cxl_core drm_shmem_helper mei_me intel_th_pci i2c_i801 soundcore idxd intel_qat intel_uncore einj pcspkr isst_if_common nvme_core cdc_ether i2c_ismt intel_th mei i2c_smbus intel_vsec idxd_bus acpi_power_meter wmi drm_kms_helper crc8 ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad pinctrl_emmitsburg pfr_update pfr_telemetry drm fuse nfnetlink
[   29.924285][ T2053] EDAC MC6: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 IMC#2: DEV 0000:fe:0e.0 (INTERRUPT)
[ 41.677347][ C147] Code: 78 fe ff ff 83 f8 01 74 28 85 c0 7f bd be 03 00 00 00 5b e9 a7 de 64 00 0f 0b eb 88 0f 0b e9 23 ff ff ff 0f 0b e9 43 ff ff ff <0f> 0b e9 49 ff ff ff 48 c7 c6 50 e4 34 81 48 8d bb a8 12 00 00 5b
All code
========
   0:	78 fe                	js     0x0
   2:	ff                   	(bad)
   3:	ff 83 f8 01 74 28    	incl   0x287401f8(%rbx)
   9:	85 c0                	test   %eax,%eax
   b:	7f bd                	jg     0xffffffffffffffca
   d:	be 03 00 00 00       	mov    $0x3,%esi
  12:	5b                   	pop    %rbx
  13:	e9 a7 de 64 00       	jmp    0x64debf
  18:	0f 0b                	ud2
  1a:	eb 88                	jmp    0xffffffffffffffa4
  1c:	0f 0b                	ud2
  1e:	e9 23 ff ff ff       	jmp    0xffffffffffffff46
  23:	0f 0b                	ud2
  25:	e9 43 ff ff ff       	jmp    0xffffffffffffff6d
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 49 ff ff ff       	jmp    0xffffffffffffff7a
  31:	48 c7 c6 50 e4 34 81 	mov    $0xffffffff8134e450,%rsi
  38:	48 8d bb a8 12 00 00 	lea    0x12a8(%rbx),%rdi
  3f:	5b                   	pop    %rbx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 49 ff ff ff       	jmp    0xffffffffffffff50
   7:	48 c7 c6 50 e4 34 81 	mov    $0xffffffff8134e450,%rsi
   e:	48 8d bb a8 12 00 00 	lea    0x12a8(%rbx),%rdi
  15:	5b                   	pop    %rbx
[   41.677338][  C147] CPU: 147 UID: 0 PID: 0 Comm: swapper/147 Tainted: G S                  6.17.0-rc4-00012-g13ea43940095 #1 VOLUNTARY
[   41.677350][  C147] RSP: 0018:ffa000000eec4e00 EFLAGS: 00010087
[   41.677341][  C147] Tainted: [S]=CPU_OUT_OF_SPEC
[   41.677353][  C147] RAX: ff11001fe02f1140 RBX: ff110040477d42b0 RCX: 0000000000000093
0m] Reached targ[   29.954811][ T2053] EDAC i10nm: v0.0.6
[   41.677354][  C147] RDX: 00000000000e6666 RSI: 0000000000000000 RDI: ff110040477d42b0
[   41.677342][  C147] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
[ 41.677344][ C147] RIP: 0010:task_contending (kernel/sched/deadline.c:227 kernel/sched/deadline.c:287 kernel/sched/deadline.c:504) 
[   41.677355][  C147] RBP: 0000000000100009 R08: 0000000000017701 R09: 0000000000000093
Startin[   29.979254][   T20] intel_rapl_common: Found RAPL domain package
[ 41.677347][ C147] Code: 78 fe ff ff 83 f8 01 74 28 85 c0 7f bd be 03 00 00 00 5b e9 a7 de 64 00 0f 0b eb 88 0f 0b e9 23 ff ff ff 0f 0b e9 43 ff ff ff <0f> 0b e9 49 ff ff ff 48 c7 c6 50 e4 34 81 48 8d bb a8 12 00 00 5b
All code
========
   0:	78 fe                	js     0x0
   2:	ff                   	(bad)
   3:	ff 83 f8 01 74 28    	incl   0x287401f8(%rbx)
   9:	85 c0                	test   %eax,%eax
   b:	7f bd                	jg     0xffffffffffffffca
   d:	be 03 00 00 00       	mov    $0x3,%esi
  12:	5b                   	pop    %rbx
  13:	e9 a7 de 64 00       	jmp    0x64debf
  18:	0f 0b                	ud2
  1a:	eb 88                	jmp    0xffffffffffffffa4
  1c:	0f 0b                	ud2
  1e:	e9 23 ff ff ff       	jmp    0xffffffffffffff46
  23:	0f 0b                	ud2
  25:	e9 43 ff ff ff       	jmp    0xffffffffffffff6d
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 49 ff ff ff       	jmp    0xffffffffffffff7a
  31:	48 c7 c6 50 e4 34 81 	mov    $0xffffffff8134e450,%rsi
  38:	48 8d bb a8 12 00 00 	lea    0x12a8(%rbx),%rdi
  3f:	5b                   	pop    %rbx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 49 ff ff ff       	jmp    0xffffffffffffff50
   7:	48 c7 c6 50 e4 34 81 	mov    $0xffffffff8134e450,%rsi
   e:	48 8d bb a8 12 00 00 	lea    0x12a8(%rbx),%rdi
  15:	5b                   	pop    %rbx
[   41.677357][  C147] R10: 0000000000000000 R11: ffa000000eec4ff8 R12: 0000000000000001
[   41.677358][  C147] R13: ff110040477d42b0 R14: 0000000000000088 R15: ffa000000eec4ed0
[   41.677350][  C147] RSP: 0018:ffa000000eec4e00 EFLAGS: 00010087
[   41.677359][  C147] FS:  0000000000000000(0000) GS:ff1100205c4a2000(0000) knlGS:0000000000000000
[   41.677353][  C147] RAX: ff11001fe02f1140 RBX: ff110040477d42b0 RCX: 0000000000000093
[   41.677361][  C147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.677354][  C147] RDX: 00000000000e6666 RSI: 0000000000000000 RDI: ff110040477d42b0
[   30.004528][  T354] intel_rapl_common: Found RAPL domain package
[   41.677355][  C147] RBP: 0000000000100009 R08: 0000000000017701 R09: 0000000000000093
[   41.677362][  C147] CR2: 00007f7ff20b8620 CR3: 00000020a4f97003 CR4: 0000000000f73ef0
[   30.020455][  T354] intel_rapl_common: Found RAPL domain dram
[   41.677357][  C147] R10: 0000000000000000 R11: ffa000000eec4ff8 R12: 0000000000000001
[   41.677364][  C147] PKRU: 55555554
[   41.677358][  C147] R13: ff110040477d42b0 R14: 0000000000000088 R15: ffa000000eec4ed0
[   41.677365][  C147] Call Trace:
[   41.677359][  C147] FS:  0000000000000000(0000) GS:ff1100205c4a2000(0000) knlGS:0000000000000000
[   41.677367][  C147]  <IRQ>
[ 41.677370][ C147] enqueue_dl_entity (kernel/sched/deadline.c:62 kernel/sched/deadline.c:80 kernel/sched/deadline.c:1036 kernel/sched/deadline.c:2022) 
[   41.677361][  C147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
LKP: ttyS0: 2334: current_version: 90000c0, target_version: 90000c0
[   41.677362][  C147] CR2: 00007f7ff20b8620 CR3: 00000020a4f97003 CR4: 0000000000f73ef0
[ 41.677373][ C147] enqueue_task_dl (kernel/sched/deadline.c:62 kernel/sched/deadline.c:2127) 
[   41.677364][  C147] PKRU: 55555554
[ 41.677376][ C147] enqueue_task (kernel/sched/core.c:2090) 
[   41.677365][  C147] Call Trace:
[ 41.677378][ C147] ttwu_do_activate (kernel/sched/core.c:3717) 
LKP: ttyS0: 2334: skip deploy intel ucode as ucode is same
LKP: ttyS0: 2334: Kernel tests: Boot OK!
[   41.677367][  C147]  <IRQ>
[ 41.677381][ C147] try_to_wake_up (kernel/sched/sched.h:1864 kernel/sched/core.c:3980 kernel/sched/core.c:4303) 
[ 41.677370][ C147] enqueue_dl_entity (kernel/sched/deadline.c:62 kernel/sched/deadline.c:80 kernel/sched/deadline.c:1036 kernel/sched/deadline.c:2022) 
[ 41.677384][ C147] ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1990) 
LKP: ttyS0: 2334: HOSTNAME lkp-spr-2sp1, MAC a4:bf:01:91:28:12, kernel 6.17.0-rc4-00012-g13ea43940095 1
[ 41.677373][ C147] enqueue_task_dl (kernel/sched/deadline.c:62 kernel/sched/deadline.c:2127) 
[ 41.677388][ C147] hrtimer_wakeup (kernel/time/hrtimer.c:2000) 
[ 41.677390][ C147] __hrtimer_run_queues (kernel/time/hrtimer.c:1761 kernel/time/hrtimer.c:1825) 
[ 41.677376][ C147] enqueue_task (kernel/sched/core.c:2090) 
[ 41.677393][ C147] hrtimer_interrupt (kernel/time/hrtimer.c:1890) 
[ 41.677378][ C147] ttwu_do_activate (kernel/sched/core.c:3717) 
[ 41.677381][ C147] try_to_wake_up (kernel/sched/sched.h:1864 kernel/sched/core.c:3980 kernel/sched/core.c:4303) 
[ 41.677395][ C147] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1039 arch/x86/kernel/apic/apic.c:1056) 
[ 41.677384][ C147] ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1990) 
[ 41.677400][ C147] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 (discriminator 35) arch/x86/kernel/apic/apic.c:1050 (discriminator 35)) 
[   41.677402][  C147]  </IRQ>
[ 41.677388][ C147] hrtimer_wakeup (kernel/time/hrtimer.c:2000) 
[   36.334175][ T2362] is_virt=false
[   41.677403][  C147]  <TASK>
[ 41.677390][ C147] __hrtimer_run_queues (kernel/time/hrtimer.c:1761 kernel/time/hrtimer.c:1825) 
[ 41.677405][ C147] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[   36.334178][ T2362]
[ 41.677393][ C147] hrtimer_interrupt (kernel/time/hrtimer.c:1890) 
[ 41.677408][ C147] RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:292) 
[ 41.677395][ C147] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1039 arch/x86/kernel/apic/apic.c:1056) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250923/202509231601.ffbd7efd-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

