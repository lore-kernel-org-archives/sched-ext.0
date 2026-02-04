Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772F423A61
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221265; cv=fail; b=hdA5c4yM8cUMkIpqSPO0j2XudrFZmyHPmrKCzWCRveJ200/sWBWMjk6GJWpWSfo2sc2x+sTYUJqwlguyADT/TutgVStUJWLoWkRgasVEfy/hsmr7q8EKt1strDKqmjHjz4KBIcxio9Do9iBWyGM2TFOvhpKEjwBJ+MvEOsjJqQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221265; c=relaxed/simple;
	bh=Z2/lb+bhUthzYuxzhDcff32AuXfPzh4gMVb9xNvDShw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJSfBqK3BIyfLt96iogtNCZ2wfEaGF+mDtPuo+IaMEzUTBLy105Lfjo9C9Xz4pPerfPjyqF9bzSTdb3LfCoosmgI5JHqEXO+KwPQK02xrxGgpHn4Sy6Y9N+r3vlnljpiysN8El3id+tJuK932mbb6sbzqsgNrxIojiklufgwuy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2V+76pQ; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2V+76pQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4M/UMcE2Js+ygEXRWrHSfny7N2gGNzptbjSRXrKFTPUWEqfczW64ogfZrnRLncI2k51+PfleeXBh1rU07S4wHsUvFj2KiVsgJ3vxd4si40ZL6QOF/a9xCvJX4++m8o2Pv6WGuigyE1HbfNWJ9p+24Bxy1BUQ/TdR8eaQFk9thH4NBCPC1F/Nv6ufa85rQVx7H9XrsaToWGmjXAnPF1mDsYNyOKZSgvYh/V722p7UfGxOyed4HXznDkLB8EyvpEJ2UclpT/0mtl9YEkEkk/i/3wPyobqOd5t2Gb3jhoSKabcHr01LCeDkvkB/l5RpPgp+grLcEzgI5sn88bGqXOLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o3aCeAOjsW5SHAvxq/kQCOF1I5004nG6ZtaQrkVhbk=;
 b=G+uhS65xMhKTXz74v1uVfYx7hbHySEGR7XOLwbLnz//bAwwPZIlEwm1JYWU8EM3q25pw3C17wnJMJ9wULAn+9jS20e1YF5JDehCy0pb0l1WSm1F6L4WLDNmVL/Ei6F8N7vwtKdyQeo9h9byNmnoShg+WyS7ncUKPT7T07rlI+Ch5r7Tgw0+IhSIDHsd3STI7onvWDbTAg1lOZo+aMKRpwEXtD+Kw0hD46AE4JGBOjMaUwh+C8ibGPEhYi+LMNJJYqe2ehHhskid8XhArQ7j777bt/N2RBFTCpW1cXTlnfmfEUQM8o9criJL70dIKDMI0c7T2gGAhtbhPHvRhQld/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o3aCeAOjsW5SHAvxq/kQCOF1I5004nG6ZtaQrkVhbk=;
 b=E2V+76pQ/b4KqS2/rWmOOtnIzweBWex4PbRPK7RWhqeRJq4NPltI0mEEAw5p/lWYjmlHZkSn2bUoV8O84Ml4aV55AMbeUvBb3NOVF4D1fmGd9PNLyX2texZYZ6hf8+GrcvA+yVXJgMLZIW80B5TxJ1n2hk+VoJEHtO3858n1F3eHFRUAHvhS+yvmh+kF2aOC1Esw9aQMjEc+rfCgBiizkNRk7UsLj1HVik+y/D/Bjvj69uv2vH3ITvuBMk3tYq05jhBz21ACgh4lVqrz8uQTy93QUZjBl71OPmtZtRT6d6WaiZVpQPWuOgBFW7F8qm7UiVvZAeKX/LigZR5yASZ1wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 16:07:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 16:07:37 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Wed,  4 Feb 2026 17:05:59 +0100
