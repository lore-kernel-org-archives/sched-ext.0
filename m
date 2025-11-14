Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC51F5842;
	Fri, 14 Nov 2025 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086887; cv=fail; b=kbm9sF/bP9WYf9/15HlAae8XMg8AKJ1/YsSm1T/ub/dNXE5HSGc7GcZiFvz88iCJDbM605fyok+O7NuuuyHeDo+9eQCFNCisRzja3DzxX0XoAH3Wf+YY1/0nT5ZSJq4iAe42c8WVvCNs+d9nAej83S4+iPahvrJM2GO5OoNYsg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086887; c=relaxed/simple;
	bh=DCXX3OEYhOwrgo/mJ79j9W0i3rWASzUluC4YeA0/yaY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L+lWU9c4TqpTmwMdMSa+xgvadbQTeAcTdQSV0oBLflRMIObf0NNei1JrPQOPjv83LznLJJleVyT4c0MVd4qBIFIqNxiwtSZYj1pTYNOUCANFttyZOn6pAnAKukd7zjrxvSvCSP4ovtgwCJKd3Gu5Nu+4Y2l6ZoHmwi5SuPh4Szo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wr/ZDCum; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wr/ZDCum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763086886; x=1794622886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DCXX3OEYhOwrgo/mJ79j9W0i3rWASzUluC4YeA0/yaY=;
  b=Wr/ZDCum8vRKWBXdINYSdbPLiTKIVDIk5wlzDXqNwb5jjONL+rQsfZgJ
   4O1DiSkPQkn7020YVn7VY9Fd84Zflj/HlcdR+58spRzwTi51OvVNWBOID
   rin3mm18reogkTpQHoPheuLfLIsfOKPhiKu6REx4fYrT23szO9ekA9PsE
   AhJ6WEX+28ujsVjgi+yZdMF0m7OZj9ZvReQz94BmlvlzwhuI9ddAoFND0
   kaQTCs8rnFBt0Zs/mbMjfpSz56HIK3AbWHwrfyIoMF9w6tjdfXBVNoD0f
   yQ6XQUWODBHXDX5DZCg5m+Fh2O3qcKqNRsXpacMCw86sx2AOL9kEP+yn0
   Q==;
X-CSE-ConnectionGUID: LRo/fTjXQn+gQr1MVymaiw==
X-CSE-MsgGUID: MOOiEQipS42/JuRkbmlqHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65117731"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65117731"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 18:21:25 -0800
X-CSE-ConnectionGUID: ygAi1wR9Ss62hL1Oc5EehQ==
X-CSE-MsgGUID: fMd4/ZENTTaqartFIUSH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="213063467"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 18:21:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 18:21:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 18:21:24 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 18:21:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG1h3zlvFyA9KHk/FMndHIg61o0gmr3YxRWia7HM25vppkshHbIPJGNiMo8hPH9xzCNaCT21ReTS8EFzssoo4KPCCsuQxH0qJ7wQllYTEBTvY8DsqaG/acIVM9FBzWmF2po2JyU0ElpIgb8ALsQ1rGCI0SEyptr7PAuaqRGbx8PrOA+IsRNYCxg1QBypPHAADkn/iqhqk48RdZdIAbVX3iPX+svenpZbbstsspyfJhmflyaAT+LDKTf2bVQ6dZOat8pUcb1gIcCJHqvts5xAGLlcyIjbFaOgIRJ0VBWZqE+ySF8KOz9DsLfxrMu/X3ybxMUKea/NSaBT2WnkSWBM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffrfSq9SFnVBUAJBBsFLInSUZWikkTNEdlrf6axJPwI=;
 b=o085X4uDqRI887jvZmmmVGAAN8RdFuIImK75lFhaPDoo2y7e6tuI+obWKiscfBmqy9SHCVPdwQUsU1UPeooZgbJQoSHUW1u5oGlBIl5zYIUK/Lx9Nb+Go6fcer1xBVr2jY1fZHKSE8L7D5FBKkwPNPQTY2Ux95XTuiapbcMPBM6ksePJ/mw/69SFek8SwvwM/++4KM6kXE/ODZbmzJnRlfsbaevQKizUB1/sxIxfdPeNoA9kdDqFqn+Fk6gY6xNm+KLl0GtQyk260qwQQPfjMcKMpwsGmzdh82vmAZx68b6BYL4fuKxt0B/XeB8EEz9LPptpGaGH3bv8WZt6Gv2oTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 02:21:21 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::fc95:158a:24ce:885b]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::fc95:158a:24ce:885b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 02:21:21 +0000
