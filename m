Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40223EA89
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771704157; cv=fail; b=q64GTwiGD5jaQZKPxLPHe6rbCTyel7jKvKVK1NZS9b+Pt02VTOCpOPhLEaOY3soscrMwejC7+TkvohRCfOwDQcedB3GUp2i6z7B/0uyZNE3V8sC6uf+mtxljk5lrU/hdCURLGMZ0pQOoczzsY71t+pA+KLT/ijv0vDCMWyFU+Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771704157; c=relaxed/simple;
	bh=1ORMfWhEWYLpjc1l59onXO23NB3sxBi7cnSmUjo9RdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MroILe5oIsATgyn2j9jXXleWl5B19jN+NvUaanmdYBoYKbVs+9P7nH5x2ghqBmAn8ctXEVI7y2f78X/hIcHlPu7Q0CTdick5y8nYtE4sQi1El0ZV7tNTUJtfGeS9Yjl6URREUaOF4REb7DqUCt/wopS8z/LoktTgxc/D1b8rjLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwsXkEo4; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwsXkEo4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWmwOmDwWiyWGYLYErHU56cyL0woUZrXPTFilzrLCm/WqPRPklg02LZY2ltvr/g6ktY1VU6hJR+5MVvfX5cu6WZORKQw8mx0TGzMb7Vc7G5tKffR8Kb26CtcGSroF7dF+IqZ/nh63dpkVhfWBMHf65ewzKmZHZa++JeppN4WN0gTotUx/i2mXDSkY9TvnDYezr+1Og7cxCTTBBMk0ZKxCWZuXEg1s8pPLalyOzRpLTgCLPMzQenI7ScfnSa6uYem0gv2j6zLA1E4Pgn6bbT8kAlPHqmJ63No1SkLySFtft/IpRJ6JyX6jweB76uwQ50hTqpsc2YYwtjmGa6JjhavoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXpAxvt1d17qXzm+8Ue/LtBxTh394j4xJsshsjKVJLU=;
 b=XXE/csyheB0BjEzi9IBgKoQFpvn1zXDub5mQlVsaz/m8MZrIpFZBBOi09mIvh/DgbbQ2ySukgRBHyTAWnWdUmip5j44APBVOyi7wPXgZ8QIVqvNvrQ0jksiSDCdc3U4Ee6MEnItg8VJSOgfHtQAU4nbwlU8usP3XlsqodNua7EhG25hC/wnRH3EFAwP1jmLUaqwFXQOhoigbx7pkG1OLOuR3XQEtyyWIMkI0bOPKwZz3zco6TdjVJaF9mMUeMDESngDjJXb/qc8aUHTiuEh+D5lE7J2UDuXaxEwXsZG9bg22wD60VZ1R/fg2sfkzFd3gncbyPaGbr8th9qRGtEMSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXpAxvt1d17qXzm+8Ue/LtBxTh394j4xJsshsjKVJLU=;
 b=bwsXkEo4fcVnAu8BGgp5hcvyctA02T95+K3/sPB5CVLDTxS4xv2KUfuvmtDg2NqcKI5U4cmzBeD1jOdZnlCqdB6w3v1ToJijJfey9dTD4rG+YCiop3n2f30pReQlIXnu1/SRgxiBvGsJef4JOLKpfOSuu9qcD9Jf46EZTFiSxBST3UhjwKU5TXzTAkmx1HGN3Ig1m7EEOE0qDKWkw2gLnq+W0zbAU64gFvaN7wepNVVg9pklGicjfRhOr+kRIJZUWUwy9vFCvRudqGWeBgiCVtHEIRRD+PnLzLP5aLO00dJB8pUMtZzC6pDSVlx9RHyWl9yqNnFDxJkgikTF586U+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sat, 21 Feb
 2026 20:02:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Sat, 21 Feb 2026
 20:02:28 +0000
Date: Sat, 21 Feb 2026 21:02:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: changwoo@igalia.com, christian.loehle@arm.com, emil@etsalapatis.com,
	hodgesd@meta.com, jpiecuch@google.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com
