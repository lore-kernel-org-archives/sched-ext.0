Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97DB30649C;
	Fri, 16 Jan 2026 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552738; cv=fail; b=FWDkzUhWDjF6n23uqn2+L3+K6cy5bB8CrmtOe7D89Xky6j9FuXiQ0yEqeaLp9dqOTRYe1Fzo9ChV4Msq4HSz0fDqg4BNDWMD+ae15kiMyf5t6k9IT6eqPS3SghKREFQmAic5ylCN9FOtelrQPukpu+BYuqeSP1QhvDQv2lVFS2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552738; c=relaxed/simple;
	bh=tZbqn7QM9RbOoMWa0G7YttqJY8eHU/CfAvSbBnOFDUs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVSfPHrD+pRfdMu1MPlicuTvqalhjhUblosT/tR6wed8spTaQVjFAEAd0HautMhHl+quH2IKUFXZzQTZp2ifwj+KG7gRlOPl18E/hzSzNc/nPOxnA0xva5YYrVLY9zUNVxqw7lSg9m8/jLy/qnam0o1QUTWf0eKGOaTDcYtHFs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLEr+xVn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLEr+xVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768552737; x=1800088737;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=tZbqn7QM9RbOoMWa0G7YttqJY8eHU/CfAvSbBnOFDUs=;
  b=cLEr+xVnjEVOCqj2llwGStxmIjRxoHnI67v/ZzgMcxixypMglfAmno+S
   txrLSWXMiaPhul1wyXX5g8dwy/RfnAR4hA7P7bzcTvol2Yw48uCyEhNE6
   nTuoLFgGLrVg3EGi3I6gp/Xb+zqXpPCZGBdoKB3PjCXVS5Z0r6hP5S3tR
   SYnd/55AMPHsPPW9KT5TPU65X3CDPtT4Sk7jE+FhupbCRglosJug7GNPr
   4Ef7u0/IGQnkYS062RvJgOBpfXOTyOISS5IJZn6rNnoozJXP9p0KYQ0OI
   wswk/mTfEED45d7t+vakxkOrjeXxtvoNEbaOakzbcKZ4xTtDvom8HF1pJ
   A==;
X-CSE-ConnectionGUID: J5Fjf5niTYK0UUy4y6lFBA==
X-CSE-MsgGUID: AVqiztFtSGGczQUpY6VgLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81313795"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="81313795"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 00:38:56 -0800
X-CSE-ConnectionGUID: KVvTMd46SWyaEINkA8nmHg==
X-CSE-MsgGUID: NoysSIJUQ+CbxFQGZx9FTw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 00:38:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 00:38:55 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 00:38:55 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 00:38:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+x5mSQ1PVa2XUUWZskbbZJTlPilK6WcbW5U4BDFdUaZFTufNuE2o6QxLkfxblWH2LZGBI4YW825tW6p7/rJ8OUjNkO6OqZ8XGnsT3GPlbQQMe9j+VfWUKp9bXQ8jDklaGzvV4PIz7fKO5QE8eTKdHZ0NGTAT+NC+raZa8rohaGY2IgPKNsZAPWm3wnLm54vUGOAWZ8GKadr+7++saBx8hU9kqAFqznbg9ZY8WWui5sZbJ0qNhPJ1vt8HcQR3nW/ktNOPBn4k08qDqrWQ6kn0X9RQmXGttp5lxL1Mhi/cPPyGFFmR9X6WlkZ+RWOsOK5vGKO3IkHSgtqycl5lqYe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2/N0D82+f9mu28HDq1FgxVLqR0O1wb/n7mbTIkuuYg=;
 b=jgCXDTFWPQonCk7WmMZiPOU2e1MRQWNKN7zdiKsgPTjbtyTycL2BkeMpUsyLLxEMjGHiFsEmMfPJCrlNQExoX/BWM0KON8y+Gb400SKYAImkg1D90X8L7pkbz46RiAIFOQQhuIuxAYNrruc4+vo+vGxWjeCjSaDXl2BSdbtA7fFovO+3kUycOBAlePK88KEFOVLGjBgE6NJ5IyaUV0kgVSDsPKfvZ/3DIiy0E0I4EyufpJWpNlx6WkYArPcAIPp0tBFGAsb9NBgiRvl6NM8O8Ad9/XL36SICeMx1QnRYuWfaYemBFdm8zJAQ/8+phtvrpd3nzT2QWP9Xz1CRe0GIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB9461.namprd11.prod.outlook.com (2603:10b6:806:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 08:38:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:38:48 +0000
Date: Fri, 16 Jan 2026 16:38:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: dongwanqiang <dongwanqiang2021@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <sched-ext@lists.linux.dev>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <tj@kernel.org>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <linux-kernel@vger.kernel.org>,
	dongwanqiang <dongwanqiang2021@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1] sched_ext: Add comprehensive selftests
