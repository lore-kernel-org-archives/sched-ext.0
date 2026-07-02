Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB53346FA7
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012794; cv=fail; b=SckLSf8cDtQGOGXcNshjlZnc4z54mERlhmBvjXd5uZM7/zb4YAZHr0sawhtRqSbMbVv8R3LPE0Mg6PNDXodygK3Ts8Ee3sgdY/5O1PDX1cBlzy3tygKjdkZ6Cx43cTU783Y5eweuDoLnEkNwIQfLt3m0Q8CtBr6aY8v/ONqB9t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012794; c=relaxed/simple;
	bh=2zqouUjHh6N6LBrCTGL3bcs5wPNwkCJwQsZWbHatKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fo+7MxbCH8zbH4CJwCMDGnzktXl1vDo590cA3tM89CyZvhTct6oSsLVibAm6Ds8QhUgKq9eG32cRFGLSUXR0cQFAU6em9kqxJHEjm2a21x/JBUxLRZYv4HWyf74Tzt29yqHjssW+3PZZdXdDWLziaU6sRPFV0HyrNHUceuM+1KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EuKayKId; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EuKayKId"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAnvDei+FWQjtFR+YVNRuoj6dXMsC2bE1kLfz4Q2nH+/c0zmL/hLxsdic6uVUjofc4PSTeuTbvt1qM7CrVOwAgvwaWWnrQ3p4hJZr8UsY7FAeStDPoW8eZ8mKultJwWxQgsuXhxaYDK5GByE8JzwjrAZ3dZ+P4AJ145ivgpOgEiTYWdrWrwfe+VhVuuv2uw1FGDLKox+p0SW0IjpX1NH5paPtP5PDzIKM06ANEUFHU1Or4CRmtn/3UL2uKrfH/LGXrYGTkpTxSdTuZ1okoC1dg0y5eHy/p29dgh3iHgCbIBvDSHbpq37U512SFMms3eDZZ/AGP/Syn2Abl5D5PQOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAGT80EUGRL12zpHkdeX8A3ikyJlbOzY7G1fqV+T4to=;
 b=P+e6oImVb9mvWUs6xhscTDzEc8IJHMydA5Lpb4zVdoQ7PHZXMGdXCabBfrPEB3y7AD3G4leuULITkUdlrnZGOdZWmcnaa6ggB+h2f/50dWnh5RM4WcTeoBQpTdCK8ydazWZ2XbDbCNX+AOD0Iya8M7Vj9b1cGh6Zrob42if0wOdSv1dxYMhEP719t/JCv3l/CxY92m9q0ilpNmQU9WTJFNM7ea1HevWEJWG4yvvFA+wyE12XRCHu6ANy+FasorCG26P2RqW8PlzfICPg2ic19zQciQEWy2HYaAKEAPLDmr3js80RLtBqh4Q2iScAWuUbTrVpfKXzMTK4P5sn95VOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAGT80EUGRL12zpHkdeX8A3ikyJlbOzY7G1fqV+T4to=;
 b=EuKayKIdBybsOp0wT32WoTcbo15QBwj5j/zGww1j8nCa2nckfKcylnC2Brk6GDKehBF0sqZMynLQSS2hjJIXLJtq2psRXgTeGOuUVp+pyeREfSHN/Ck4N9nuLom58pP3L5XqGuS8vRZJgQcmSAOU2iqEURnodbK7q38sUfPXlyhkCqXinhDEK5bAQvn6aQAdqPUVA+npcuyokfi0EsT+7dR1tsrg4Gu/IDHGrLcL4oEWQyibpu7iAaKVuE0TTb+JGdClzTdeBh74Zk4xcMUiu/R7eOblLrlOWvtF4VpPlYoaFvzjwE6W2IQ4v04F2eRABnpt7PbV37Z8We65j3xYLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:19:47 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:19:47 +0000
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
Subject: [PATCH 02/12] sched/core: Skip put_prev_task/set_next_task re-entry for sched_ext donors
Date: Thu,  2 Jul 2026 19:09:18 +0200
Message-ID: <20260702171909.1994478-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: a73c4e69-9c3f-4ef7-4476-08ded85e1df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yrlQ0jjIz6hxb0Wlmqboyfi2uK1QY50VyyWiQtq/8/ZhM5Twg5Md7aZukJCLpXVLU49UjHfkp1AqtpobNOurCoN3oBO7Q/GAvKTdgdfU6bssUE7f4uXTf/Po00aot0UL7yF1mAIpyqSy9w8Diz1KCgOpVHgIQBOj5dIi0usGJYZcKh9JDInbryLvBfo8vqQy7cyamoIdf9R9iiVleT5RfKR26q9vf//lXHy3qLll0bB3ZQce/A148/vU6dsd6OUwslzVbsMGXr0Rf1XK1H5WfHBNtDNu8nEcC70EN+8QyGhtzKlWUS415U6hptybGr1/PadfPfYhSXQqfUjSX4Cg4naVj1ECOPGN+5T8lcz4De0URRyTuHE7ggybB8yhxvl7OJSmqVBJFYSFZDYgWhsNdkQtXYrAF8kw3duMXH7Ob2uCerQIA/OHGr1c5AfTEzAelvBoQ5eL9Lu5RLGGSyw5g0sEMgXxG/p59Wd0hQ7g6JHZznkZ8EPqpAULHQC7SchtXLH7e4asl4cbyiQR+5gSyDuoDuju4sJctcCJiCMo8QD8p+tgRzQpQIeSht7UTe1K3OL75UWW4cTOCE5OcwOTgDMZ6sRhf3vAurH1O/wzx4k23f2BrSmIrCeCxybZ29yNiR3UkY3AFJ0elj/JzBMRGSmVDEbDjC+uW/sYi3tQvJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blh8CnWqcpwRQE9++PgEICqS6YbUkL3jnDhuwPPtttac9hZr9LmcPz4DBs1e?=
 =?us-ascii?Q?AZeB0A/+XQRZ3f2pP00iVQZXKxoqRqoAyluxOIfOZ/vEXTFDh3D1SQ9rTcVz?=
 =?us-ascii?Q?BJ55FXCzYibWUkCLs9BE35/QMbex1/q1ffR8JPm+PbHW8AGi0axA0YLuB4B4?=
 =?us-ascii?Q?Nx0ItiD7t2E1PGz422L/nx7ZTIAvMYC2tEhFYP33Dqcfkdhc/Q6f9iXJ9dkh?=
 =?us-ascii?Q?x5FUiXaW45Ciw69eQnpYzjA2sL0d1sHcAeq3E2Ls4HXOu9EZIy1R7i3LRKn0?=
 =?us-ascii?Q?MPvxeU6cpWYOu3weiYyh7vNgKhv7b3Z7Tg29TKLWXlbEcqt/QG4SGHHbdmm9?=
 =?us-ascii?Q?oIPRp9noEX8pJ2Jp+m6MPxPFTAVJKQkrLXDPN7bjQh5GpCqm/bbEUiot0NMi?=
 =?us-ascii?Q?APBCBqrpZla4uOVOX+FoTVuxo3nsCgjMo2H9eGs6KqzCp0iCUkFZoIz7qd6x?=
 =?us-ascii?Q?Llp1H0c/6bvHdD9cnBQson27JHAXrbtbeLkH2ZXPcD9M/Xhz74VYnOJnyA7y?=
 =?us-ascii?Q?juk+jzNbDI4f68c1/3mK0anBMSMxtmRtai/6A56BEoQE+ROlSjtvYxV6qhTY?=
 =?us-ascii?Q?2hRc/AO7+dLFDGEpOb06OB1BHDLkExrf6mSv2BXqEg7DWLE2xn4t9gEARbxA?=
 =?us-ascii?Q?DPgb1vtDlZaSWe0OPb43HsV6/V0rruM/+9++EbMVrsiDHOgbChFdpjl6RFrY?=
 =?us-ascii?Q?GyXeNHGh/UfWKOR2LJjWokznm1KYNoBC2c5AHh20dx0DRxbVrCsxkFNk8J+B?=
 =?us-ascii?Q?Ia3ywQI6Yvf/03kWsZMFpCr5R3XvoZv3u86Pz1ua7NXLkVpfVPAiwLlCZpF1?=
 =?us-ascii?Q?ii6G5cV/V2ZXE0nbZM0We5pv3CDckn56sj0f1EkMMiz70AAQefSnn5luKqlm?=
 =?us-ascii?Q?HzGFGQjxTeP2idj14fOPs7GffsURziSGP2SzqDxq6pLh7omEAfJ02POrfLgi?=
 =?us-ascii?Q?bThGhKqzR1/Dgui5AT6Hk1j+ZCzNkaoL8et7Q0rIVezu2lbZcGHHYIEc0bHF?=
 =?us-ascii?Q?a1gaZN6xZtdw9j4a+RY28pZzhqxHsvESrobanWQJeOzf2/CdNYQOV4YwnCSq?=
 =?us-ascii?Q?8/LOYE9DM41pQM+ny0DlV4X5E6eX9g11dXbqjGDaSoVC/Y/0uZMoGrZvyFGR?=
 =?us-ascii?Q?FimLcrC+xXCAlsiBam1kP8b90OaRQsuIBCB+zYYSZ0gu1lKqZA1cjlj7/Doa?=
 =?us-ascii?Q?pYPf0yLaTmi0OYv9RyjjVhbhAYQ10gAKvTukkSvRzjEVfuXR3CIF9tkCna0w?=
 =?us-ascii?Q?AjoUTff+1DUPicP22VY6HyqE9OTRR2USJmRILHm3CecnEoWxhguyh/kEHHWq?=
 =?us-ascii?Q?htwgsIgpfs2p8/8dGNWy6MANrDPDRx7PECMz8aMbpFw6IRMwAvDa3a/vTLEh?=
 =?us-ascii?Q?WEbKHg9RRWi2PB65UGbge18GChPHChDSkGxTgOmgNE/gKTXQnpJbrmCIAAe3?=
 =?us-ascii?Q?RPjOzv+4PSSNXOxfF3E0Iog9lgOLYBjY86iVFdpAN621A+Oiy1jHC58sCRzb?=
 =?us-ascii?Q?bqQYixhfXFJV1SJ81NpDtnZvLUnrWGQXxqsOOeTZlggbf5dO+RwovZUy3Gwf?=
 =?us-ascii?Q?fSH8YHEYohz5R0YMMiaZXF367qAVEmoEuyRCzRVO67OFSPS/fwdY5vETdvcR?=
 =?us-ascii?Q?7Kxcqa5BHwNTnn6pUFeeiTytqu3oOWgCGdda3DVUwxAYygGQl+Pubt6SpXC/?=
 =?us-ascii?Q?d3cAcT6+HXGwscOd/1dhqX+DLeBjhLDIAtTPXEaQu/C7hYrrEDQt/BmIeher?=
 =?us-ascii?Q?Vvo3cPQEJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c4e69-9c3f-4ef7-4476-08ded85e1df6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:19:47.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8JBAWRJq8r4qBv++lh47NH1K76vJ0Gz7IXcrA0gam1On6HS68c8ocqOeyDOpx6etql4AbIul4KT5NXdu69SkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