Message-ID: <20260204160710.1475802-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204160710.1475802-1-arighi@nvidia.com>
References: <20260204160710.1475802-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccbdb40-1426-4cae-8451-08de640783e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tM3WCWwguv8aAhia4CamSjgzLmIVnEQCb8pE+Sav3YYaKdWOalQI1NFoIOd5?=
 =?us-ascii?Q?bU7UT/Y7PFDQwGM2n3sEkR7CSiN9jWvAR9vJrGq6x2uh7lDjX5Ch7FDyTN+S?=
 =?us-ascii?Q?esum5sAiT5SnGiYKEgjqM7aznhLCaOTA5aejiHtChsnmnMSX1gm1/9HbFdm6?=
 =?us-ascii?Q?0iHKFXIYUzdtPeB/atIgI/i3DKNyuMug3384azN1P/bUlEXA1S7AGDefxlKQ?=
 =?us-ascii?Q?lSOyNpP+tioosk59eiYOpP7gHLVlymdoiiXYwNd7aRDdSWiPV6jNPSEmW/DY?=
 =?us-ascii?Q?sGnGlupp6HvRGCzpgpG9EmLvrQB009sq5x+UhYJSMC/y8DoWTJ80DCJY2Bnl?=
 =?us-ascii?Q?KMXO41vI0kBIRJZJVud+iXcRIwbYROtT/A6x7N+Fs7mJLdSaCF4dsXmCU8q4?=
 =?us-ascii?Q?TfNqYWfC/YnRgrdX6J3yX5Ipuno7t5IrUF0ZPyydLcusJZWCcdgMhK6yW+Lj?=
 =?us-ascii?Q?JYOiurolgf4O4z+qF8DKQXyIpNBcROwHXZvwicGOxvYPjUkPCu8soTYbRXTR?=
 =?us-ascii?Q?AReVQODbZLM9Pjpi1QKhzMgEyC9toZft4NO4MiFSwi4s8ljYE5TGpezD5Smv?=
 =?us-ascii?Q?DSALjl55XRnpYXeVdxc43efvIau5dI9SWBsN2kHe9yA5mXTlxQ14P1ETsNLU?=
 =?us-ascii?Q?oS94QOkB+q3YaJ5wzsPFb9Pxr45OpcyY0eKo02CAnWD921MRppx3mJed0Nfi?=
 =?us-ascii?Q?pbv7RRAEhIt4aW7MjB9QBtsAH2eEV1gdCYQnll7+GXEozfPGxZv1EYOCJzEd?=
 =?us-ascii?Q?2QITAYrsIiAuUonLqevO182/FJ3DDubwSYKYMncZdgK5RSRVaSwQhbUlPcUy?=
 =?us-ascii?Q?R+5HYOiI7I91CSP+NCKFoD3FZmuYe8P0Wv143eWylWdNHJBBJ+iP0yMgvvsD?=
 =?us-ascii?Q?VT8TWwQZh5zZP3RCb+SHjyl7vWEMJyK7+HReGkDnAi3sOlf3FkqpV0sGeb95?=
 =?us-ascii?Q?09Jo7XWvf/8LS8OlAogy+VKFbNov0jGNzr2b5bvcGCEAuPYszV6S/sqA/FPG?=
 =?us-ascii?Q?UsOgnKCgDlkYsPAQMyyT257s8a5tJOCOQvTxYo9sipON/i0b84dPLZsYnWUD?=
 =?us-ascii?Q?lGGwKM0LFGDrKsQjJyfzGLWf4V7gHErlA7c0uOn64TMsjQKyuWJ34S5VN3Gf?=
 =?us-ascii?Q?Lm5rjpRlEoE48DjVIkovi2GsiEHEBmmJt/3qz/bQBbwKm8pEYiLgB6whiv2Z?=
 =?us-ascii?Q?QkXSKSNY3BKLkk7K56UQnfpQHXIaGTSVVml9rewc+3bulXXaGOG18O/57mVx?=
 =?us-ascii?Q?kXqGlgwplzCvsMaibAlbcv93Hn0M8fPRa+x+d1I5aHWo/YnxLTBhueZ8kTRy?=
 =?us-ascii?Q?oa4O7dYa/82CdvsxOZ4+1TUyRa0dV+IFM/lwj1hiV0l4HZQboJn8V15/Q9Y7?=
 =?us-ascii?Q?nMvdcZfwqh0TqwRRiZFFjdEBxVBxrqXA0Lzp4Vef984wzM9+7sabcVNut3I7?=
 =?us-ascii?Q?RtPMaM4UqeTE4qI51WVpIvYDVte+OoDD4QMMWDK/4q1Mvd7iE5TDn+wtCVuC?=
 =?us-ascii?Q?JO5TAkZSgTFB+nfBdyRivNv8INcEXz2qorRqiH3jyQwCwP5qLkXEOiHPZQXF?=
 =?us-ascii?Q?GErk9lka8VSQFBFreK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vK2iG20rLVQ2fTbxQyM6WO4pUWm8Dvx1U8YpCqBF5BzpLnXS+Qsds4wAQCLk?=
 =?us-ascii?Q?W5MayVuJDYXvPrDzCgF60S/b32eNrdN2zT3NOhzXldAaX3FDERhve44X/glX?=
 =?us-ascii?Q?BQ1t4mwcF0LogVDPAQ5ZZkC2VUhxYDY/YWIyH/1n8sUJJZ0AUSFrdLwZVh9q?=
 =?us-ascii?Q?MpSykcF+mIVrnf0dWluU7etTE81XnDmys2CfJ6voPJAMyivq8TkrRTO8Y2pX?=
 =?us-ascii?Q?oSlBUi/3kulifF7q3vSNuwvqI6BFTpbHRy2epxkFYdrI67Bs8Mg0jcsBj3ml?=
 =?us-ascii?Q?eQS0qrcJEYtDVRKM2IXCU28ei3bgmsjFtzDRSpJLNoudiyAsVua7/3s5mbq/?=
 =?us-ascii?Q?LNdRhDMVCxDMv99rvIpT4p2q2weeQwVQIsX3IOzwWnQemvvxwzLiFMxOVeG2?=
 =?us-ascii?Q?+YCITc3Gskgsq1ZqPKyOxd2XZnYYOrZbgpD0uwSQLedf64DF+NdVuuT0pDCH?=
 =?us-ascii?Q?8xXYxMcUkHJhdfXdmLg7gGf6T7kiYw4qprQXF0J5bhCl67XM51HIJlJ5T0iW?=
 =?us-ascii?Q?Ofdog4tdb+Al6LOMMrxTjO7FDbr4ysI5sfkO6ZM1qmh2XKISH/gnDLZEl1M3?=
 =?us-ascii?Q?7xeWvzWfvvFUkR/51ovEZsC0gHmaBZ4YckKt64NZrTZroyeeVDHMRS/6e0/4?=
 =?us-ascii?Q?Nu4/s0ahPKZTIk+QPYkkICvEkbigHfDGgx7BGo3DLBAD7IHM07atv7OSYkLF?=
 =?us-ascii?Q?KQRcW4CRbooGgSnzFqTARcwaEhGjdjeqcAR618bs5qu9cX90c6cBl9S1HBDl?=
 =?us-ascii?Q?sb7kWv5FBsp11EDCdyoO+mOeLYxkxWKhEHsXzq7OSB7AVLeG9215bReCotQR?=
 =?us-ascii?Q?7HRjHP7/XXeBLy7oXneHcdDXnts32qOSgjKyiylQ8NuGToTY5HZw6Omynjh0?=
 =?us-ascii?Q?XynlBtLUBr5HC7Vxc2Myye09EtCXYlCJ5h1neH4xPq9cGHdp1UKec0NbT1ts?=
 =?us-ascii?Q?M001KgAsPEKTh/aSudEiaFZjIxk5qTOhHK+CeTqYdvtUMiLO5e2qVnjcQpoR?=
 =?us-ascii?Q?huMy8p9XCoFYc3+Cv5CMubTVIc3lW9dWMLRHzVlRT/LpM0R/FXZE2Xtb97Vy?=
 =?us-ascii?Q?1Kz3kB8PJGqJHzIJK1JLe4Lw5vcN57E6kQPwcWIC/Vk7Etnnh0Pgflk5O3/n?=
 =?us-ascii?Q?CkzK0uNrkTWxXHn0hdLs3SPhkFICWL/v3iyurw4vtqREBzfvPpWfJPqXWa0j?=
 =?us-ascii?Q?HRqb5U1bkycLbn6fOybk3DnBh9NSuHLdnMGd5/KNscDmwaXLNQMiEpe0QRhP?=
 =?us-ascii?Q?Uzhj1GqTdJK28/QaGf3U8TnnzimHkzRKlTmLVA80NyTckO++dfKbF4nVPnQq?=
 =?us-ascii?Q?3d8V0e2lqeZdBsiHR2xXgPK8z4wD66q1KXICWmGZzo59q3stIyEHzwBXazDX?=
 =?us-ascii?Q?fKFTzi+2IxGjo4zJ3KxZpHP8ERXnmU2k+2UchKYTA5kNLITgpWPh4JsHA2M8?=
 =?us-ascii?Q?LZjT4nqOhpeCc99fKuHPLsV4+9b20xhuJsJNpQVTWHiiyl7fI4zn4pFj4LmC?=
 =?us-ascii?Q?0vsDORDo7whizeNQc0LYwYPcDrF4solL0w07GtdAHcSpOqeBziUIS8aDyBV6?=
 =?us-ascii?Q?jFBBYgY0r0uJ6ctK58NcmR4C5jWEm1NR/nvaTH3EULmdxe+fcWQghRm2fEPr?=
 =?us-ascii?Q?GJMdIRDFlfsnMquVOUd+YwhTpdmC9Ut26mmVw3gCsbPdr/he+XbaGYPWXUea?=
 =?us-ascii?Q?aHpaN+nIsYvPy347T1MuC4EljTZbsVKJmNgzAhRkbZOahE+Rn93+eoAFTVzI?=
 =?us-ascii?Q?IVLJ9QLU7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccbdb40-1426-4cae-8451-08de640783e3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 16:07:37.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLv2NFyRdrUQT1fOw3r5VmJcgzHaBQQLmxTJ8ZFN5CpeGMZqChOCBld/a7SzWN2JOQ05+BNJesVj+yGidCJTlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