Message-ID: <202601161607.7b263d0f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260113083231.1650001-1-dongwanqiang2021@gmail.com>
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0b3d56-d51d-4b94-4fb8-08de54daab39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6WDwhtF1eMxZdM5Y3oD9hW8crt42np1/PGM8PEoAe47/s/vJzxrSGp2e2bDl?=
 =?us-ascii?Q?8DxpAjRUUrNz3tWY7rbwoEPK5TsipLBTK5XaUe+uAW+4KqAAr9BZoCktu/PD?=
 =?us-ascii?Q?WaRi2orKfbFk/74LEJRzP85u9A9RfdS6s3+9UedEAyEh6kT9Eu8hBQd59z6d?=
 =?us-ascii?Q?A22kCIuWqSOJz4DJKSU9ae3ahYhdcRR4j4B6zI/y0YoVX6tMUpAl7YuJYb/q?=
 =?us-ascii?Q?DuOrpCJDvyESRYlK7cCeyVPED8FIBozkXb7R4PnSTT9xlhEmGJAD0HG/jerm?=
 =?us-ascii?Q?WxGfWXOjXF1f/YwMK64p/ecDCUOUlkd5r1bKlCO5CDKHwoxIObmIj7wtnb+G?=
 =?us-ascii?Q?FlaOAlxbty7cwfeVHE54NvZWOD0AJ24USTEg16gmx4CMCdAlIThOr7A128hi?=
 =?us-ascii?Q?x1Vyr1TNFImklZb9VuXnLCBbifb+iYi1xVnFn3BCP1+rqmLACbEWqYnMY3p3?=
 =?us-ascii?Q?suGxgIwVlocSShYJrQsdkW3FjNC/OW07U9b7GQV5B2VIdBNyFrOPbTxMWaNK?=
 =?us-ascii?Q?OgP3OJdAB+UH7iba/2RyJQ5fhcTuNLh5Hgk8tfMTjsfn9enBw0T6W66CizaO?=
 =?us-ascii?Q?1y7nyr/lnD3ABCq0z1Xj8bBu1mvLlyXtQ6jRas0P9tKHDI/yWKdO7nzuN8+V?=
 =?us-ascii?Q?0FqrdAyOWYJJHzgisGDGCFaRjTCZBDX5aPwYaBT4Q7Ln4VIJhvS2l6rOYDKG?=
 =?us-ascii?Q?RPvIE02XRVYODhCrSzOzDxRMabvXxTMa/f2b8bKmdM+ihUyDtJq1+d6eSZUC?=
 =?us-ascii?Q?pBW54aw/Em0dsjN/+uNKJUZgWvBJSMOlyNNHorxpdu6LG4nK8GYWY08x478Z?=
 =?us-ascii?Q?KyRVjRzMHAdjadTUiFYKb1jTJxTqmaVeK71Iy44GAkaaO0n5WL5hzscMMFzn?=
 =?us-ascii?Q?FW/A2afDeblGHXM9Ga7n/YfL016oWVFqxzMay1hV5MJT1xE7zPcYHaJX4SuL?=
 =?us-ascii?Q?duehbokjcoO8bARuYUy5ARa07BYPI2z7MTO9vJ6GAA8HWPCVPiKDcvSU9Oeh?=
 =?us-ascii?Q?BZayh90O0fp5QYzITzg+HcG3n1n/S/afiaE+dghdLFCCEuRdWrkRQsx1lUlX?=
 =?us-ascii?Q?feTt9PjaWg4IoNd9gYZNnIEOn4AdOtaW/xGvnDuztKvaeYHRj/MLLWOhMk6c?=
 =?us-ascii?Q?oykT6Dk8SJcGi8R+VfAF4tFmsnc1LbGn3LHRU2I+ckO67+2TYoIXgBuI7gQM?=
 =?us-ascii?Q?42erJzklLlJcaFLSoCwYBE++wD5glwIlsqPPCheusljXNFYBZle6/Q/VNTd2?=
 =?us-ascii?Q?IemZQe7C9o6UHlviuyAy0R+RSwhr/pUARt3HZnuWb45onsNZXAtd1OVZ17fm?=
 =?us-ascii?Q?vdatdANGiv5TRp3XMl0rF2Wyj9FoCXfP2anO4OlHZgkiNm62MW3OaW7kayU0?=
 =?us-ascii?Q?+ucJHFgkTIFBeSqzrCVV9v3ix4kq0dpLV/kvFp46hCaDin6bww4tQxcqeutB?=
 =?us-ascii?Q?vLFyx4mNd3N0x6ysER60NWqM+EbusLp4B7iMvnl7wAo+/5Z9MSEQJwVRfSpJ?=
 =?us-ascii?Q?AwX1CsAb7G5CtWe8looUdWXOiZLMFxKF2wB4kvi7uOW7ft55RP404W5kg4uK?=
 =?us-ascii?Q?NuCcm1RKrCxTFxhJg/inUAIsovWk4otHfMOGJyim?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6ulaLEN5xoSmdiL7oF0YnH0YZzt8G3OSAWbgpH9whi4HH5G9aTXXodj39lD?=
 =?us-ascii?Q?Bx4x12smW7sIW2ibmdi0eepv5UnvASd3lO+gPZ7GWuPeEq7mm1s0OYTsMJ3Z?=
 =?us-ascii?Q?jXHayO6dPt8u6ngsZ87c4UkqkwODt6Rz7/hBVi1aN5PKyNNJfb9cdjX+dkrL?=
 =?us-ascii?Q?tagNxn8N4XW/P6bzGZ6mYXKduQJHgG4Azj0RR00ixDIWa/xhLGj0bL8KpSxE?=
 =?us-ascii?Q?SrQ3xGTcKCOjXtnPCHIFbVsW5fU2GrtJIi5r/N/zb2kKEn1ST3BqxxKkmT4w?=
 =?us-ascii?Q?SY6KkegMY+9aR3d+EVeZm85Xy/Rq5LdGRuCQ6wQO7ZKlJ4MxqgArweJuPEYy?=
 =?us-ascii?Q?riJDLu/9bc1lK70mB59ZBnSlJWjQAys382y6O0YMXiuhcAsVR/CkSnD5x7mm?=
 =?us-ascii?Q?69x1v+abU1rasZNLF2Vg6XiaO8yJ2q3A76PES2rF6KY2nG7J5pD9dbFXCsqQ?=
 =?us-ascii?Q?zwcQ0I8qv6u/tKG6eDnwYAxe2gjtIZVJFJyoz+gU4pDCMIKY5s8vp5qqIIQF?=
 =?us-ascii?Q?yx9lDqvi/GD0iUaOCL8u1WwvlcDFMurfx/NNESkvhgRO3AHheJwYnWS82mR5?=
 =?us-ascii?Q?uPbSNhTbJ5mnzgicXNF+RuKCZvizwyB54JyFgy7eugihvQql0JXUe9W2VeOO?=
 =?us-ascii?Q?sic91O4iI5E9QKzFvw0RjNS0Ttt5L5Tw1HvTbBvYwpzj16etzRG8XAwg8hkE?=
 =?us-ascii?Q?w6YtZmpjbdtGpDWBDIfm6F56M4hB74cPdnXJCcphyZrNgDk5TjUcKfzg/q8G?=
 =?us-ascii?Q?vnBmN7AI9pKy+rSf7el6R7ATEhaB3kWsqbwBlBU6Vor8Msq7db9nxHMjlWkc?=
 =?us-ascii?Q?YDUwPpN4qlJLjr6hxZuG9Rq/ZmKfhl2iJMTjplxBm5NfgXmXt8bvkWq96mLQ?=
 =?us-ascii?Q?ODx3u1LN/NhO5sUH0ZzYn4CAREjQEK060YD9EaPpJo3f5+Dx9t3R9Ik+VDcV?=
 =?us-ascii?Q?DgMXVR524NQRYj4LBjNrGX4ZKbUTajO5ZEAGpXHT2z2ocD+C955NExjlQ+So?=
 =?us-ascii?Q?8MD0RkhaR7LQqZWXKk3AMUgarVJ9+hlCKeqN32uC6IlaYb8qC0JfpICNPhpc?=
 =?us-ascii?Q?2bjnfdtYgD4D2I+XRF9Ew30eV+TtQzsbh84CMdo9utRm6IDWW0J1ib6yjkqe?=
 =?us-ascii?Q?cKKmYxN2CKZVKd+6a9fV72UXwArfjNG2ybx4pCimelb3W1ue4C304YhA5LIp?=
 =?us-ascii?Q?tvaLwqztKAiQGM4QnrXIjbbaVWMdp66vTGh+NMKW6U0jekNEWcRUxdEZU2EK?=
 =?us-ascii?Q?mg+NILN9UQeQH2qk70cdjGTCFP/OSCRL8CpceD8Sro6w9Y6C4Ztqs8XfJkxZ?=
 =?us-ascii?Q?kbO9XwajwI8fBtXLcK3nfP1nsLOg6eQGGWuq+N5ykFK31Ed597/ZrPemZAMT?=
 =?us-ascii?Q?3muZbToMV7EfqPx4Sq/J+9eiqyqYZfI4lVN+8/cC6ESruarIW34dO/EsFDBJ?=
 =?us-ascii?Q?IVLdc7fdiuwiCYFiZ4xfgPjL3IJIw6PrGbbTbreYi7QZMJCSRdeDiXwvNJyu?=
 =?us-ascii?Q?VWBS/9v06TSy6JP4VbTWIoCuK+i1UObD7oD1afrsAG3qF+UvFm/ANBZludeC?=
 =?us-ascii?Q?CZWFJhMCbpfDTer7OOkpAQoRGCe3Ho9L6VE75C181wQirZpJEnMdEHOus9nb?=
 =?us-ascii?Q?2GPNz3xYz+0DyayEMn6H4UJncAmjKBtVif/qF8jFm+92TFKssKgw3X+9G857?=
 =?us-ascii?Q?XSFw2CJu+X/8fI3krz9y8tXykwRWOwUnF//ygjsE12LwVb1qesQ4l6vxlVmd?=
 =?us-ascii?Q?Ex9glQAP6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0b3d56-d51d-4b94-4fb8-08de54daab39
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:38:48.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1eSMPbaN40FaLyhthOJ16f/x+EFLIj9uWymMBOxCJ1//oO1f1bENuRp3rLDcQXx1F8uqkU7A+OhY3jazj4IhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9461
X-OriginatorOrg: intel.com