Subject: [PATCH v2 4/4] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aZoPTP9zLBoKBZRx@gpd4>
References: <20260218083703.22785-5-arighi@nvidia.com>
 <20260221022651.59391-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221022651.59391-1-daniel.m.jordan@oracle.com>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 43644a2a-f25d-4c69-e3b3-08de718423c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j2mQDd/mqLCbck7l95nXYlVmljZUeRdUNV3tMM0Ji+b9Av0FFdLaNQB85yj4?=
 =?us-ascii?Q?iTdBV64Nj2Ucnfv+cWTkQLqBgC/HVh9cGG8Va4nSjSiJ81Rql6QtFGXFjJTX?=
 =?us-ascii?Q?RbLaIToUr9y1B3aff3D+oKIWmmCRwvdS8dDfue7DzjjGKKE4lbkCjKYYkftV?=
 =?us-ascii?Q?Bh6oGBwntrTthpyv89KxJBlTQtzdUl3nREwJngYSJw/5YayONH3sCsWL5WKf?=
 =?us-ascii?Q?4QFadhhVpfAxnNOJEe+di9IQVnB0oeckCbTXa5QbFGglD4xSEIX0QRCE83wn?=
 =?us-ascii?Q?HdceT1vvCd3cxSbUqznNmcsV0qnfHME4kyoNcdN9JlWc1AsaiTJoz/0kjq0M?=
 =?us-ascii?Q?9E14ETDSoTc3NOw9OIEFZ78KOB/dU+9Rzh0PA9NY11yl5TF+mpcqi+QZ0KRB?=
 =?us-ascii?Q?i1jYSjXEMk8HsV0s4nKNypybM6n2QQ0ZukCdZNfkHKntw10mjE6pXfSj/8yF?=
 =?us-ascii?Q?fWT+dqOBOySMaNN8k2B10ZlTu0lIbJ3L1QKSpTrAC7giQ/tLn1RkEnarQckY?=
 =?us-ascii?Q?VBj5DDdTxhfvTqyEx/oFtb0qjsmrXFMJ0RK9ncuzP9ytrhOoejS+n0ST6Cei?=
 =?us-ascii?Q?3ca/pqZQTEl2UFY7WfR6X1Q39FknYntHXVKwSpIJ64Q+Z8vUuJJT6MJbIQVT?=
 =?us-ascii?Q?HyvgkQkJFD+3KC6pRtYVLaxuVRDXlWEu7rXC89wySQ+ToKMiYh5IlwxG3XbW?=
 =?us-ascii?Q?q/KQ6+SnIzedUE5gpDSvAMseQpDi1mwDUv/zHOOUPK+834ex9xXrN4eH8rEi?=
 =?us-ascii?Q?6Ue7U8GYnDPR6SsJGvHdzEG0H49l5TdRQ68d4EJJ80ybvNaPMydEN97Z9ZXs?=
 =?us-ascii?Q?6mJaukW3FLhCt2F9CU4rYqDRlBKNcO2ApdvDnSGk4JrsB/iHiZrKSEkCY46J?=
 =?us-ascii?Q?iV4fgm6LRYPM3eXbla0Ifx2wcEt0pzGZxx5blWUU1H2u2BwhCTZSE31/ZAcu?=
 =?us-ascii?Q?OA3TQSQzXDQzoDXDlykMmi3L4nDO+6zmW49o46QDbzFoZdqGjwvJgKdcQqSl?=
 =?us-ascii?Q?ky33Gw9IFLyHTIQcHe9zqhStsOGaZ3+MoEjGdwfEVJkpWIzvDh5iZhWcHz0Z?=
 =?us-ascii?Q?DonRCWEVJojMflUtNNf5WlMiGpepftohpa+/LWN8Bjm3EsVyMc/ldFZcpx0T?=
 =?us-ascii?Q?vs1EYPeec/AWC1URXbLwq940APGT6BXd2YR1kCinz122zK8GDgG4NfKcDizS?=
 =?us-ascii?Q?7Jvpb0HdlOhOZ34uXUXYJLTCW/wBL3v6dFLVQGWYbToRElOvkkFnoOEpJOjB?=
 =?us-ascii?Q?3ou3NTD3aiwJBht15FzrXbDou/0kk8/I1JrK2t0BM0IQMleCy0Sp5ad1ptG5?=
 =?us-ascii?Q?bjG7p5or2+LsMuUILhejNpKQjLJeAIEZP30YFHCdd9CQgZ2RDNgq/bag58qh?=
 =?us-ascii?Q?GmfiTbAUR27aKhl8q/GlXqi/RVHGU2IV1DsA8aWyjrdjdjNHc4xpMp84HBIf?=
 =?us-ascii?Q?xrdci15plbe3a9SOax8m+FRuynj1MNGeIT+ztL9m8Y2K2JPCMPANTFr5TonJ?=
 =?us-ascii?Q?hBFsejAaMH/xaQ8NpcpbxzAViqmOsPx9D1zLth+ZRM1RkTKFbOt87LWdP2WQ?=
 =?us-ascii?Q?R2UbEJsMJi99TmuSOiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzeG81PEtccWbDZutFVRmgilxXsL0+HdzIM58MDtxN28cvEpMPO4uIyQBTn2?=
 =?us-ascii?Q?9YiRwiCSMjEcQIT0zIvsJ6GdFTHL9njWOo0mx9toLQoizdfBKWd7JhTQ3xdi?=
 =?us-ascii?Q?JClkiF6tCEgvtRXfFGNBAlt9yGYbdk8Mh8LiFZOAOPhRWL6Kf8azUbxl410Q?=
 =?us-ascii?Q?OBXO5oAzzLLJyO0W328P03BVIerPHLMBBJ9YE2TqG1WLR7H1IbyITk64ta0Z?=
 =?us-ascii?Q?LAck91KGm1YalFlcnYiu3M7qXXl5VA5A2nsA0ahjEziburWPyShcYEPCyANm?=
 =?us-ascii?Q?ePxgkIg81AhmV13/8Y2dJus4RChpG7lr6KuI8vxu5gLjs1QsCGI0YVhaBB2m?=
 =?us-ascii?Q?z2Les3c08tawk1Hn/KyUg1ME5NcKjnTRPlMWh0ySHSU0l4tLrbh6Wal0sNNk?=
 =?us-ascii?Q?dsrDWx5M/7B74V0v+uKsyQKZcBGgskdFLQKIpGmBOe+AROzVjgdRym6zZ5eu?=
 =?us-ascii?Q?WhbKDk486lv/vYshNBNlTfY4VtNZXVwd95axjlAhuyPI1YYsxU0+Qmx8QTVz?=
 =?us-ascii?Q?wuZfv4sRRDbXY9frwyq4Abp35jub2vh3N+I5vJcIUbNxEnOThFSzfE/Iv2BW?=
 =?us-ascii?Q?VCEMxsvluOLGnYgSRYb4p+XEj49V8bL6N+kp1bUigWb2geBGENuO+S4nwuIX?=
 =?us-ascii?Q?14KWGiI57/BsgaWlDU71G5Q/EH9QotsotLL5hNm93BjpKsUYELhLKDF/HmL5?=
 =?us-ascii?Q?ktOy1ptmEL3X5RGuFov/W/VRsSGwqOhmqPqU9Hah7yQQjYF8CLuH0RxYfMiU?=
 =?us-ascii?Q?FhdPtSHBynxO07OBAoNmPGwunI43nHlH16RNsGpH+Br37+w4MrMt8QlLkWzg?=
 =?us-ascii?Q?sig1PwpeVxcyzU3Hp5KNVJmHrgBq/q9FBnY2B+U5iO4/gnb4co5Obhr7xGEB?=
 =?us-ascii?Q?eYLZq6I6oRMXw1vrM4hH1nNCrFBVUxcJni1MYvgZBIaDEyGZu3GsOodbaPA7?=
 =?us-ascii?Q?z0hdQBaU3/bIixIFaUfkZrAiKRe4eq8fJVk5tDMq3/+a28zOMH4b1KgbRXIe?=
 =?us-ascii?Q?YZDlEzCTVph4IHe4KE/cYdnt23Zoy53mjaQI/FRDHOvvId8jODg7ZzRo1UvV?=
 =?us-ascii?Q?kRHm6bDQhJ+giv6n4O54mHJUcdxqdZte9PeON8YgECTdGIlrazkJpVTtXMAR?=
 =?us-ascii?Q?mc4u6upie+pYKaPRROiF/neleYz5DVpelXkgjZ+atvNzqllPUBdLePymwc3a?=
 =?us-ascii?Q?UZkNJGX9ekokwaFgidaPGhBcVb1gpwlTUdXjK8Uw0Dk3YNmgE5IzJOsrbQKp?=
 =?us-ascii?Q?3sqs5DbLGVzuYrXK2j0g62bFn2wHf7oymiqoU9h0oIwr7c7ewuzh9+8fN+/M?=
 =?us-ascii?Q?XfbsjZ08hpgLV0p2NtbnjVLptTIC8JwwZ0thCU9GTVpLUQqu07LszncmyZfI?=
 =?us-ascii?Q?dnzyBCsbFnc7jJXQqbPJB8qpOiGKLkk1Qj/twozjS4R1d4MK4noy2cLhwm3K?=
 =?us-ascii?Q?1Tlj+26rbk08h6AE6l+k9ugvX3TElxEYlCk4dd36p/yOnTquel2Vw9nMV2gs?=
 =?us-ascii?Q?+J4riEyptop/EEdJo/7fMpykqpH6NnJw1a3Sua19NUxjoIUUtElPjOVcLPUL?=
 =?us-ascii?Q?JZGrv8go/m4bjP0rlicFFu4ZS/SkoutAS1esKtMrUruw0EiLkjdNLZCdkAtL?=
 =?us-ascii?Q?s8jDeXdTIqCz4txDdCE6aQBgbR8thXSbulvil96z7RrI6x5bRRyRp1F3gELG?=
 =?us-ascii?Q?RAKVi4XkhYcAifbtk3osQCZuC67UFmbw9/R+EcyVFBNgOPT8nrfaxLM8npwO?=
 =?us-ascii?Q?mf0wuMffuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43644a2a-f25d-4c69-e3b3-08de718423c3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 20:02:28.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfFGl7u65u5YeR8COSIYXfv7G3m+EWgoJnJOeH9TOydUzEtj2MuRA4iCOeW6h0A5H/rH6oKZhJL2S0+oOENQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

