Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDF233704
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959755; cv=fail; b=VXgDjnNtmB1rciee9tNq0h8z3xNNNiI9oJPY9NaifVgLv9/Akc/Ps10C4hqCMZCHq/luxBJscj6uwJFcbwqpJrEU47Lb0m60yNzt92UAz5zFwWHhun0RePpZnNfxNX5t7A2jygRTj2O+tQ69GEAZ/zAfriNHOOnROSoQEZvk23M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959755; c=relaxed/simple;
	bh=1FdUVfSt4RQISHefca2TB+7NxXrzIsbbaqLvHILldGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q78uu5yY+tqaeblJ1J1ZawKVtQLeyocOEN8yLiVoEcjjVjwACcw1JAvrEQcQ+gGxNLT8rPCS6FfEsrTA7ItyA43OpNeKdEwBff5KQAmpSaO7aUK+yKve8iXlJ+ISnqqbRElBj0dbNaIKreFzEW9UIYohLYEf0UWVkqGO7PpO7i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fEd7SrE1; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fEd7SrE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxnc4NIAECq15rHVBuxONKUrTfGy73nX1xWiKpbQkurqxBQCWEQQQDpL4HuuvODQ2VlM8vX3JAOQhmhpPbCh38SStfGDE2YUMpNtzCsCVHvMhcznezAcZhbGdYgAcgeo+tx4n9mWTvPlMFXBvjynC4YiNn/s9nh03NnI0Xq0Z108AgBZZogoGUMMSPd6l53vrtapu9FFlLf3fiEgPQr7jZKg8FaTT6oskGYE5Ytsa7YN/KRXtL8VlJvGhn/hR3a/p1zEV4gAdhqfI++cyRU6eUiAAPUtkfIJMENWvB+GrVVjXneiWlW6jq/wCEpIMtc4LK9Bbsrim3Jc2IImik2A2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=BNWicU0U5z9O6Uk0OIgG0lfuSTjRokgGweIvS1YfqMkeTJLVKxL/TONa5118wiDEeocSzNgFC1oBgQVpd0htkpDVJmAens+3O7hvXkh8rHXdYsCEKGYHFYhRM6MOA64Ajnq5HVFON3gqlUwOz1ICvw2Jp7fwOviSo/v++IsWiNzzn88+UvbnCaGKL5NmQGlburHiAsfbAbqVYxpT9JieuW9FzSVLzVxtj4c6uS6TgbK3yyNpGmjWF1qxvD60/+nLV2frzO3Ieb1JC08Wvp6EyM0UW3c9bG2jgEcjWkdtSDNP7NKoSv0fEJajxiLDsyYu2cIwug/tjJIgRRZU25k7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=fEd7SrE1H4swckRPVhMBjCcgNa1rlY+/ZOuAKx4fbEHf6M6x2FSRGiIczWHA3XSKZfclFmgC5BPCfAnDQYjJ05IoIrOUTKvWnarRWlP/G9opcsGDBRN0EH9K7j0Fnvx92KtswUOi0zlsUrklbh7JHcSlDSN1RcFSWpe5IbeKeJw/XD0+kgY7zCFY0RKMubXeV7e2mo29pUuN27704y77l4wdPMM+pmYVbfVmG2anXq6kFR2m7TRr7CkvVjQpcHkfd6XHolgChx9hE6Px5N4FniGApz+jXErUtUjLO/3RxnilkvJuXBlTlHNlXXQozV/nNF9ZZWbPnzehCKwAGf8FCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:22:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:22:29 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] sched: Allow enabling proxy exec with sched_ext