In __schedule(), the proxy-exec donor-stabilization block calls
put_prev_task() and set_next_task() when rq->donor == prev_donor and
prev != next.

For sched_ext tasks, re-entering set_next_task_scx() for a donor that
has already been seen by BPF ops.running via the normal pick path causes
issues. It fires SCX_CALL_OP_TASK(sch, running, rq, donor) a second
time, and sch->ops dispatch can land on a vtable slot in a state that
yields a NULL function pointer or corrupts the stack.

Fix this by skipping the put_prev_task/set_next_task re-entry when the
donor is in the ext_sched_class, since sched_ext tracks curr/donor
itself.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8a3eecc7caf5d..2e4c98b4ea6b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7185,9 +7185,14 @@ static void __sched notrace __schedule(int sched_mode)
 			 * anything, since B == B. However, A might have
 			 * missed a RT/DL balance opportunity due to being
 			 * on_cpu.
+			 *
+			 * sched_ext tracks curr/donor itself; re-entering set_next_task_scx
+			 * here dispatches through a stale/NULL BPF ops vtable.
 			 */
-			donor->sched_class->put_prev_task(rq, donor, donor);
-			donor->sched_class->set_next_task(rq, donor, true);
+			if (donor->sched_class != &ext_sched_class) {
+				donor->sched_class->put_prev_task(rq, donor, donor);
+				donor->sched_class->set_next_task(rq, donor, true);
+			}
 		}
 	} else {
 		rq_set_donor(rq, next);
-- 
2.55.0

