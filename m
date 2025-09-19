Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B523B607;
	Fri, 19 Sep 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288288; cv=fail; b=mh+jLmCmisz/iwD6aoPFbphtwDswQEjQFMA1zh24EZ338m1RtD/U42M7jok9xvO4QXquajQigkHzghoQpghi+yA4ISmgMGJX6tgdhJRsO24rVmTWK8pKesFGMMV4XL5AlEdUJaUX82n113QIW+2im1uFQt6klJ6NhhFlI12AnsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288288; c=relaxed/simple;
	bh=rHgY+UTtus308etYUNLMNbcvQNnpHEnslDetxegVtHk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qa54Q9TkflGiBnNbDkA6kYE3zrhM6wtcv1cmxvJTiLSoJKWnTVNWJEM/IWaQm1fcTQ36mCnwPijVxkeko1APirHjaCSnJ4rezGKDLNh58KJ7jUx0W5HXMdkGZaH8ejAwLe69MxwkaXClW0ffqJp0ctAdxjOhchOguy6YSigkl7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI9yGiEI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI9yGiEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758288287; x=1789824287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rHgY+UTtus308etYUNLMNbcvQNnpHEnslDetxegVtHk=;
  b=WI9yGiEI+NbsCzAUCf0fpgbPlK1w0u+mMZ4bdTp/LyrUaWxk5449eLCn
   PYxmtQHMOt6CP62zh0wvPHYzRPFmyBhqPllIFSdpiulwZM/qslh5+89tb
   yepbE/K2eu0pKrLHO7+K2TccAdOQYDg0ls5a3dDn6jgCeKyHj/vDhk1Lj
   zGfJLKb9OYJVmU02TGjflIXNQPD7itN8oo0ZG8LlhcN6F9MA7U27vgs/4
   /+QFR7gi7dopnDpn6EtLg3H35D1jhDjWcG5JM6YHa5Mitql1Nu9RPQEt0
   FEFfPWEOJvlaqma0QRW6fEcQ7YM1e3fH0dLyIw5lgHOGlBsPMI80MbmGx
   Q==;
X-CSE-ConnectionGUID: uTBqqkFkRbmt6B3/7bIfag==
X-CSE-MsgGUID: 23lG3tm7SDe5xdLMbeMpVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60789038"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60789038"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 06:24:46 -0700
X-CSE-ConnectionGUID: SWSvoog+ThOfU+84/0IAMw==
X-CSE-MsgGUID: TrYrONxpSbarMtyWpgAQSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175455621"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 06:24:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:24:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 06:24:44 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bali0R92PCNoDJt5U1E0cBKUJLZHI9y6x8+eEVIPiBzExbQVywINoStBipEWLhxXbIU1PbrhnMECHegY47gfdm1vVut6+RB2lBdyQ2sVtZaWlPSJirnGq/klwxX3a5US4ZEQLZ8XOKhirGkErSpWHLwmwTdjZXk2QWTot+H9b4Tggmnrva5wGPC1O+7aEdUFpeiCRGxlczn5pxBtRDCN4gyEPPSD07YTI+MOHHA5NHDF0jjmosr95HIrochPi8qsux/NGyMrH17f8XZKCpRZRXydfdrW6gOFx4kCJ7yUOJG5tiKPHdfG8lrcPZEtQiLw3omggHB0BvrhN8galnnacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsv9/B0O4MzFZQl9hpj9zL7/+ZI7jpuP8D4DuKSppKo=;
 b=UEUKJ2CZHZrY0vh0/YRtbag7SEA9LsFFzESpcQAkV6Wz8d3VNZmTcKiHb3AQIENXONwYm+ai8sgu6kMmvhsgPBXpouDbodXPtAe+p8e92MNMaHRJs6/lt4TaWgIMIQYyJjIf5nNTQZaao3k/2l9VlvoksS/4o6f+0FmVEs+uboxKOX0C772qKtfZFNCuUA1pnHXs/3urDrb5F2LEMWrQ20bssK4ReRAcejUSQLw1Mui9f6L7qg6tEY8F+WoqW5UwmC3q5aDY9uF8pTnISmx2Q1JTKj99tPI0kN18fM+OAjCGXRZlSBcSUVaPKG9F1ahCoB+UzeQdYnUiL7TP8lSozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Fri, 19 Sep
 2025 13:24:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 13:24:41 +0000
