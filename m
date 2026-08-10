Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9D40F73D
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375067; cv=fail; b=DoABv3VT7KncvC2eElG5Xapxi2UI3zwCdVe8tW1ZzVf2/UeI1mZZSu86RIJEfJrwWhMUu/mODJtKeytBTOQnuQ7w1SN37T9OnPcIEOGlrWvv5t2icLPFIeyEN/vTUdu3RBHnrIPgJyM130OQg6+ahz8Ho+ZGJi/+R++tDWRyse8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375067; c=relaxed/simple;
	bh=AW22c+oIVPm54OunVnTdZfmqlUX7ak5Fx9HZTSaJyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sz6OE8Tvc76w9a76m4NB9YTbs22QVHB4og2VrPcOQuHPY5fKdMnEVLNfSnw+4q0/K4FFiyKYi4T6Drxmfvfo+oUiiW756GvBkUyXgFEqnNUM3QU2vzXvbeHRnmh1+PzIMoJ+gv9HkHQ2+tMMENcZZ1Lmls0+3Zd4W+uVh8MruiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N7QESHWb; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7QESHWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcaV1OwDirAlQtkDjTtMHjMEDRbYa2a1KugMlsgRfecIT+g2MWx4unZLSoDRFQow/cTO76BHVmmBgSY4Y9k3+1QfUuRedmDAnLCclgkDi5m1CxAHu+lnFXXwAT2MqA4M0nCi/zR6W0RAKBXwuaeHRlVrzkI7BtRq1VDgEg7d/u09sXk+3gc6RDzR5Krz4OveO2F33k22Ij0wZ9La9U+1cKiz5ffTRf9dvQywfzy/3V1SGZNnHmZlM3zbzunS9Tsojmi4jAqPA5Bu3VOE9w1cn4wORS6cPn451pFi1L+pvRUB/yuo4vT1ZNgfqOHz7RhgrgI1mB+kBfNC+EaQewxdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=J5Phwo3QfAR8qyZxwkP/u38ZXwxv5vtjmYY1pg6lEgVhcQVawtwbFatzMqU94ZW/6FRUea9ULue4kms1FFupvMeW9Num4ArAJdgk/z1tdmsQQknypoJGS7itwv5Vgk8Cd25O+Dti6AaWhzscag5eAQFxQTrw7q811ptJ8qKVAEQeh80cF0vjddDD9B5gSXkZ/UjrPe9nRdT8Qy9W6utGPQJ22MPBRyWHFLbtmY4aKP4Qd+6EwZJ+wC9HA2d0NL4jyaJKqwiJ2XLmsCePmAoQnSvpik2sz1pLEeydfEW+FHsbJkj6XkvXifTyZUzy+H5JjnlVcE/YcKri0Y+jfcf/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=N7QESHWbRPXwXFAcTrAdWXE8P7qhP9CRF/matfZheIr0a502F2icUT4N7rxlYxe5fYzyGlZu6PbHQGLbBCIK+EubHArX7opWFp4sZgUluwqJL9q0mgOYMH7QzReQDpkr6Z/cH9Hvcr34tfamsgKPUD97Xpwdi/RxYjy+ftzdIDE/Jhk5nAiU9FVGsitWPz9XFJEebw3hGVTvP/fh/G+514wy3lftU4o7tdoIIZu8CfATaM3+7+7Xwntzdn0IZ4EZJfWIkCjZuTlPdLHobe8qubGjldn2TtpnxEwPokzSSKOPfFb9c+Mq5PMtYd5sREecNSIfgtN55/PncukAIiHCgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:17:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:17:32 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] sched: Allow enabling proxy exec with sched_ext