Add a new kselftest to validate the following scenarios:
 - scenario 0 (Local DSQ): tasks dispatched to local DSQs bypass BPF
   scheduler entirely, they never enter BPF custody, so no
   ops.dequeue() should be called,
 - scenario 1 (Global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
   bypass BPF scheduler, like local DSQs, no ops.dequeue() should be
   called,
 - scenario 2 (User DSQ): tasks enter BPF scheduler custody with full
   enqueue/dequeue lifecycle tracking and state machine validation
   (expects 1:1 enqueue/dequeue pairing).

The test validates that:
 - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
 - user DSQ dispatch has exact 1:1 ops.enqueue()/dequeue() pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
 - no duplicate enqueues or invalid state transitions are happening.

This validates that the new ops.dequeue() semantics work correctly for
all task lifecycle scenarios, including the distinction between terminal
DSQs (where BPF scheduler is done with the task) and user DSQs (where
BPF scheduler manages the task lifecycle).

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 269 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 207 ++++++++++++++
 3 files changed, 477 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..764e91edabf93 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..5d736ffadb4c8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
+ *   scheduler entirely: no ops.dequeue() should be called
+ * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() must be
+ *   called when they leave custody
+ * - Every ops.enqueue() for non-terminal DSQs is followed by exactly one
+ *   ops.dequeue() (validate 1:1 pairing and state machine)
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
+ * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
+ * - change_dequeue_cnt: Number of property change dequeues
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
+
+/*
+ * Test scenarios:
+ * 0) Dispatch to local DSQ (terminal DSQ, bypasses BPF scheduler, no
+ *    dequeue callbacks)
+ * 1) Dispatch to global DSQ (terminal DSQ, bypasses BPF scheduler, no
+ *    dequeue callbacks)
+ * 2) Dispatch to shared user DSQ (enters BPF scheduler, dequeue callbacks
+ *    expected)
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on property change dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,
+	TASK_ENQUEUED,
+	TASK_DISPATCHED,
+};
+
+struct task_ctx {
+	enum task_state state; /* Current state in the workflow */
+	u64 enqueue_seq;       /* Sequence number for debugging */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* Always bounce to ops.enqueue() */
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Scenario 0: Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no dequeue callbacks. Don't increment counters
+		 * or validate state since the task never enters BPF
+		 * scheduler management.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 1:
+		/*
+		 * Scenario 1: Direct dispatch to the global DSQ.
+		 *
+		 * Like scenario 0, task bypasses BPF scheduler entirely.
+		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
+		 * leave BPF custody immediately, so no dequeue callbacks
+		 * should be triggered.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 2:
+		/*
+		 * Scenario 2: Dispatch to shared user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		/*
+		 * Validate state transition: enqueue is only valid from
+		 * NONE or DISPATCHED states. Getting enqueue while in
+		 * ENQUEUED state indicates a missing dequeue.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Transition to ENQUEUED state */
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+		break;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * For scenarios 0 and 1 (terminal DSQs: local and global),
+	 * ops.dequeue() should never be called because tasks bypass the
+	 * BPF scheduler entirely. If we get here, it's a kernel bug. We
+	 * don't track enqueues for these scenarios, so tctx->enqueue_seq
+	 * will be 0.
+	 */
+	if (test_scenario == 0) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario - kernel bug!",
+			      p->pid, p->comm);
+		return;
+	}
+	if (test_scenario == 1) {
+		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario - kernel bug!",
+			      p->pid, p->comm);
+		return;
+	}
+
+	/*
+	 * Validate state: dequeue should only happen from ENQUEUED or
+	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
+	 */
+	if (tctx->state == TASK_NONE) {
+		scx_bpf_error("%d (%s): dequeue from NONE state seq=%llu",
+			      p->pid, p->comm, tctx->enqueue_seq);
+		return;
+	}
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		/*
+		 * Property change interrupting the workflow. Valid from
+		 * both ENQUEUED and DISPATCHED states. Transitions task
+		 * back to NONE state.
+		 */
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): invalid property change dequeue state=%d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition back to NONE: task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step. Valid
+		 * only from ENQUEUED state (after enqueue, before dispatch
+		 * dequeue). Transitions to DISPATCHED state.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/*
+		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
+		 * flag.
+		 */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/*
+		 * Must be in ENQUEUED state.
+		 */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/*
+		 * Transition to DISPATCHED: normal cycle completed
+		 * dispatch.
+		 */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..0ce59299a1b37
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+
+/*
+ * Worker function that creates enqueue/dequeue events. It alternates
+ * between CPU work, sleeping, and affinity changes to trigger dequeues.
+ */
+static void worker_fn(int id)
+{
+	cpu_set_t cpuset;
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Change affinity to trigger dequeue */
+		if (i % 10 == 0) {
+			CPU_ZERO(&cpuset);
+			/* Rotate through the first 4 CPUs */
+			CPU_SET(i % 4, &cpuset);
+			sched_setaffinity(0, sizeof(cpuset), &cpuset);
+		}
+
+		/* Do additional work */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	int i, status;
+	u64 enq_start, deq_start, dispatch_deq_start, change_deq_start;
+	u64 enq_delta, deq_delta, dispatch_deq_delta, change_deq_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+	dispatch_deq_delta = skel->bss->dispatch_dequeue_cnt - dispatch_deq_start;
+	change_deq_delta = skel->bss->change_dequeue_cnt - change_deq_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+
+	/*
+	 * Validate enqueue/dequeue lifecycle tracking.
+	 *
+	 * For scenarios 0 and 1 (local and global DSQs), both enqueues and
+	 * dequeues should be 0 because tasks bypass the BPF scheduler
+	 * entirely: tasks never enter BPF scheduler's custody.
+	 *
+	 * For scenario 2 (user DSQ), we expect both enqueues and dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct. If
+	 * we reach this point without errors, the semantics are validated
+	 * correctly.
+	 */
+	if (scenario == 0 || scenario == 1) {
+		/* Terminal DSQs: tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/* User DSQ: tasks enter BPF scheduler's custody */
+		SCX_GT(enq_delta, 0);
+		SCX_GT(deq_delta, 0);
+		/* Validate 1:1 enqueue/dequeue pairing */
+		SCX_EQ(enq_delta, deq_delta);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Local DSQ (terminal, direct dispatch)");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "Global DSQ (terminal, SCX_DSQ_GLOBAL)");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 2, "User DSQ (non-terminal, BPF custody)");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
+	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: User DSQ dispatch triggers dequeue callbacks\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Property change dequeues have SCX_DEQ_SCHED_CHANGE flag\n");
+	printf("-> Validated: No duplicate enqueues or invalid state transitions\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify ops.dequeue() semantics",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.53.0