Date: Fri, 19 Sep 2025 21:24:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [peterz-queue:sched/cleanup] [sched]  b55442cb4e:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202509191647.c48ab569-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 050854ed-0602-4573-049e-08ddf77fe3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rs8Sui1vWvqnopmWH2D4bA7fmGhKtbALOOnrufAm52KO48N0XHu5wOX5A8Sw?=
 =?us-ascii?Q?qFmsSipU6nCYNpQAZ1KDAQRQdH735z1ftczRsl3b+ufQBA+GekCgYntL9XEH?=
 =?us-ascii?Q?WGmToY0c3KcTQY2hp43JveOsHSFYkJS6VVdbZ+DYczV9DX+aG5bUt0XiFJ4o?=
 =?us-ascii?Q?aHD30F9dynzbnDK62IwlibvdHD8eJPgF8bphYEWIfVYAMV17WAHNBupVPKpt?=
 =?us-ascii?Q?D3g2+GeTOXs09tw/6PputDbb/ljEspdfJhIsgsVg2R6EJQFSlLIpCRYnAcag?=
 =?us-ascii?Q?ng5AfXs+Zf4e2sdd/fX2yPTelr/ivZaYicWxRxsJerwP1CMeS1/+cM008wH1?=
 =?us-ascii?Q?ol+y6B7n1RJMr/E3c7PskpeKu/SztxsWjpQfpqhp1kTN0pMDlaZZ2d7WKKug?=
 =?us-ascii?Q?1FzOMfPzKuK/PofGApqNjSSl/VAN/nebEgkpYCgTusoGfctqX9nQQm77cWN+?=
 =?us-ascii?Q?Jj9me2g3jiPAJwlijBsMqFHYJZK3UlygtXuhHbtEDl7gVhvg16E3TpS9zDD8?=
 =?us-ascii?Q?f+pXBhmYSqR4pIk+doZYYRO/SBak/X7LA3bkkkAVlvsLto6pzHQm0kQcGhGO?=
 =?us-ascii?Q?k++tC0RG2EPLm73fpTjuyYs9MdefGFWrDW1kVVMXWKMsNq+otfsRexyWOtYT?=
 =?us-ascii?Q?XqgI+1fjyyCOVOpqatiMR+HXc7ionOjqgG6O63XJLcqKQms4jStoAVbG8E6m?=
 =?us-ascii?Q?HFhLnjQjz3oFXVh4olAMGyHSYNKffJiPxbwSO1Ce5GixrXIHQKfROhjbr4bN?=
 =?us-ascii?Q?hpf8Zzp/owSAOg6yx2y8Q1oOVrDwynG5TjQKMr/SZwj4T4yaTTrFv4urnbLS?=
 =?us-ascii?Q?HN5u/9OYtT/jbf9Ot/fndSo3SvF3/vbfb8UlxnL36RQPY6JOL2QJMXCx/qh3?=
 =?us-ascii?Q?tXBYPIcGIz6/LwPzk7eQiJI5/tmsi09BOj/puFbSvQ9ye/AJchaGqhmujsEY?=
 =?us-ascii?Q?P0PoDNQxF+JpbUFkzjLYghDcH7reIUy/a3RYeWLapZOau+rkAXZVYKBDffJT?=
 =?us-ascii?Q?e+c3r/qObEk7KryaH/+sKEaqFbOYcHUnQp5RWtHFbMUvRbeq5fcjotk0ne+f?=
 =?us-ascii?Q?2Kw/Cy6NkqmD5VxdiQ/i0mi8dHGQkCt4yi4kYcDLSZqEq+beVfw3glbyIsSw?=
 =?us-ascii?Q?q4eumxtRXxSw/s3sHtn7snidc06tBWqO33pw4B0amgDqjO1t4yYWcDM1dqyJ?=
 =?us-ascii?Q?WRk5lPxJMq7Q9twnTkbYQx0EvAcA6RIBiWjTISHHrrNQEDdDe76B42EoH4mb?=
 =?us-ascii?Q?7pdfCqIbdkFACOF5sbqx9I+O0uh0yTbuFTrDgyMMoKC0I6Ypg4pEnvb7TYCx?=
 =?us-ascii?Q?N++mqVYWJszTtuEWzVpHhjFVZHcgPAsp8/DMEHDUJzYbaG6ZnM3iuvY1k6yE?=
 =?us-ascii?Q?ZHyKtVO0bLyl4jSZq3WZJOLllKbr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xur7tlR3zJhdoje5uGkC5c0xoIjKMU28dEwDFtErrPw56am+q4agJIp7aAXD?=
 =?us-ascii?Q?z+VOVaXeBJTdCA3w3ap6P+8cKJIV1dBn+FocaqRJnH4LkVbTocfLCQMoXyW+?=
 =?us-ascii?Q?YjsYRW4YRQ3IWAQ+SnCh3zuFZ9g810jhH1e5qCkVT8mlRNkxnXVq7HBgVE/J?=
 =?us-ascii?Q?5Cd48I+O1P3LuceqRUWuz3sMfxfZD8kTsugfNZ79GbNbNEcSroDmKkOLeg4B?=
 =?us-ascii?Q?DLTo4iOKXwfwon0n8tyN+aKvwNkVlGI72E5hVtd64d6fsGzk5DO/o+tWB9Ku?=
 =?us-ascii?Q?B4B8TbYCJUlLqaVKIMEjgissvF3f+LpGIF3pXaaG3KqRe+OAcVdd03S8rfrU?=
 =?us-ascii?Q?IA6OuQuVTmSPcxb9x7C99DrC9vl0FTUyxzE9kvL+hFemrsALeQs7VOC0Nele?=
 =?us-ascii?Q?RRyRcsNH2INrxDlVhBG13cJBOo1fUGyiBiB/LMGGZ3fDC7auBPm0rMp4kWn8?=
 =?us-ascii?Q?52JYVZFTOkvzK2X5yeCsTdPn95BgcMNirVnsyrYVh++hoTKEzHQLZAMffutP?=
 =?us-ascii?Q?mAU1bcdbsMj1rGN2b7oqanJXzIBMDK0j+z8do2XUwYrfhPwWaaqga3NoFtQ0?=
 =?us-ascii?Q?nzGodRXFiqYTpCYYaOoqxbw0fK7TKEDl2LbOqgALYaCgMYV+AF+25q2yQo3a?=
 =?us-ascii?Q?ofismYbhbIhtGHk3KMLg6pAMrg49BuvLPmqd4NxhRgWqTKX0IlaqMiU7kBoZ?=
 =?us-ascii?Q?TDP1R1W1wKtyDlGc85bDFmuFwKP1tDIAGyl6dNirSWCcHtiqHGbkpPDMjrwV?=
 =?us-ascii?Q?+3UfRJAItmKvzAHMZBvXf8qV0VwJktz7SOPKW1noXRMdHtEY8TE7JTKpFhry?=
 =?us-ascii?Q?yChJLrnQ4wA8LNn1qx6KjZiZzWNoU8Ymet6XJWeNq/lbwjI3TSjckbj+fZHs?=
 =?us-ascii?Q?aBnyTJXLUKkWpOrK8N3TEvbfz465Lfv67P16fkNiy7NxUA8AvTbmrPT74XcI?=
 =?us-ascii?Q?lET+MzCXQPAI8rW8xNMVl1bIyERbrtCM1zXNwX8Jii4hs1CC8Zq0LAm5NuFt?=
 =?us-ascii?Q?JmLlFQI340HYAnp8Zj6tZYd4LV0cy/+1v4SLAudWqOp9COS6vpsh2wlDWGOw?=
 =?us-ascii?Q?3/mbtf5+jZIBtJmeIOpXJEma5/xxvW1QQzyI/tmoZzrmvWmBEFHVyQo171sS?=
 =?us-ascii?Q?Sdu69yDso4EM0KNvUt8LqeSskr1vKUjOn62NOvdbJiuM6BMlxoBEGNWp7oxT?=
 =?us-ascii?Q?cRoFeVO5qDd6jBiWS7iaBd5WyAIJj+cI9YDIZ9GTNE2t3V6Oqpc17ofwEjz0?=
 =?us-ascii?Q?qXTZeUSJGs/aX0ipntiKg4Cm3WGHIuU8osS7SOWKn6BL34JgVjMZ7SZtpTrc?=
 =?us-ascii?Q?6II63GKsroqGaJlTuoxoHHDmOpcOjgi7Cphgu5B9vfnkW/cxWORimlrwBW59?=
 =?us-ascii?Q?SO0SORAIz04QVvoRfgZbobAvWwkvSok+tzCLA2c77w1f103cSsRjvRtdQSjd?=
 =?us-ascii?Q?wwzcj+sf44YUflbrJBg7nvqYd6FBaPhPZrSP/sFu3dExnPcwe8Z4vnZ8hmY9?=
 =?us-ascii?Q?spGW8BY9ijjSS8qJmb4haGNDoQHp3A0Y9myJ+/NG5SW2KlwIxfmlIAtGPH5L?=
 =?us-ascii?Q?Y7jYle6j0lR0WgWVS3O0tQrljYFljTdNMivqQ5yRl9+5TtpNisHHGyF6Cxs2?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 050854ed-0602-4573-049e-08ddf77fe3e8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:24:41.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ+wJKphC1g3YGTHec3dX08dd8YfXO+VNwWUoqur9eIxdLoSUBUiYCXV5hyKDZi5fzsvkBTUiZW9FqlKaEwBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: b55442cb4ec1669a2034af5d0e65ff30046410f8 ("sched: Employ sched_change guards")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/cleanup

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5