Date: Fri, 14 Nov 2025 10:21:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Dan Schatzberg
	<dschatzberg@meta.com>, Peter Zijlstra <peterz@infradead.org>, Andrea Righi
	<arighi@nvidia.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [tj-sched-ext:for-next] [sched_ext]  7900aa699c:
 kernel-selftests-bpf.sched_ext.runner.init_enable_count_#.fail
Message-ID: <202511141028.39aed7d5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1P15301CA0054.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::8) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|MW5PR11MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6aa554-c198-4295-c4a0-08de2324803a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7ZHHaRXWDwH32kVrFv1aDbu2JdPHwbLuQYvhaoB/kDJBll5v2nTGhzajUuJ?=
 =?us-ascii?Q?dXf0lzSiLb4zeSEgeLiFM3q2+eCO1UEZKy9FVoPfOS0qAQ5fzbOAQ2BJCW6/?=
 =?us-ascii?Q?szJGubI7oIMjMlY3SxenVqIo6YVEbgIrjyYjijI0h3VVEYaOs+qDkM+Ek2rT?=
 =?us-ascii?Q?V3o64D7UDVW+fhQLn2ScvqonHb4oIo4UmuOfIAp4DfpHcAycA63Uv6y5iGWs?=
 =?us-ascii?Q?n7ruqDpKXNgBTcKoYVBp/mOsK0ZQjDbWv3hCwgNQQzlAvYVLc0A3vFSn9uui?=
 =?us-ascii?Q?H0quShIQOTXvklnDk4VDnPhPygBQj5FKXbmf9oqunSCqlM5BBi9ZrKgqiYa2?=
 =?us-ascii?Q?p5FA/i9vJe52PHAHfsJarVQ0w+WDgWQKK/cVGsrNeHffssNPn9Iw6+2zqvdR?=
 =?us-ascii?Q?r+NWzKcNcvMdJ60nP/1OKVvo3YBMRKVCtS02eXhFJNOfXXaLpOQOW9rsZYmN?=
 =?us-ascii?Q?G98zUnq6SyTwSm+ivN22j9297l5iqa+z9IC3XjwLfYNLdDwW5Lwuk12aqtvK?=
 =?us-ascii?Q?Zl6XutVUYmheEW3jxKPgwlxoTOS7REo7Sa8xKsKDKSOT9BVqYNp8GXSEHvVr?=
 =?us-ascii?Q?n/d7X3m4csWTfTfstIp8yksoxYcrBJt9OKJdFxwI6kjcqq0lcT5rgGo5Af/I?=
 =?us-ascii?Q?Bqae+bgVUzluPZhUm+DMkaV0alICWq9d9jeJE+JJdNRLs/OLtBDcboAZtXdS?=
 =?us-ascii?Q?QH4NJFjtSyXwJQW4dYwoId6j97dQ4kD213rlRcntoiEx/jdEnUoBOiQkMsMo?=
 =?us-ascii?Q?2/yvqCOPbwNceTjNnaARnd8N9VmZxIqtZ88mIK72IlguEhCgOVa1Dg+Z2Bau?=
 =?us-ascii?Q?C8OXODGTsOQ/JktGPxMP0g/fpmSe1Q/RZAxmIALo9jJsALi8sJXZMptsZex6?=
 =?us-ascii?Q?a0K8FqX8AiPHCzzKfZPq9qrHJTZxvhJXTWXBS0fotzIKV7WDKhCMVwiTdKzr?=
 =?us-ascii?Q?PBmD3mSmCi6+ZdYkN+raIzXXnWFH7wD0l4qC67pcMyA9bmfZdDfqZTL1+W70?=
 =?us-ascii?Q?RtRI/KgrTZOUCjcw86aGldfsXtH1JiiV/kVIgBiF9eP3V7Ue//JxFPKtKE7S?=
 =?us-ascii?Q?Hhjhdak9bwVo6JKjrL0VxJ60MC0zQIuuiPtEe+lwYS6I7DuevRQZOy2aYky2?=
 =?us-ascii?Q?JB0+N3f8uQ+mRfOJ3qf+yxkA9mrFkMIvYbyca6VFpVmcXz+cfhAuyVvia9py?=
 =?us-ascii?Q?UY2pEOKh2GOTXXoD75wNfoAmZe4PtbhFF8lO4yybzqNPrn8InVT/h5cxm9jA?=
 =?us-ascii?Q?4gXrAwrf5NP25DbSPbcQk7Gh+Zrmw73oKXSgWhw1NY3SkuMx4jRrJeOnujTK?=
 =?us-ascii?Q?wE2iz9fw6FmmKgX6GepE41hPH8/YqeQgHdx7nuIxArt50wPEhNZ8ZRDTeJPG?=
 =?us-ascii?Q?KtiJ2fJmv7nZ0zGrwSmQfpzDvQO7c2bZP+42W9YwMsCpnuncqvqEpA/jZpdc?=
 =?us-ascii?Q?8T7APHpihZyXgzgLbgt+hnXbeE0rKRuSmOYlyEYuT1Np1X01ygzzlw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUkKv1FvLIyxSLf1P5CFruytJ2Mi9ennhteT/qrQhrfjIZuFSlaC04aVTHc2?=
 =?us-ascii?Q?PRAn/nR4VjsM5Z9CJn3ufhq0LZkjNEL/RaBa+4HLKzO8WwINwSf8ru+Gjnvd?=
 =?us-ascii?Q?VEBsyoHXtjSpio8TR6BNarjXtfHwdQp8C94wBoGQDzqosnNvcn7BtyRQGwtc?=
 =?us-ascii?Q?aikNVo3TLH2QP0D270Qu0rJ+Oe+StBo9LQRNrn/iG1hAWqYDHgQXCyXW3e40?=
 =?us-ascii?Q?RecqRBhU4T+dRsRtPr57rCt8AOsm0oGnh9rm2V8sE/l3oRENoBANwzUdzFrj?=
 =?us-ascii?Q?NVmrTsdcpxzlkw4uuDyKz+LmNBgjVu/mha/9nLE76l+Jeuu2Cn12Rwe8yRUT?=
 =?us-ascii?Q?3ojX1l1pJoT2s5l8W4x24c/ZuDmIMyk3ErpCno7T+8MAnowi2bE+YGXZWwjr?=
 =?us-ascii?Q?P6UuD86USlISBHpQ2pn+Xuv/xa9vem0hgcK2PHnNQXLB6E2maBIAM25NowNU?=
 =?us-ascii?Q?Ek+SF9Ji7OJCMi29ncBqRMxFhpYY5/0dPzXjvrdv4X0B1rKpb7ltLGZXDtgv?=
 =?us-ascii?Q?2voUpL/PaU3O06xYPMKNTBeTb8ioE1vKnEfKkoL5eZgvVSBOahlMIcX0TqeO?=
 =?us-ascii?Q?tlJC3U8zGaHhWBo6rfN/6zNfRk9bEHeJuRKh0CVbdoKwWgMw/K1gSVsRHh0m?=
 =?us-ascii?Q?X7+z30E8htIc5JraVuzbWXdUEkHx8q8NHWCmJ0atl8cF0l2A3eWxuYppM1tg?=
 =?us-ascii?Q?/ytO3NA56W6Xw1LpyIFICeVEZZ2u5uo4oBr3tFTSM5YStZGO+F7y+azDELmt?=
 =?us-ascii?Q?14cYHE8Ev39OlNpcPORxlJzuLkkT62CGyFrVwPb7HVR/PaeaH+eFHqRuuown?=
 =?us-ascii?Q?a8eOHRU1nHIpJTETSP3A/TiecWR2m+OO0NV1+F+6u1IVPrNCdGpzqkJNTUH3?=
 =?us-ascii?Q?K32PYeCJwn2Al/KjpqGPBiRn74ii9Su0KYb2u1QxfLD1wuisRfr/wbeciCX9?=
 =?us-ascii?Q?Sg7UR4sDrZ6YwvR4mTCgRqpWPavDOEEmMQQ+HM+pxHtf2cgNSM57P3ActaK6?=
 =?us-ascii?Q?FsEXTYuIUNbRV+uKCSt6sNEi2niHL//I5CVBdrwfuIfJfhlmUWECv0TlXi0Y?=
 =?us-ascii?Q?bRWrHsc8ITlgjfwnSQW03/UbloZ+r4hJI+lySsiJ0oxbdjelQieG2jGkCEva?=
 =?us-ascii?Q?ZuQjjzXHwSxL90so/XrJ4WNpZ2IVCBIzBBjAzDxTC+YFFgCrncrxtEWjwmoq?=
 =?us-ascii?Q?HrfTpC3aOQDbEfSM+S3hLSqyjsBMknxOTwdkAyxZiUM5usoKuaFOyyuLNY9S?=
 =?us-ascii?Q?O3LHbrtzxjExEz1g8cI4AQB/PjUr91dQHltMlDsu8P5fRz+AaiKp0/4d//c6?=
 =?us-ascii?Q?BuP3TlYsfQX5MZcsgOhRKSQjFSaHLjXSu7w84hCnguA8QUqINucyOEoQlbdn?=
 =?us-ascii?Q?vq9Ewn5TSxJZMnLX6RE586u7KJBeP+pNRZ7COMHP4I6izZb9ks/kzywlnKml?=
 =?us-ascii?Q?39+nakZ/3GWHKSE1MnRag7ppKraCYFWXI6geOeXLnEpLj4Sr2iLo3PMCQUmS?=
 =?us-ascii?Q?NWqtS5UtYp6nVvGSRsvjO7KfgEtoZKAEudTGlYGOAuV84m2HKcBD0Vt5JdBo?=
 =?us-ascii?Q?4kYLTx6PAx0eYYDg7aUSfk0n7wfufYwM2I5lPr0x+A4wsS+Roh/RiSbu+xFc?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6aa554-c198-4295-c4a0-08de2324803a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 02:21:21.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RPquxf7KHb/uqpyDj0TgmRquSiSBC902E3Qu5xVOecBFwtGbFYMJdpGxQCD1iE4IDlwdagjChtpv2BhanzrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests-bpf.sched_ext.runner.init_enable_count_#.fail" on:

commit: 7900aa699c34401cf5d0c701d9ef72880ddc1a83 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
https://git.kernel.org/cgit/linux/kernel/git/tj/sched_ext.git for-next

[test failed on linux-next/master b179ce312bafcb8c68dc718e015aee79b7939ff0]

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: sched_ext



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511141028.39aed7d5-lkp@intel.com



# ===== START =====
# TEST: init_enable_count
# DESCRIPTION: Verify we correctly count the occurrences of init, enable, etc callbacks.
# OUTPUT:
# ERR: init_enable_count.c:63
# Expected skel->bss->init_task_cnt >= num_pre_forks (611 >= 1024)
# not ok 9 init_enable_count # 
# =====  END  =====



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251114/202511141028.39aed7d5-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

