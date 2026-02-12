Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6A2C11FA;
	Thu, 12 Feb 2026 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905300; cv=fail; b=jXy6DZT90kDoBTGdYpQkWnmigjADuU1Y4LP0/Uewcdgx8no8Rzx8+hRaXn3Ktw6GUu8hfQ0bITN54fEf6r1EwaEHFBwKwijP1ohC05lcFJYXAv36Pv8ikN7HzcxB7toLSUk8rLvrUq8puUp5I0vvSSmBb/vsO0ht5enMx+G7zHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905300; c=relaxed/simple;
	bh=8aJw5ZotH6t03PQfWBn4DdNBypgLurhpKuwayNtUNWs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=q4dUyTuQsJx6o5X1FxCULOlz+F6keBRFhCUikCdJp692GO6gvW9ubZIOfxI7WXMg/t/1CT7G+jlLnMAtLJwRepGTcz/nOK63nbzinAwQCNLa2Wui2wMKcttpbiaxu4caJcESDn6vAV9ZhR3kLH/n7N8cNNFISsn+RLT0eXkLvco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fq47QOHy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq47QOHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770905299; x=1802441299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8aJw5ZotH6t03PQfWBn4DdNBypgLurhpKuwayNtUNWs=;
  b=fq47QOHyXj+PwyLSuCD58UNFZQS8QgxBI5rpEwZDmkEQSROqEbzR/JM+
   +QFC+jE1hzo0I+/ho0YGIPUTsx+hDbYQlsG76tJKkWc5x99E0K8tzoirt
   jeiBFsmAMuK2y75pSiSF2KZcHZwW83EuZzp5koV1pLGPDU9wHYzd6hngY
   4+D3EtDX9YMMU4MDb8CJ4ulyjNK+Y4ZqWSMcN3mj5bRhG55a9lMRKm7L/
   R7bayvYZ+XcKe4142iMR+uCr8iKHAxWLZ+6RJTZngfj2xLbg7Sba0XN61
   1ynOdOGLPQC6dHhvO9fS9pAE7vQgqIyURywFfD0DO6vA9d/aGMqBKf429
   Q==;
X-CSE-ConnectionGUID: sFZBHI/sTKOW3txjGPvwGQ==
X-CSE-MsgGUID: 9DGEGYT4TD2L3HT49OX+JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71277720"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71277720"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:08:18 -0800
X-CSE-ConnectionGUID: z2mzKqreTHKp6oDJfSPmRQ==
X-CSE-MsgGUID: FDnOEJAjTL2+J/KgNqWFWw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:08:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:08:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 06:08:17 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:08:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpbP17rbk6pvVSpWgihq/1uzKRUrsuDzctu3bupOrgF3NhYu0xLjApwfo+pzRCkgCQn1/PlygynEYLp+lJCSP/3z028UeI5osCPtt6uTdM9O9UQzdfwmKeZcHIfOTEbr/+8iebXhgbPhcys5l/biTWawWnK3o55e/B+2TpkF0PqNpqufhRiIHGsnd8LwxBFKTuGGxQticIDm0d/UeeTse4rK4LgPH2zr1DCuM0JFSVzjlYe+ahTUTlSmiHsTQuHeGgEeMvonwpk1rgyJaRdTXu1LEoSvNNNkcHuv144jYOLVO48POLqit9jG0NNRzmIcGXKQaPlPHzv1sjKK4m0GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN1r0MXV6uVduN/u8GM0C9qseXbQ5CS4YnlEmr+FfVA=;
 b=TK/7nzhxeVtA7D4emNDUOEIJNRxXdBus6fPmyuiZtdecJxwnEq2jMgXOQo0eEl7+sa3V0DViJHAJUx2yUbZrpjlJyXJidLLVeREVGmbQki8r4KhLC4HJ3rYrFaAWT1nGPO8LCjWtzCZ+j6KvsOlFgO9JCGrjNmwp1Qith6bdzAh5CMjWYcR5R3BfDzN4VwgepbVRUloSJIIT9/hXszDHnHcN8XR9O0C/3mur+sGx36PneNKiaokw3e4MCV+MZ0YhNfYQrYrzeiVt9Z4pHkB1hCjM3rWhn0U0Byns5Gwyj8N1ky9dMtF2K/xAJKy4DM5MVQ10Zwej+6FHtpgMxgTDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 14:08:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 14:08:13 +0000
