Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB03F1670
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672843; cv=fail; b=GgF5DYjztc8FLBV6e9QjIdGgUgC/6vvYSuIWi3MhE22o2h8dCwrI02atqAqrILrdVVuO0O+XTw/59waUEyecG93Jdf7Y3aC3Tnx9j5AvfwXtEk6eDA+3Ced1tYKw0XQmj/ePrlXO/FPiLAShVODdCnVV3uMBbXjYKCj8J9Hkf4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672843; c=relaxed/simple;
	bh=1FdUVfSt4RQISHefca2TB+7NxXrzIsbbaqLvHILldGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODvr7XOeCFlWjYgRLrOYl8JSU+7QJ6KyzCDXqgBGm9zo5ig3LRxdqv3i31jR1Ooqv8fLjYLjLznZr5H4xNUscXmW4j2Afs0a1VhvZDJOg5vZflNNxy140LyhAhsCdb0dNWYobMZ05TLU2lf5QLIvYWQKp5n3CftvFXYTdVZdY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHT6Ms8/; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHT6Ms8/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMYoLQAmivbmgvQeIwoQ+oxpNVQiKCEqEAfNW2TmtoJVIF3s8ktTTXF6Qn4sOBPYspyM/NMOmMf03di7vWIIK4FMKYU+5NT8ScstkGd7uqlMuSl+vf1F6OGNTYE78AcGT5jyCA6vhJys2vS92qWxusfk/WMaClAfIZiqdlyNLlDRVb35WRgfjerhEkCfK4d16yCNU1xnerfFnnHKVk0w0oNDNTe5KqKsCxVObkL55QFNbyRlddtMwkSUuM4sakkBBd1oFewgwnfAb2gsd/4tsOUjO3IxJdIDrmNkPhAOEwNCRNyhmwaVT+Tf+dsGLGcEVpiAzTI6162iw6EMayYQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=bIJeKVlnNS2tZXkQS4aMwAo/EuGkUsnIbkUWBqLlFvxgI+8cPB2OjcFk7Fpz3uvlsyU4058nU99iGiZ5pnONDlNrRYi3DQFSk5rlkTH1r4J/iPKLkaNxPvbBqT9LSQChqmveSDAkZ6/dYoaKAHAiZO17XqkCRIA1d5myDfYEslUou3z28E67BFfCw3NLqELZS5URrSSlcKLB3LEt9Vvfp6+lkuvMCYDyLW+ZEoBk77xbgYMPXCUDMqKsmLaisk61S3xPCmBjt9zTXj+BLbZ3/x/7etjRVZUaoMlOjBPy4mJxZSQCF+qUEPC1kCB3mND4i/Qp0QhDL58TowI3iVmGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=XHT6Ms8/fY/mReVRpn2pvfoFkxkmYctOkKNyLjio/VGGayc+TP9Ze90QsQnwz98JcSnMkooonCfNfWdZe4kLk/xxPt3lOHKj/FofFMuEKhHDDniCBccUxGA6L/oQFHYmYlOTxAxlbH1MhWDw/dR1kjjMfJxT1ViHBq4e+rb6oXFHzvCcvwAXYlgV/OkqB4qC0zlHYdjNlDuq38z49EXjJDCXJSKEkBeigmdvR6kTSbxnOdJZYAVj/L90mE9s7NdGK+dj6ZwyJ0b8Ik94NbpKfbeHtHfvFHUr5BrmG7hxL04CvgNzhTiNr4sLYpLJpQq2eMWeS7Z/Ab6qfpow1lpiyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:40:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:40:34 +0000
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
Date: Fri, 10 Jul 2026 10:36:34 +0200
Message-ID: <20260710083913.30573-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7b5b97-cadf-4c86-22bd-08dede5ee813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SS77cNrhRA4KDpDyrH53movRHnj1rtm8bu3PBR1DwRmIWQvEyTH/+40LCKNULg+aAH6XpWa2K0oHCbdCAI9jNGUWwpVsAHCIAN8+LFm+PF0HvQOtWwK/buV/LO+zD36M0n0Z2VHiAilBidVTtESAoH5fXNC2YpWTlnC12wGD6SKYi+63uYRQzaAsyaz9eDiws8CeRRYiXfxvB5Zz4/Opoa+WTcNoA3wXMOLcFe+MgS19+CYjVRHbd/6pOdAO6i40GV3huZpa84pWaxoqe10/oi/EKqej/RX/ONoEp9PL7Tc01CWU4E4UOQhztUkA8z7FxY9HV2VyhiiAi12j+UJg9iwHzMdbHKCgswrSSaInr2aYw+8dPnU1iVT/t5VbLNVueEB7WpspmPR6xVlLIlzs9sLlbiPSO3nVi3smm+FCOpM13g1+QgCR0HjmyeBjMJB+PiQvWdrg2gt5Zu9mgoRW3jP+TdTb+JRqC05fHByfSuIHwksQTwSzJPlVY1070CTFSXJhb6xfghsEhtKexthBvZeKrIAhtIv3X7s7vEnm9pVFUj0g43MGGWBOXs9uAbAaGEHqrXhrH7lA2c1QNE+Vt7K5jpylkcJ5tMjxUrFigsCziLrcNXOqwRpPArYXwUo4UrXSHtKzq0aPTZSic1jBky+1Yap8KLArSUEsMvokz0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+btwFMnqtexe+Zi9cu482V0hj05wP+RdPwGeO/f9f0EVKK7T8X+nvc7bFbS?=
 =?us-ascii?Q?EWbRhfqJTThBSssHdoq12cCPV6wtM8IRgFsxBV2nP6omvxs+BRjSksykzw3R?=
 =?us-ascii?Q?Q/a4IKpcIU7LRfsHv9Xt2Vzxq+WCKqDf7xupQ93PFXFYgsTMmccUWGxJnoYL?=
 =?us-ascii?Q?yTzW6nvjCd9zk2FUj6iaSuKbgNpqGXb0IdNTBJ1tl6h6BrngS7OdeBBO0cgM?=
 =?us-ascii?Q?iFWL9y/FR5j2ZpgTOo4zLS22iU01N4o02LaPcu07xWjZHkShoL3CNfQoEmXw?=
 =?us-ascii?Q?Ys7GI3zqDOTP+nYgz8V94b5gIX5cUAr4eAF2DWn2d4sGVRfjZdHtb/Grxr9Y?=
 =?us-ascii?Q?I1mVjjCK0SYA8rgkELOICAHeZg+NLpME45nh//uGXtyQT8sYRoC8cBwFgRyE?=
 =?us-ascii?Q?C+Q+YdyfenG++LQSaonAMvit0UUqkDT3jZc5I7ZVwtdGYxzKRVUQXM+GBExI?=
 =?us-ascii?Q?xCNc3OtqhNdd0JLR6iHscpabzcdIIh4WIkt/9D4/oqznseyATkSie8HDbs7j?=
 =?us-ascii?Q?2m0a7Tnz8tzzCe6dx6I4NAdk5h/UzrK8r8J011IZZx8/4nzDx7JPoITVzzUQ?=
 =?us-ascii?Q?RrgGpVGyPzevfYUrbfZ2Wn8v+XnayU1VcjjXhihxyXhtDN8sVP4q+ID64saY?=
 =?us-ascii?Q?+5CCHC0xa+q3bNkx+KKFu4GxOLOuIyTQEg/2fF9rbSNXStP+sMOzqHsIwJcF?=
 =?us-ascii?Q?2o9Kl1I/tauJwM7vutYPeNEL48b/MbSs5sW55ZwAJ2lFitKTs+nozboQMmAp?=
 =?us-ascii?Q?qj5DRgFFaOguomV91W0L45foLTPqavBbzXi7fQueOwLE7WKXkpX5SmT/wuqN?=
 =?us-ascii?Q?/9XfDGUAK+uhsMwfeeywJcmwKqrscKEm+Hfd+l7EZvKnmcldCti0Ltom2q4t?=
 =?us-ascii?Q?Te/Zft0ErTaaVfcZ2kIeB5sk16/6/3YcnZ/TEvzgVhMzRnvUBFc4hqjq76L3?=
 =?us-ascii?Q?vR0WDaEEHGNxPusLai4NmFPMIZjZ5EbKmZ2ggYy3R5FFSQ4/ZLD+YSG9RBKV?=
 =?us-ascii?Q?ZXYsWMBeSBRngZ7DLVOot6FzvNtf5hsSQt8SWDisTHd8e9nNUZ9yIXRGo2F9?=
 =?us-ascii?Q?lVcqKoyWPFVhAYlxcvU+jNyGd2qpkyLtuOgIOUMd1cif46IrFOg78c2dHqyY?=
 =?us-ascii?Q?EcEVAHGeFlKO1vWpeidhI7cYn1F+k5ow2cw3OTCfoYwnKUrOEm5LvVJ/Rp72?=
 =?us-ascii?Q?mXBVBjI+s0gGfSUJFBHOUjCb/Yoy4TF1GqXhxcTyiXSliYhUAvZa6cubdYhH?=
 =?us-ascii?Q?an6WVUniAxCjlrrCgU9EDEOC/iyHBQzoH26NU9g9IslRreZN4aXR2aUVaphl?=
 =?us-ascii?Q?XtZff4zuVV/dSVaR9XQlnpCl/xeaYOB/4CyrHVWBoxqxr+zoUcMd9MrX9zk+?=
 =?us-ascii?Q?pWKktLp3x65Rfpty9fDxDwtYnEVqm9XKoO/9HhG4mVdn1/o95TpvtRVgvN1F?=
 =?us-ascii?Q?u94Jy8AznDnsuSJs61jFFPvLaaVvxu+U+kZLnCt0KiUKEgdorEP2XjP/KSDM?=
 =?us-ascii?Q?iIWUoo1NAYkuoBdGwV6ZhGpeWfWykARPfTbaKop9ELKnchhCCw2LRFQEwe0A?=
 =?us-ascii?Q?NxrLqeoacr8IavMA9nCce2kdB2iYYVQg5db5iiPukQxXfNAgD105865/gSBM?=
 =?us-ascii?Q?XBK7U/gP2TufISKk3Ik2knM9h4pEZzCz8EIqpFH9z6yJsVaOdXFyFuf6aNlS?=
 =?us-ascii?Q?lMBb/s83gGiBuNMD4B0Bt8HVEvOiFV67ydhVRihru3stiVx1Sd+UKL2u/Uqy?=
 =?us-ascii?Q?B615MrzFJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7b5b97-cadf-4c86-22bd-08dede5ee813
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:40:33.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGWR8N55SbDJ6Uzs/GmzVSxFYQBuh584mBAYtOHrUixTwBcxlp3rtwRyJNMZAl+cMZF4g16K2nKwBQAGjzCIqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

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