hi, dongwanqiang,

we apply this patch upon 86063a2568b8f2 like below:

* c3c5a73eb6ed69 (linux-review/dongwanqiang/sched_ext-Add-comprehensive-selftests/20260113-164727) sched_ext: Add comprehensive selftests
* 86063a2568b8f2 (shuah-kselftest/next) selftests/resctrl: Fix non-contiguous CBM check for Hygon

if we should pick another base or the patch depends on other patches, please
kindly let us know. thanks

below is just FYI.


Hello,

kernel test robot noticed "kernel-selftests-bpf.sched_ext.make.fail" on:

commit: c3c5a73eb6ed699262df440942d88f23cc9f10e9 ("[PATCH v1] sched_ext: Add comprehensive selftests")
url: https://github.com/intel-lab-lkp/linux/commits/dongwanqiang/sched_ext-Add-comprehensive-selftests/20260113-164727
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/20260113083231.1650001-1-dongwanqiang2021@gmail.com/
patch subject: [PATCH v1] sched_ext: Add comprehensive selftests

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
| Closes: https://lore.kernel.org/oe-lkp/202601161607.7b263d0f-lkp@intel.com



  CLNG-BPF ddsp_bogus_dsq_fail.bpf.o
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:89012:2: warning: declaration does not declare anything [-Wmissing-declarations]
 89012 |         struct freelist_tid;
       |         ^~~~~~~~~~~~~~~~~~~