Add a new kselftest to validate that the new ops.dequeue() semantics
work correctly for all task lifecycle scenarios, including the
distinction between terminal DSQs (where BPF scheduler is done with the
task), user DSQs (where BPF scheduler manages the task lifecycle) and
BPF data structures, regardless of which event performs the dispatch.

The test validates the following scenarios:

 - From ops.select_cpu():
     - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
       the BPF scheduler entirely; they never enter BPF custody, so
       ops.dequeue() is not called,
     - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
       bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
       not called,
     - scenario 2 (user DSQ): tasks dispatched to user DSQs from
       ops.select_cpu(): tasks enter BPF scheduler's custody with full
       enqueue/dequeue lifecycle tracking and state machine validation,
       expects 1:1 enqueue/dequeue pairing,

   - From ops.enqueue():
     - scenario 3 (local DSQ): same behavior as scenario 0,
     - scenario 4 (global DSQ): same behavior as scenario 1,
     - scenario 5 (user DSQ): same behavior as scenario 2,
     - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
       from ops.enqueue() and consumed from ops.dispatch(); similarly to
       scenario 5, tasks enter BPF scheduler's custody with full
       lifecycle tracking and 1:1 enqueue/dequeue validation.

This verifies that:
 - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
 - tasks dispatched to user DSQs, either from ops.select_cpu() or
   ops.enqueue(), enter BPF scheduler's custody and have exact 1:1
   enqueue/dequeue pairing,
 - tasks stored to internal BPF data structures from ops.enqueue() enter
   BPF scheduler's custody and have exact 1:1 enqueue/dequeue pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
 - no duplicate enqueues or invalid state transitions are happening.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