config: x86_64-randconfig-007-20250917
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509191647.c48ab569-lkp@intel.com


since we don't have enable knowledge about the relation between this commit
and the issues we observed, we just try to run more times. parent keeps clean
while this commit shows various issues.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/debian-12-x86_64-20240206.cgz/x86_64-randconfig-007-20250917/clang-20/300s/group-01/5

5b726e9bf9544a34 b55442cb4ec1669a2034af5d0e6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         28%          55:198   dmesg.BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
           :200          5%          10:198   dmesg.BUG:kernel_hang_in_test_stage
           :200          0%           1:198   dmesg.BUG:soft_lockup-CPU##stuck_for#s![(udev-worker):#]
           :200          0%           1:198   dmesg.BUG:soft_lockup-CPU##stuck_for#s![sed:#]
           :200          0%           1:198   dmesg.BUG:soft_lockup-CPU##stuck_for#s![trinity##]
           :200          3%           6:198   dmesg.KASAN:null-ptr-deref_in_range[#-#]
           :200          3%           6:198   dmesg.Kernel_panic-not_syncing:Fatal_exception
           :200          2%           3:198   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
           :200          3%           6:198   dmesg.Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
           :200          2%           4:198   dmesg.RIP:__rb_erase_color
           :200          9%          18:198   dmesg.RIP:pick_next_task_fair
           :200          1%           2:198   dmesg.RIP:pick_task_fair
           :200          0%           1:198   dmesg.RIP:place_entity
           :200         10%          19:198   dmesg.RIP:put_prev_task_fair
           :200         10%          19:198   dmesg.RIP:sched_change_begin
           :200          2%           3:198   dmesg.RIP:smp_call_function_many_cond
           :200          9%          18:198   dmesg.WARNING:at_kernel/sched/fair.c:#pick_next_task_fair
           :200          0%           1:198   dmesg.WARNING:at_kernel/sched/fair.c:#place_entity
           :200         10%          19:198   dmesg.WARNING:at_kernel/sched/fair.c:#put_prev_task_fair
           :200         10%          19:198   dmesg.WARNING:at_kernel/sched/sched.h:#sched_change_begin
           :200         10%          19:198   dmesg.WARNING:possible_circular_locking_dependency_detected



[   37.369088][  T318] ------------[ cut here ]------------
[   37.369228][  T318]
[   37.369230][  T318] ======================================================
[   37.369231][  T318] WARNING: possible circular locking dependency detected
[   37.369233][  T318] 6.17.0-rc4-00010-gb55442cb4ec1 #1 Not tainted
[   37.369235][  T318] ------------------------------------------------------
[   37.369236][  T318] v4l_id/318 is trying to acquire lock:
[ 37.369237][ T318] ffffffff85719f40 (console_owner){-.-.}-{0:0}, at: console_flush_all (include/linux/rcupdate.h:336 include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   37.369249][  T318]
[   37.369249][  T318] but task is already holding lock:
[ 37.369250][ T318] ffff8883aeff5298 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:?) 
[   37.369255][  T318]
[   37.369255][  T318] which lock already depends on the new lock.
[   37.369255][  T318]
[   37.369256][  T318]
[   37.369256][  T318] the existing dependency chain (in reverse order) is:
[   37.369257][  T318]
[   37.369257][  T318] -> #4 (&rq->__lock){-.-.}-{2:2}:
[ 37.369260][ T318] _raw_spin_lock_nested (kernel/locking/spinlock.c:378) 
[ 37.369263][ T318] raw_spin_rq_lock_nested (kernel/sched/core.c:?) 
[ 37.369265][ T318] __task_rq_lock (include/linux/sched.h:2226) 
[ 37.369267][ T318] wake_up_new_task (kernel/sched/core.c:4867) 
[ 37.369269][ T318] kernel_clone (kernel/fork.c:2639) 
[ 37.369272][ T318] user_mode_thread (kernel/fork.c:2683) 
[ 37.369274][ T318] rest_init (init/main.c:709) 
[ 37.369276][ T318] start_kernel (init/main.c:1038) 
[ 37.369279][ T318] x86_64_start_reservations (??:?) 
[ 37.369282][ T318] x86_64_start_kernel (arch/x86/kernel/head64.c:231) 
[ 37.369284][ T318] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   37.369285][  T318]
[   37.369285][  T318] -> #3 (&p->pi_lock){-.-.}-{2:2}:
[ 37.369288][ T318] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 37.369290][ T318] try_to_wake_up (include/linux/spinlock.h:? kernel/sched/core.c:4216) 
[ 37.369292][ T318] __wake_up_common_lock (kernel/sched/wait.c:109) 
[ 37.369295][ T318] tty_port_default_wakeup (drivers/tty/tty_port.c:70) 
[ 37.369298][ T318] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1735) 
[ 37.369300][ T318] serial8250_handle_irq (include/linux/serial_core.h:1231) 
[ 37.369301][ T318] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:82) 
[ 37.369305][ T318] __handle_irq_event_percpu (kernel/irq/handle.c:?) 
[ 37.369306][ T318] handle_irq_event (kernel/irq/handle.c:?) 
[ 37.369308][ T318] handle_edge_irq (kernel/irq/chip.c:857) 
[ 37.369310][ T318] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:328) 
[ 37.369312][ T318] common_interrupt (arch/x86/kernel/irq.c:318) 
[ 37.369315][ T318] asm_common_interrupt (arch/x86/include/asm/idtentry.h:693) 
[ 37.369317][ T318] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152) 
[ 37.369319][ T318] stack_depot_save_flags (lib/stackdepot.c:722) 
[ 37.369322][ T318] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 37.369324][ T318] __kasan_slab_alloc (mm/kasan/common.c:359) 
[ 37.369326][ T318] kmem_cache_alloc_noprof (include/linux/kasan.h:250 mm/slub.c:4180 mm/slub.c:4229 mm/slub.c:4236) 
[ 37.369329][ T318] fill_pool (lib/debugobjects.c:372) 
[ 37.369331][ T318] debug_object_assert_init (lib/debugobjects.c:726) 
[ 37.369332][ T318] __try_to_del_timer_sync (kernel/time/timer.c:? kernel/time/timer.c:848 kernel/time/timer.c:1457) 
[ 37.369336][ T318] __timer_delete_sync (kernel/time/timer.c:1622) 
[ 37.369337][ T318] schedule_timeout (kernel/time/sleep_timeout.c:103) 
[ 37.369339][ T318] rcu_gp_fqs_loop (kernel/rcu/tree.c:2083) 
[ 37.369341][ T318] rcu_gp_kthread (kernel/rcu/tree.c:2288) 
[ 37.369342][ T318] kthread (kernel/kthread.c:465) 
[ 37.369344][ T318] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 37.369346][ T318] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   37.369350][  T318]
[   37.369350][  T318] -> #2 (&tty->write_wait){-.-.}-{3:3}:
[ 37.369352][ T318] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 37.369354][ T318] __wake_up_common_lock (kernel/sched/wait.c:?) 
[ 37.369356][ T318] tty_port_default_wakeup (drivers/tty/tty_port.c:70) 
[ 37.369358][ T318] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1735) 
[ 37.369359][ T318] serial8250_handle_irq (include/linux/serial_core.h:1231) 
[ 37.369360][ T318] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:82) 
[ 37.369363][ T318] __handle_irq_event_percpu (kernel/irq/handle.c:?) 
[ 37.369364][ T318] handle_irq_event (kernel/irq/handle.c:?) 
[ 37.369365][ T318] handle_edge_irq (kernel/irq/chip.c:857) 
[ 37.369367][ T318] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:328) 
[ 37.369369][ T318] common_interrupt (arch/x86/kernel/irq.c:318) 
[ 37.369371][ T318] asm_common_interrupt (arch/x86/include/asm/idtentry.h:693) 
[ 37.369372][ T318] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152) 
[ 37.369374][ T318] uart_port_unlock_deref (drivers/tty/serial/serial_core.c:74 drivers/tty/serial/serial_core.c:92) 
[ 37.369375][ T318] uart_write (drivers/tty/serial/serial_core.c:639) 
[ 37.369377][ T318] do_output_char (drivers/tty/n_tty.c:?) 
[ 37.369380][ T318] n_tty_write (drivers/tty/n_tty.c:486 drivers/tty/n_tty.c:2388) 
[ 37.369381][ T318] file_tty_write (drivers/tty/tty_io.c:1006) 
[ 37.369382][ T318] do_iter_readv_writev (fs/read_write.c:828) 
[ 37.369385][ T318] vfs_writev (fs/read_write.c:1057) 
[ 37.369387][ T318] do_writev (fs/read_write.c:?) 
[ 37.369389][ T318] do_syscall_64 (arch/x86/entry/syscall_64.c:?) 
[ 37.369391][ T318] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   37.369393][  T318]
[   37.369393][  T318] -> #1 (&port_lock_key){-.-.}-{3:3}:
[ 37.369395][ T318] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 37.369397][ T318] serial8250_console_write (include/linux/serial_core.h:?) 
[ 37.369399][ T318] console_flush_all (kernel/printk/printk.c:3055 kernel/printk/printk.c:3139 kernel/printk/printk.c:3226) 
[ 37.369400][ T318] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[ 37.369401][ T318] vprintk_emit (kernel/printk/printk.c:?) 
[ 37.369403][ T318] _printk (kernel/printk/printk.c:2478) 
[ 37.369405][ T318] register_console (kernel/printk/printk.c:4127) 
[ 37.369406][ T318] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:?) 
[ 37.369408][ T318] console_init (kernel/printk/printk.c:4325) 
[ 37.369411][ T318] start_kernel (init/main.c:1036) 
[ 37.369413][ T318] x86_64_start_reservations (??:?) 
[ 37.369415][ T318] x86_64_start_kernel (arch/x86/kernel/head64.c:231) 
[ 37.369417][ T318] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   37.369418][  T318]
[   37.369418][  T318] -> #0 (console_owner){-.-.}-{0:0}:
[ 37.369420][ T318] __lock_acquire (kernel/locking/lockdep.c:3166) 
[ 37.369422][ T318] lock_acquire (kernel/locking/lockdep.c:5868) 
[ 37.369424][ T318] console_flush_all (kernel/printk/printk.c:1924) 
[ 37.369426][ T318] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
[ 37.369427][ T318] vprintk_emit (kernel/printk/printk.c:?) 
[ 37.369428][ T318] _printk (kernel/printk/printk.c:2478) 
[ 37.369429][ T318] report_bug (lib/bug.c:?) 
[ 37.369431][ T318] handle_bug (arch/x86/kernel/traps.c:338) 
[ 37.369433][ T318] exc_invalid_op (arch/x86/kernel/traps.c:392) 
[ 37.369435][ T318] asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 37.369437][ T318] sched_change_begin (kernel/sched/sched.h:2447) 
[ 37.369439][ T318] sched_move_task (kernel/sched/sched.h:3873 kernel/sched/core.c:9226) 
[ 37.369440][ T318] do_exit (kernel/exit.c:965) 
[ 37.369442][ T318] do_group_exit (kernel/exit.c:1081) 
[ 37.369444][ T318] __cfi___ia32_sys_exit_group (kernel/exit.c:1113) 
[ 37.369446][ T318] x64_sys_call (??:?) 
[ 37.369447][ T318] do_syscall_64 (arch/x86/entry/syscall_64.c:?) 
[ 37.369449][ T318] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   37.369451][  T318]
[   37.369451][  T318] other info that might help us debug this:
[   37.369451][  T318]
[   37.369451][  T318] Chain exists of:
[   37.369451][  T318]   console_owner --> &p->pi_lock --> &rq->__lock
[   37.369451][  T318]
[   37.369455][  T318]  Possible unsafe locking scenario:
[   37.369455][  T318]
[   37.369456][  T318]        CPU0                    CPU1
[   37.369456][  T318]        ----                    ----
[   37.369457][  T318]   lock(&rq->__lock);
[   37.369458][  T318]                                lock(&p->pi_lock);
[   37.369460][  T318]                                lock(&rq->__lock);
[   37.369461][  T318]   lock(console_owner);
[   37.369463][  T318]
[   37.369463][  T318]  *** DEADLOCK ***
[   37.369463][  T318]
[   37.369464][  T318] 4 locks held by v4l_id/318:
[ 37.369465][ T318] #0: ffff8881ab704378 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock (kernel/sched/core.c:734) 
[ 37.369470][ T318] #1: ffff8883aeff5298 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:?) 
[ 37.369474][ T318] #2: ffffffff85719fa0 (console_lock){+.+.}-{0:0}, at: _printk (kernel/printk/printk.c:2478) 
[ 37.369478][ T318] #3: ffffffff85329830 (console_srcu){....}-{0:0}, at: console_flush_all (include/linux/rcupdate.h:336 include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[   37.369482][  T318]
[   37.369482][  T318] stack backtrace:
[   37.369484][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Not tainted 6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
[   37.369487][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.369490][  T318] Call Trace:
[   37.369492][  T318]  <TASK>
[ 37.369493][ T318] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.369497][ T318] print_circular_bug (kernel/locking/lockdep.c:2045) 
[ 37.369501][ T318] check_noncircular (kernel/locking/lockdep.c:?) 
[ 37.369505][ T318] __lock_acquire (kernel/locking/lockdep.c:3166) 
[ 37.369512][ T318] lock_acquire (kernel/locking/lockdep.c:5868) 
[ 37.369514][ T318] ? console_flush_all (include/linux/rcupdate.h:336 include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
[ 37.369517][ T318] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250919/202509191647.c48ab569-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