Date: Mon, 10 Aug 2026 17:14:01 +0200
Message-ID: <20260810151523.86994-16-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008C3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::425) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d647fc4-855d-428a-8be4-08def6f28026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rBoEVXURTgxOoQGN30HIOx22OWKwOI0v2ljTJP9GQnd/6ikPi9mJqZxHOOFCVyuxpT9eCzLR/vrTwkyPasMmwVagHfVxmAJBLO2ZrK3RWJXiFURCqZHRa9L4OymZNr6bRiixMYINFqzsIpa57YOVxJ/H/pq5KI09bHPCbrg8qP/lqXIPRxcvBTZ8eiPP1LTeq73X7qTYo2M3SoaK44P7kbb6WYxME7l8Nk9kPpkSxXMMfm1KszRMBcL/lzVHc/dNDV8CBUUlOlxZfC/XlKriupYtCU6uUXcRgCSiTknqtJ9KSmBDHGGgMgbWrjExFAJm5SpFkhxaEpsdMtj17OV26tAjcf/WSG55E1XtUkDvHarzKgPNPpyML8HRt3lCvtN0xz7JxKRj6coXg14etn6QSmWNIwKuS0Bx3X8SvLoh5A8d+TogMiFWnlLHFsGlKUvFsbuYWsHO3/vaHdPjws/ctWxtCpiVeXtFjPgKUKvAfjVHe1/gzBdFLly5304hZAXkMFHtoKwi5OtVfT5o7bpOzgwPcxgJBlx+anJnPH9i4j6WMq0wGEVPFdNfSf3y7NFecjpTVj7vSio9dGRyB4C23nmMWkfmqjO004js6Fu295E0C3NQlUBuyLuwhuEe3F2DEOrsbzV/xlDjeUYobpd0ZRkW5XpbORqDGLA/xN15o74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WMp2WXW62frmMJ+2Vi8JkrplgS381MZTnq8cMROtRWBbRhgt/FMMjDARIWE?=
 =?us-ascii?Q?bSbdTATKF7w8gjDGaIlI4STyTqiJWwLu2/sql4dQOIGbVCOMnzGqbiLSHSwb?=
 =?us-ascii?Q?BS80HqMhiCgACVNJzZHB8QWuziSXQamXBBlZ8xWlgEMD8W14OtXPFWEiYJwu?=
 =?us-ascii?Q?iBAxrycPl7FNo/w7wzhoEka9nEmd7YoUVAfxmdDGJrlKBuDFu+iFZNjEhA2g?=
 =?us-ascii?Q?ks1tMtS/+SZ/PGgIA7OZhIw8Qc7pWdBtQ5PHc2neMuTCFG2KiM5EJsXSHZ0o?=
 =?us-ascii?Q?WR8XghpFCPHQ1sSuIaW8Udq280AoeqOn8ygYwLpCRhJDdF50vG24JW4YDEY5?=
 =?us-ascii?Q?ro/iissyOaecyJmT8YQK20m4TXW7j14fy7vPGHNki1KymEvrTyCTRCvNA+YG?=
 =?us-ascii?Q?HL6M54Hrk13CBeSz1Cukk3ZiTmryTCdrSZoCV0xUX3bSV+0sfuZdc7Wn5aEv?=
 =?us-ascii?Q?xluIzFMuERdqoMbZsqZVD9AEaSiQWRYVffzvttRaMxy0lS8GAmx1gyBo2PLB?=
 =?us-ascii?Q?dxrDEtaqpowOXipgFefFPPJrOemPgEFDhKGq7Bv82TFMeOH+cdDEcO4X53as?=
 =?us-ascii?Q?CZdoBkXcEU46BIRN1Krz6VWdIdYm8Dh71Kaf8UnRRgpdWi6YVMXvgroq6rgs?=
 =?us-ascii?Q?H5SriDx8QV0APEi/Ahj8KH45fqYeEopYGAMqO0FiW87Fc2/8YWr0fnnTGN1p?=
 =?us-ascii?Q?cRj3S0VmrPtE7enudREaEerZ4f+Sth7w0mXfofu7O4WgxalIbf/hgNreBTPl?=
 =?us-ascii?Q?0K+8B2Tyy70vSWXB31win5lp8GLEgrJTOvwXUH52Hv/6hePY56oRB0sF2mo9?=
 =?us-ascii?Q?aBMIY15XvS60LsPkpSAu5Qbih6AWKZHnbqjXSlls6qaezK7gEj79bm1zMKsv?=
 =?us-ascii?Q?hhAQVRmtW4kKuh+piujCqVTt9PZzpBD48PQgZmmLAKi8X1OHdX0G5YT/yDeX?=
 =?us-ascii?Q?OV1zBbZBnZvF9IdaaVLTaX5SdtU0F7Viw7DKTSBmIfK7sC8hx0iiy4ZF0AXM?=
 =?us-ascii?Q?Xjy3GkzdutV758PeV2WnLuN3+0ZEXELClehTMz4U39z5k9t3cm8l9tFebGXr?=
 =?us-ascii?Q?LsSimMljuetEWWaQhgBr1IbbJxbDFg4zp/P9UEmz2nl1eBK5ef5+lJ+TGvuF?=
 =?us-ascii?Q?M4b5MlwvZcPxtujGg25tbfIwEkbAnQrM87PiQaaJ34L9ldprMgzCSVzcy2Mg?=
 =?us-ascii?Q?O+mTLaopB8sgqlJdqwFD4mtYgSznNlXxmRxtDXAHLT41xhZ8Jtw0CTat55oV?=
 =?us-ascii?Q?4KswsrE2/FqebVPulGZxtr+Y+c5SNJAYkWvHlXaYKut/pKFLOe8ZeKXdxRHZ?=
 =?us-ascii?Q?QixQQJ4c95Vay9SzAtFloHS+iZck5rzQvJKwFByxrtZePWy0b7Q9AOnhBdSf?=
 =?us-ascii?Q?OTq6cCZNOTrQfdj4QnCGzVaZFoQsFI/VDSGp7iO7R3w/ExusczA7OInFtEuy?=
 =?us-ascii?Q?ZfIF+tWg72JzGFytVV0svcS8tALJ2wAgBL6XObhUCp+03lrmGFp/aOOrPuK3?=
 =?us-ascii?Q?lAWHx7iUl1fiKePv4DRfNY/RH+OAtN1j5RZ93EPaJWO4IKjAreFMH205CIHB?=
 =?us-ascii?Q?xx9A/vTaFGbdrGb0YVDy9MnAsONqMKZ1LXJfj0Jv7/E6muQSLjOWcPKN0umT?=
 =?us-ascii?Q?d3aOyexPoF07Ry5JHgU+LEs0AIdHSrKtZ7NIdPuqsjFbD+I/DEsKtEQgxP81?=
 =?us-ascii?Q?nR2jqsBo3hNOOZPeKesSTOUS2aphdnSmTxpkoQeHoDcZHDCuQWzek8ROC9t0?=
 =?us-ascii?Q?987+ieFcTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d647fc4-855d-428a-8be4-08def6f28026
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:17:32.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwZsjV4JeZuX+H+1EPcxrFc915JQ8Kdc9SiV6sw35okgYw5VaW2cDLkofOn6Mcfhf6Gfp82hHNzEFXlEbBZi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Acked-by: John Stultz <jstultz@google.com>
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