Date: Thu, 12 Feb 2026 22:08:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, <sched-ext@lists.linux.dev>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/core]  704069649b:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <202602122157.4e861298-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd6d8e7-10ef-43e6-d207-08de6a402951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DjcnAhXqyQCIQmVj0ArQ6EtCZTULbH+TqLqAkCqzm4ggPyp5PNTc9LzsIeuo?=
 =?us-ascii?Q?YOFDrfJzD0tnNdQxZHKWozKirLm2o4IjcjhU1X372B9AzpDI+gxL0tN8q3i+?=
 =?us-ascii?Q?lZ85C2dpLVZznOIsnKt0dZg10EnjccMA3HxgSCyxLaYLkoaML/J6LGtH9MQv?=
 =?us-ascii?Q?TBJ9VqdBHjyhCr4k6TXsAaEgJZj6l4MPiIzdMGmM+LG3QB3DiMJsD94GdX+d?=
 =?us-ascii?Q?HfbqaZsUfJU0+1bxbKWEflFvB1M2GzphFoYLxHxyvSE/EFmrF1aa8Scll6Sb?=
 =?us-ascii?Q?NjkN3yVXx7LSCQadsXczZFB263No+khMrYjKh+xIfPDSMVEyXTuWFKBFnmKi?=
 =?us-ascii?Q?2YEd9Iy9rObwEqlqtqj9JL8yrzZk46SxuyNnFzl+1axa5aftiftM/gOj2rHS?=
 =?us-ascii?Q?i6JQiPgYtA4Qw7DnPwJ/nsP0aUTMiBhpDfJ8WG6vbf6lzSPGJJodb5aqWmPh?=
 =?us-ascii?Q?Badu1lZuOL1xbGs+PavTI1VpG3c1g8cQZZlv4Q1p9W8OIT+6TWC3dOSC5co6?=
 =?us-ascii?Q?4wm5pQDI/oJ+rSDfOiycp1rMcmjeBXd0ejow1SgelMANGlJuRJqeQyAOMkW7?=
 =?us-ascii?Q?JH+xBab0d3zbJwjo9jfK0dXtqTgwynnWp9X24JRVqBsjsbOUf/p4rffJ0ufZ?=
 =?us-ascii?Q?Uy3dfGh+sgN0LPfnGdftrCmf4vCLRatF5kqVRbq7Gjyhafj3neL1xVJmRxAY?=
 =?us-ascii?Q?znk2yKQ8AU2ycdUFh/i7vIT2yvzAmPP0vi/uvhV2Tu68WLeg2HYcvtVC/sYF?=
 =?us-ascii?Q?xKRNh4NAkJxNDLCZLtOh787UpM1OMn7OTjLjFpg8o2P+qIR2usxeqRTemlwz?=
 =?us-ascii?Q?MAsFbfxQxuQcaT6arPSq1NhQ5EI0w8YX0L0JoNeqwl7+C+ShskkdsNzaPuAC?=
 =?us-ascii?Q?SLT5OnyHJkdF5mV42BKaC3i6A/9OhfMZrgoH/7UBMK9zAVfULYmA6VQy/jLe?=
 =?us-ascii?Q?xQQ+e98Mi5nZWvHgLARqq9UlEqIOCzgGCGhL/XDk+WVxl8bO27HF/PSUn6NH?=
 =?us-ascii?Q?51X0S/FzjFKI9sGXRDE4ZEPtRQ805mx9QbOv5+vIJnxgr0aOjIMi5EHiHI28?=
 =?us-ascii?Q?/Q7YJKHKQtBwRJfnt9KaPsQwvjkY1pSQmh+B8g7rUjFn0oiogrya8K7DGkEJ?=
 =?us-ascii?Q?dfL/c8RYTCoIW5h3xzbiFDjKI3mlHpwqSIsKPT0W+uy6JuWDaXgTKOO5nTBp?=
 =?us-ascii?Q?XZiNeddiBEet7MUcyyg/n0lsdgoDTU6dk7ZyCFAi5/K3URFJMF/gpeoMbzYn?=
 =?us-ascii?Q?a1YDzxPR6382Lcwyhfxc93kwS4vD41DbW9xG9jT89LVymPJpqzm0+vp6RBTx?=
 =?us-ascii?Q?Pfp7cP0KSbYn02z2sUwUk0hy+Aic+pLtnoT7OZI3XtshelrGp2mNw1dPX2Af?=
 =?us-ascii?Q?c+Eqi831wMjl0UGLFhH74gOyw1xzcZzJJbepOd5hQbX8z8iZ/AR/Pt+j/7oK?=
 =?us-ascii?Q?Z9UASqztzFcTtnCsBo6lTTa4d+Ugp5oWuaUW7o4rrNBqFkk0t4R1MPgyRZWS?=
 =?us-ascii?Q?r1Y++J3SnXwKB1zAwggxeMI5r4gY5gepy5M9PYa8u25Zv5zhFsKC3FS5hzUb?=
 =?us-ascii?Q?E7xJmRsfIt4y9M86os9v48ls5Dzq9Wwf8Tr7UKO8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EMh5oiSH2ZL/vyMSYcwJol3RNxVcGtiGK35Q9qF2ZJYL0fkL9hLVHrKHwh67?=
 =?us-ascii?Q?CbIsNIxvAjTsUWE+JuyC1T+WYEb0qEri3PrbmiSTyUFnU1UynpkaA6I/sJfk?=
 =?us-ascii?Q?2oBCNch+DYBmTJiYNrEMwHETFszgAZQHqBUbP3crhSPn/soNF1nKwG19PHzh?=
 =?us-ascii?Q?vqqqr1wtXYqm8fc60TAhKaTP2ezN4+k2OQmQVTTReFfBLrhnkofMWXi+NYOh?=
 =?us-ascii?Q?hJvScrO0A2IUuQ70yWs0zN4fgEkfst+9pvninB2jCjJtyZFOt7pxnsFJcvDS?=
 =?us-ascii?Q?GJN+ZTM7qE3Js0PM+Hmrf3alY0BC6RRV7Qs+Csz9yUxlRVNc+p8tZj9Or7lt?=
 =?us-ascii?Q?F+TUr8HfJSjPfvAlX2+zKSIKrY3XtlGWEnuOQzKigrNV5Qau8OScfEs5tJ0T?=
 =?us-ascii?Q?Tccl+SeTqyuJfYx5XDRDlWVKa1ZbW6Zb9raHq4TfIyeew04/5oU1E0/DnP5A?=
 =?us-ascii?Q?cGgEU2XsY8owh189Dxl2KJZyXHuutAjEwE1JsLxMhhHK1wpMUpavfonqsPlS?=
 =?us-ascii?Q?OpQCpAO7OR9kVAyKbqDyHtxzBy5XzfiNPTjkNLGGJVGpHRO8syIjl4cxkcWT?=
 =?us-ascii?Q?nfhh05XcEU/g13cDiJUr0Aq+GShsIjPj+5kLtQ/XgJwlhJ345h6GRCURluao?=
 =?us-ascii?Q?uqqany92Ox8pSvmNtcf3VBVQMA9BYJp1tgmHi3dTwMcxpGPh8AkODaMEuSo9?=
 =?us-ascii?Q?eoHxQIle0SDkRh4NZt1uStK9bBzntBFC53wp1jhPX3zLdDxtBQsRDmw+uPRT?=
 =?us-ascii?Q?istoBBCEJBuVllLSAn7XKGxeC7FP1+w/k/KdbTAsvHuAs5X88rO7KkaZOOMq?=
 =?us-ascii?Q?K1slsEiNNtz/8TrE6wxXMcSIXjtP0+o5WmVQ3UT36kt0eMzJRwDVy4GjmQad?=
 =?us-ascii?Q?/wevNoar1BI3tRagvFn++3zEbHZsZIN5tAQiGwAGNdsJBCkLilDr66fky7fZ?=
 =?us-ascii?Q?lQD86wWx3qozzrj+8oL7cBObxDF9zVRUYSlDhmjkZAmJZCjAN3o92Op9fF5E?=
 =?us-ascii?Q?B6+NtckgL3Uu7Azeb97rfLSNoqgTPcyigXY82nR3+QjpWunX4VjlW3Jw27fn?=
 =?us-ascii?Q?t1ZBwm6GYrCZs4esyNf+e68PTI7h93YHfa750+5ZaqCJB8nVtr+iXvyNvJTy?=
 =?us-ascii?Q?+XHNeru8Jh9+kqL9S16uE92oUs2/Xtcp9/6yCIwZTWxDHfdvnINFKa7PXPbE?=
 =?us-ascii?Q?p5fUYsO53b/Hqyo7upFwtS2IeS4JfHLvWxQdL7cMSxtUjosIEmhxw3Lqj/yq?=
 =?us-ascii?Q?BTfedEawMLWdMuBjGHLWSDIbkdEm3s2sGHL8IFa+ybCeKucrf7b7nlXy3N6Q?=
 =?us-ascii?Q?W0vj9pE38cL7LhU3pIr45NhqU83lGutBHBquNelVZKU/kLBpuikpNyuAbVQd?=
 =?us-ascii?Q?P4qc4Z9Z0ozDHm8oBEi+SF1LLB2gsyCcUg5mWXo7Kqy06Gn/Zeu0NAiz+mEC?=
 =?us-ascii?Q?EYwtN4Ruu/iLoS34ASU25F+mOPKhomyiBnX+TNV4/xKIwVQ2/EmrStlVQwKD?=
 =?us-ascii?Q?zGHxAJ+nFWD4tJOpZ/Fh+5lxNDl7IE4lgu/+jZ81vV0rGfZGx0GllQwcG6tb?=
 =?us-ascii?Q?czI1pImmAz8fWURdQblrIarvbk6HqKJf1IVG6yAshg1ebDJvcY3jPHPFYNbz?=
 =?us-ascii?Q?VkAYfyDaGThZL4PEKwFhvxJLJ4Kj0mJaka9ddrMYYThpTt4eJcvtBe664RWW?=
 =?us-ascii?Q?/wjVBJBqUSATi7QiFHeYQe3xm1A7gqjVEqye5eI/UbrvppAD5UBqNqsC5nMj?=
 =?us-ascii?Q?fJltREFFtw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd6d8e7-10ef-43e6-d207-08de6a402951
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 14:08:13.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30Hr8WT2oaAYHsAaXeSfGrImtzEXeQpXGCCx5uamtVYSysthaeNZDOjrNyMVZojVhAB59ulW++eNPGrKYsD9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
X-OriginatorOrg: intel.com



Hello,

we found the kernel-selftests.kvm.hardware_disable_test failed consistently upon
this commit but pass on parent. unfortunately, we didn't find many useful
information in dmesg. this report is just FYI what we observed in our tests.



kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:

commit: 704069649b5bfb7bf1fe32c0281fe9036806a59a ("sched/core: Rework sched_class::wakeup_preempt() and rq_modified_*()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: kernel-selftests
version: kernel-selftests-x86_64-05f7e89ab973-1_20260208
with following parameters:

	group: kvm



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602122157.4e861298-lkp@intel.com



# timeout set to 120
# selftests: kvm: hardware_disable_test
# Random seed: 0x6b8b4567
#
not ok 85 selftests: kvm: hardware_disable_test # TIMEOUT 120 seconds
/bin/sh: 50: cannot create : Directory nonexistent



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260212/202602122157.4e861298-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