concurrent_pressure.bpf.c:104:24: error: use of undeclared identifier 'nr_cpu_ids'
  104 |         if (cpu < 0 || cpu >= nr_cpu_ids) {
      |                               ^
concurrent_pressure.bpf.c:164:3: error: call to undeclared function 'scx_bpf_print'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  164 |                 scx_bpf_print("Pressure test completed: %llu total operations\n", 
      |                 ^
concurrent_pressure.bpf.c:164:3: note: did you mean 'scx_bpf_events'?
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/sched_ext/include/scx/common.bpf.h:103:6: note: 'scx_bpf_events' declared here
  103 | void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
      |      ^
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:108246:2: warning: declaration does not declare anything [-Wmissing-declarations]
 108246 |         union pipe_index;
        |         ^~~~~~~~~~~~~~~~
4 warnings and 2 errors generated.
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:120240:4: warning: declaration does not declare anything [-Wmissing-declarations]
 120240 |                         struct freelist_counters;
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~
make: *** [Makefile:136: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/obj/sched_ext/concurrent_pressure.bpf.o] Error 1
make: *** Waiting for unfinished jobs....
In file included from ddsp_bogus_dsq_fail.bpf.c:7:
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/sched_ext/include/scx/common.bpf.h:21:
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:52185:3: warning: declaration does not declare anything [-Wmissing-declarations]
 52185 |                 struct ns_tree;
       |                 ^~~~~~~~~~~~~~
4 warnings generated.
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:89012:2: warning: declaration does not declare anything [-Wmissing-declarations]
 89012 |         struct freelist_tid;
       |         ^~~~~~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:108246:2: warning: declaration does not declare anything [-Wmissing-declarations]
 108246 |         union pipe_index;
        |         ^~~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext/build/include/vmlinux.h:120240:4: warning: declaration does not declare anything [-Wmissing-declarations]
 120240 |                         struct freelist_counters;
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~
4 warnings generated.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c3c5a73eb6ed699262df440942d88f23cc9f10e9/tools/testing/selftests/sched_ext'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260116/202601161607.7b263d0f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