v2: - set DISPATCHED on direct dispatch and remove unnecessary condition
      (Daniel Jordan)

 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 389 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 274 ++++++++++++
 3 files changed, 664 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 2c601a7eaff5f..2815a875bde2f 100644
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
index 0000000000000..03ebfce340085
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
+ *   scheduler entirely: no ops.dequeue() should be called
+ * - Tasks dispatched to user DSQs from ops.enqueue() enter BPF custody:
+ *   ops.dequeue() must be called when they leave custody
+ * - Every ops.enqueue() dispatch to non-terminal DSQs is followed by
+ *   exactly one ops.dequeue() (validate 1:1 pairing and state machine)
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+/*
+ * BPF internal queue.
+ *
+ * Tasks are stored here and consumed from ops.dispatch(), validating that
+ * tasks on BPF internal structures still get ops.dequeue() when they
+ * leave.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 32768);
+	__type(value, s32);
+} global_queue SEC(".maps");
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
+ * - bpf_queue_full: Number of times the BPF internal queue was full
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt, bpf_queue_full;
+
+/*
+ * Test scenarios:
+ * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 6) BPF internal queue from ops.enqueue(): store task PIDs in ops.enqueue(),
+ *    consume in ops.dispatch() and dispatch to local DSQ (validates dequeue
+ *    for tasks stored in internal BPF data structures)
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   NONE -> DISPATCHED (on direct dispatch to terminal DSQ)
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
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return prev_cpu;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 1:
+		/*
+		 * Direct dispatch to the global DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 2:
+		/*
+		 * Dispatch to shared a user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
+
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+		break;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	s32 pid = p->pid;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	switch (test_scenario) {
+	case 3:
+		/*
+		 * Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 4:
+		/*
+		 * Direct dispatch to the global DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 5:
+		/*
+		 * Dispatch to shared user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+		break;
+	case 6:
+		/*
+		 * Store task in BPF internal queue.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		if (bpf_map_push_elem(&global_queue, &pid, 0)) {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+			__sync_fetch_and_add(&bpf_queue_full, 1);
+
+			tctx->state = TASK_DISPATCHED;
+		} else {
+			__sync_fetch_and_add(&enqueue_cnt, 1);
+
+			tctx->state = TASK_ENQUEUED;
+			tctx->enqueue_seq++;
+		}
+		break;
+	default:
+		/* For all other scenarios, dispatch to the global DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	}
+
+	scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
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
+	 * For scenarios 0, 1, 3, and 4 (terminal DSQs: local and global),
+	 * ops.dequeue() should never be called because tasks bypass the
+	 * BPF scheduler entirely. If we get here, it's a kernel bug.
+	 */
+	if (test_scenario == 0 || test_scenario == 3) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario",
+			      p->pid, p->comm);
+		return;
+	}
+
+	if (test_scenario == 1 || test_scenario == 4) {
+		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario",
+			      p->pid, p->comm);
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
+		/*
+		 * Transition back to NONE: task outside scheduler control.
+		 *
+		 * Scenario 6: dispatch() checks tctx->state after popping a
+		 * PID, if the task is in state NONE, it was dequeued by
+		 * property change and must not be dispatched (this
+		 * prevents "target CPU not allowed").
+		 */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: kernel is moving the task from
+		 * BPF custody to a terminal DSQ. Normally we come from
+		 * ENQUEUED state. We can also see TASK_NONE if the task
+		 * was dequeued by property change (SCX_DEQ_SCHED_CHANGE)
+		 * while it was already on a DSQ (dispatched but not yet
+		 * consumed); in that case we just leave state as NONE.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/*
+		 * Must be ENQUEUED (normal path) or NONE (already dequeued
+		 * by property change while on a DSQ).
+		 */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_NONE)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		if (tctx->state == TASK_ENQUEUED)
+			tctx->state = TASK_DISPATCHED;
+
+		/* NONE: leave as-is, task was already property-change dequeued */
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (test_scenario == 6) {
+		struct task_ctx *tctx;
+		struct task_struct *p;
+		s32 pid;
+
+		if (bpf_map_pop_elem(&global_queue, &pid))
+			return;
+
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			return;
+
+		/*
+		 * If the task was dequeued by property change
+		 * (ops.dequeue() set tctx->state = TASK_NONE), skip
+		 * dispatch.
+		 */
+		tctx = try_lookup_task_ctx(p);
+		if (!tctx || tctx->state == TASK_NONE) {
+			bpf_task_release(p);
+			return;
+		}
+
+		/*
+		 * Dispatch to this CPU's local DSQ if allowed, otherwise
+		 * fallback to the global DSQ.
+		 */
+		if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		else
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+
+		bpf_task_release(p);
+	} else {
+		scx_bpf_dsq_move_to_local(SHARED_DSQ);
+	}
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
+	.flags			= SCX_OPS_ENQ_LAST,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..4e93262703ca8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+#define AFFINITY_HAMMER_MS 500
+
+/*
+ * Worker function that creates enqueue/dequeue events via CPU work and
+ * sleep.
+ */
+static void worker_fn(int id)
+{
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		volatile int j;
+
+		/* Do some work to trigger scheduling events */
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
+/*
+ * This thread changes workers' affinity from outside so that some changes
+ * hit tasks while they are still in the scheduler's queue and trigger
+ * property-change dequeues.
+ */
+static void *affinity_hammer_fn(void *arg)
+{
+	pid_t *pids = arg;
+	cpu_set_t cpuset;
+	int i = 0, n = NUM_WORKERS;
+	struct timespec start, now;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	while (1) {
+		int w = i % n;
+		int cpu = (i / n) % 4;
+
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+		sched_setaffinity(pids[w], sizeof(cpuset), &cpuset);
+		i++;
+
+		/* Check elapsed time every 256 iterations to limit gettime cost */
+		if ((i & 255) == 0) {
+			long long elapsed_ms;
+
+			clock_gettime(CLOCK_MONOTONIC, &now);
+			elapsed_ms = (now.tv_sec - start.tv_sec) * 1000LL +
+				     (now.tv_nsec - start.tv_nsec) / 1000000;
+			if (elapsed_ms >= AFFINITY_HAMMER_MS)
+				break;
+		}
+	}
+	return NULL;
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	pthread_t hammer;
+
+	int i, status;
+	u64 enq_start, deq_start,
+	    dispatch_deq_start, change_deq_start, bpf_queue_full_start;
+	u64 enq_delta, deq_delta,
+	    dispatch_deq_delta, change_deq_delta, bpf_queue_full_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+	bpf_queue_full_start = skel->bss->bpf_queue_full;
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
+	/*
+	 * Run an "affinity hammer" so that some property changes hit tasks
+	 * while they are still in BPF custody (e.g., in user DSQ or BPF
+	 * queue), triggering SCX_DEQ_SCHED_CHANGE dequeues.
+	 */
+	SCX_FAIL_IF(pthread_create(&hammer, NULL, affinity_hammer_fn, pids) != 0,
+		    "Failed to create affinity hammer thread");
+	pthread_join(hammer, NULL);
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
+	bpf_queue_full_delta = skel->bss->bpf_queue_full - bpf_queue_full_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+	printf("  BPF queue full: %lu\n", (unsigned long)bpf_queue_full_delta);
+
+	/*
+	 * Validate enqueue/dequeue lifecycle tracking.
+	 *
+	 * For scenarios 0, 1, 3, 4 (local and global DSQs from
+	 * ops.select_cpu() and ops.enqueue()), both enqueues and dequeues
+	 * should be 0 because tasks bypass the BPF scheduler entirely:
+	 * tasks never enter BPF scheduler's custody.
+	 *
+	 * For scenarios 2, 5, 6 (user DSQ or BPF internal queue) we expect
+	 * both enqueues and dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct.
+	 *
+	 * If we reach this point without errors, the semantics are
+	 * validated correctly.
+	 */
+	if (scenario == 0 || scenario == 1 ||
+	    scenario == 3 || scenario == 4) {
+		/* Tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/*
+		 * User DSQ from ops.enqueue() or ops.select_cpu(): tasks
+		 * enter BPF scheduler's custody.
+		 *
+		 * Also validate 1:1 enqueue/dequeue pairing.
+		 */
+		SCX_GT(enq_delta, 0);
+		SCX_GT(deq_delta, 0);
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
+	status = run_scenario(skel, 0, "Scenario 0: Local DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "Scenario 1: Global DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 2, "Scenario 2: User DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 3, "Scenario 3: Local DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 4, "Scenario 4: Global DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 5, "Scenario 5: User DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 6, "Scenario 6: BPF queue from ops.enqueue()");
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
+	printf("  BPF queue full: %lu\n",
+	       (unsigned long)skel->bss->bpf_queue_full);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: User DSQ dispatch triggers ops.dequeue() callbacks\n");
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