Date: Mon, 13 Jul 2026 18:17:10 +0200
Message-ID: <20260713162112.26785-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6794b7d1-8934-4c62-8eb9-08dee0faeef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZDAMzg7FwVW11itSiF523NyNr9daAyJmIMJVZSJs3enPo68j2CeLrIrUvfWMKiiuAgKaXG/ewJ+BIw/6PQw9kiyW/K0uTlZnplK36pugOt+/Z5RGXRfWZjEQcZ/TCMwgGafH76AjD3i6YuFJNuEDnNBzaX/5Vd+aTSdDLsCpyTLcnn4Dn2JvzwhjjEllZ1aQxiyBNPAJQPFHqT0oXE0r9d+B50Kg/8XAYkzJvoS6EzegNM5RxaC8ndAed9xXVUx4v7mXHzpetFewwBIl1wnJl5uoV8VDUThxIFNVSwGpIINza55N+zL4OP5M8IgzX7o/xuj4NbhIvIRpJaH12095mAXB8FSUvskhChL0u+h57MI+qw5Hq5f9pYmhuWJo65AJFcETuwcqboHiDw6FJrwETqKbhM2jeXD8FHJL09i1I04/N9twSX/DoLqMAMnVP7Pg0tcDSqvnbSbisO5Bue1CXnX5JFvNyRYWYUjPyMgEuSQ7BBkPnj9onBKZvPbx4aQMD83jSOkrl+iXtKrcVYF+4sGdlYFPTKwcFA2LRNLAfdo7GXixgbkqCZY92PdpWm8GkuK75W/W04f0+HCz+Y1BxqKYtvWxKWuqJ3+Lk4id7PFTBgVxY22Bt4jKviPOovqjOxCqJEr93bempZLUqLq6/64YiQEDvaSA8Pg6a/E00rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+hXbqQ0HPanov3M8Hv8u0MNtaNUoC8LRwog45G6ABF02J2jiiT+etehxIrV7?=
 =?us-ascii?Q?rhjOQbn+LfWfRM9izxcjZVXT9fDEvMZVpfLF4eTPmO+W91EE2j+hJJJNh0Sb?=
 =?us-ascii?Q?ONzErlF5UIImm5BftL6NRSE06F89d0l4Q5W70osTp0jObIhQD821V2THlzL8?=
 =?us-ascii?Q?sn1ZNyBs6YNpAguNh+Z015v6CWuKLj0wZ49t/4I1+m1qG9FWmMeS48Apb5EF?=
 =?us-ascii?Q?8M6fIxc3QtOoHWAE+D32LVC3q7YLO23c0CeHEpev0WQIlf2u4uhtcqpEN/4T?=
 =?us-ascii?Q?QYOxqEZ0qnJ0ZrPn/2IwaL+tjgFmgd/iadT2B/ybvP6HPOCZPadQXMQGBCcH?=
 =?us-ascii?Q?q7fJ2FxK7W/LXuNudNvzxB1Sn0dT7ai9/XcNEuOogY5ELEeQRwYJJtietWzK?=
 =?us-ascii?Q?25KmyrApSpQS+AVB7vQNbSOQfa/b7aENRG/1e2VEkxeSVm/suYCJiR/nj6Bv?=
 =?us-ascii?Q?3LV13cv3GLd8piLzcarrNFh4SsSxJRbzb/iDyHsfRy0PX7QoaPsO7XQygh8h?=
 =?us-ascii?Q?0rixdKQCZ6yXSP9r+DTr2cLDlHyLft7C/taK4uQy7hDgEz2oTd9T+BJ2fmMo?=
 =?us-ascii?Q?xsbBWqpufhRJRO1hc0VW5lWyft+Tl5ni81YQSxZJhIfgsb6/n9+RidOBaHmH?=
 =?us-ascii?Q?BiSVprlcXJnsfxGejPKxE8y3m52V1xz4iA0JHiXbQJJApbhw14bkOuBcsJTT?=
 =?us-ascii?Q?vbCio4XdKqA0a4rp1eYy1TOqH7SAGP92zOYEjVYcNbWCDFOfMkqcqUSz22Eo?=
 =?us-ascii?Q?iHWKDNLNGS3V/C2pFTlGhP1H36ITudSzrmy9+20oXhnbxA9Z5TRm7LSOPmbv?=
 =?us-ascii?Q?fVNubwN5vcgwojQIfefDKJoJECDEhuTSFXUAjyk485IFJOrxq184OHeuyIt+?=
 =?us-ascii?Q?VDfoohFF9XSg5T6C7hsbi7Xv33G6OJVRE01D9SVrrkna/dVKs7lHPiJ9ou2j?=
 =?us-ascii?Q?2wqt7hdUF9lOFYdpNp7Bdg2K+xLw6srUrbLCYrKob03OH4TQABNZoAxYBbHi?=
 =?us-ascii?Q?2kIqSfiHHYfOEFQe0NrjlREjdc9R/Isu1oNvxRtUuokC7XBvftycomcOa6aW?=
 =?us-ascii?Q?JIZLVHyv1WWqWgsNKAQNgjpytALwW9byqJ/2rvdLWEeRRfZhrqbxaQuOY/PJ?=
 =?us-ascii?Q?HqBoSQx6rbrDR/OXqaPZ4JNtuSvnCIk6Y7L2qTXadh4demlYMi/aH+iWlGZM?=
 =?us-ascii?Q?ZSQ/4ZrzFy8eN9/9tZKX/Pw1iGtMs6W+aFzqcSSMi6TclArA93oveakk7vUg?=
 =?us-ascii?Q?D1ZMetnM6jA+AKavOkPq+ss0R7TegjYT7jeVt6THk/5ctleKEEBjDaxfva1j?=
 =?us-ascii?Q?W2rrR75UgcawjqaVjzCCo3/0crmOBpT6Dfgrx2gTFi1xfKAGxFN5WZbaN11j?=
 =?us-ascii?Q?L4bOpBlSmLj1zhGYHiTEvinn+hleD/ahIzKqUQnEsfv+yJFlxSXD4AN26WY1?=
 =?us-ascii?Q?f9svakQ5VVllpEXe+8F2Jr4khg9wVw5I+e+BfUaAYYC2R2RVWTUZCdL3IGv4?=
 =?us-ascii?Q?nG/vzZg37BChrcBY0gKQXXq/AUQBNJRWmeRRH6VlLkvlKbmeFBfvHv+4pp4O?=
 =?us-ascii?Q?jJ3Xy6GSsYd4KK/echdEs6ekin05dQJ1jtaexUY3hW7Nfs8Ws+UM+HIY1/tw?=
 =?us-ascii?Q?Vieahu+OD/J3EVX9/Ya6+AkrHwYhQhND19OP41DxGylKsE5kE1sHyGvHBezS?=
 =?us-ascii?Q?cAnPWR1v4s1y6bM8TO6VFEIcVtXSfnfJJcIGUMhsZDlu0yW30oJhHZ/fd9rx?=
 =?us-ascii?Q?YekAfXepKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6794b7d1-8934-4c62-8eb9-08dee0faeef6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:22:29.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB1ikLAmMgLRgrm+GB2mWrF78Jy3OvxkiBGhaP4KwzAHNdn7bWoMPD4SP/f9Y4rzn1SntF7u6wVI7YQl+2WtwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c8..0817e62266e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

