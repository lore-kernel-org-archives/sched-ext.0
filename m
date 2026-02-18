Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43031145FE0
	for <sched-ext@lists.linux.dev>; Wed, 18 Feb 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403855; cv=fail; b=tTPJJyH90gKBr1l467lxer9wF2A3Dws7bh8Sm0IiCmNvJ9M5R+eVn2BMYpcVFzGpHx2Jlo7hr4I9IMs9CRP154LOh1J8lHaT0soeIwGEngW0m6Dh8Z5rHvEWI/uXNA2AoI1n/NkuV/KQ+ec+KZ4QiTwn6EmIUv41iceA8ta+7pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403855; c=relaxed/simple;
	bh=65aYI5rcDZTXAunvrBsL4vT7K8muLie4ULgFnGoGKrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOAXOWS0YizWgFxZ8KrUJLGyWyVAGHIA+nSuz5tDLE46SWKOAR3lymUN/fmSHSUSXpMpnZnk1vkbCTyugvGeIfRbbwtZqDRRACKo4Rtq0uReCVbwZqITp9E8KNjIjDIvXZDKs7VpiVU7LdBiqC4MPIUU5QCegK7x28p40O6irHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IeMTLhq6; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IeMTLhq6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si2mDyLGznAO2b/7QDucCY1zKTgQgBAbpxxHeFaaMbPPLUcGzg0jtvaZ30K9RD0UEKnsPzcsWUbEr0yMv9n7TjoiSLMabh0prVCNVtnrB1S+0CXFq5xQx1AOpSxnYxRKTJXC8yr+glSrDM2yvyWJmDT+0i66KbrQ5QwZJ3IPUjcUgdEJvJnXI9gwHknb5PxzcWLeRYfzTuOKbk7yT9xeQfRwrv1WvMjxWmKmaltwfWANnt3lGnDTJECl+LVYneSJu0iH1Fpo+jpVeqscThEtM9wGPHKWTRry9lWINNfiYhoS4+GqAfCrVMzZhyYFaMKoMrf4Nk92+SU9ZRSzkkslJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLN1USS68cGiCAyVVlADcOputiA4qdxu7hG955L9DqA=;
 b=W5po1IFBNrYnpwztqKVU0/KlxJypmghGYmtwwDMNfWKUvppugxfNlZJQrWLF2KrdtYswzom8k9Tf/pIiQlJpRGrAaACr3h7qb92oPwihsMceIF+frcEznnq31nd+9CS3Pt+nW6ZVFUXeoZ+HaiQKx+Enqxn1piCfIwIW5pxYiQfSh2Sy/SWYSS/AgS2MzfsLMHB6XcXtFSVaB6kImrixt7OGRrWBSUlHGPbQERM/Nn8e1EtHnAuVUFzwvv8M+MA1GVxPZUwglp8u8jVHonoatEejBic+t4k/Cj93oLk8zRTIEuomwlC2G8MZfGVtP4uqWfobPN42PczMUCpsoeGv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLN1USS68cGiCAyVVlADcOputiA4qdxu7hG955L9DqA=;
 b=IeMTLhq6RMeP3x+uOXe4yJC+pbX/Ty0QRxdxcBtQCRT2Jvs6iaNnfh8UPSaC2FVCX6b46CTyV33H2TqI/Dm9I0o/J5t05c3zPrmJo0aI9aHq7zUT8v3rua/nkXxf7IhFV3xZNaTv6BYwf9p3tGaIHFGVm0CL8koEBmhJXG/sTsONeiErcKF4mD/vlK6aM2Vq/7wQ2o3rPCe0ef0wQHiAG10bUuqNwQ+o07qzQbDH8RwGwStOQ+eEqP01kYhVEL4L7+ESIOcPclfR6tIhYfkbdNkwMeYL7x6oPmhoBpByKvh/0Kx5KAzwlquo7nzg0yEINl2PrwM4l8NGGNy2PvEfFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:37:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 08:37:29 +0000
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
Subject: [PATCH 2/4] sched_ext: Add rq parameter to dispatch_enqueue()
Date: Wed, 18 Feb 2026 09:32:16 +0100
Message-ID: <20260218083703.22785-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218083703.22785-1-arighi@nvidia.com>
References: <20260218083703.22785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b9d980-8d82-4033-6876-08de6ec8f3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vb9NF2fLQDchFNepAp2m1ZyrWpdk0ujkkLr4TzfuLNs6oOAK6mYNRm3gVmCX?=
 =?us-ascii?Q?WQ1SY+K9TLQk1dvVPwT43PA0jJlZHOXSYuhYmDfqmF3ScE5oum67D6EMd+ps?=
 =?us-ascii?Q?WUIGjblXUMxpgrY/3JsTUALfxVF5a/2yq9bGfUnEQxajouU0sYlroGBoDjRw?=
 =?us-ascii?Q?ns8OJgW3iR4KBj2Urx8d/uWzOmxa0RnCWFQsTKX0GK5eS0WV33a7mRi3abg5?=
 =?us-ascii?Q?Ew1Z8K2CBb8BuqErc4fRWWFAevG6FELD0ZHU77yvUMi8I8KCtu/AhHKOl+yw?=
 =?us-ascii?Q?iva8Z3oqS01eSTDpz86pgO2oCWZy8iQBDr8Ku18ofvSQ2YWBMY9HxzvJM/PV?=
 =?us-ascii?Q?dFW73qVfhEO+nk78q0pzbqt5Jdjuxmy+NxznrJg1DTTMKJ4Eohc+5j8WciIc?=
 =?us-ascii?Q?IXyNMBwy7ImRjFtIrbAVUfrImekJGyEdSKN8yc6wGYuTqF/JPtZO0iWAxJcj?=
 =?us-ascii?Q?CrBj6+SjlzNEcGpRPbVM7JZV/Es60aT0eIgFd0aM43TvjfPf8HPIyUCIqyNH?=
 =?us-ascii?Q?NJN1KRjqsQ5BA7yMo+MlIJV8Z2ZktuRBPHrEjAPeWg6UReIaIMoAeDFTPD01?=
 =?us-ascii?Q?aOz/IebtN7RWgRIoLq1n8djWVtlDCiKqcd3Q4Z6NjjPns8OKNh6XFIgStkgp?=
 =?us-ascii?Q?lBAvqp89oCRiWuToKTnD99+PRLiwDRGHJqlJF1t7iK92UWT34jIaEO0Ca9/O?=
 =?us-ascii?Q?lZCf00ah7cwODcuJKZjIKTRiVCNqvbaK/zsQhfsCGzg3LiAXQPt0Vp96ie71?=
 =?us-ascii?Q?F8q6a209rIUrjBsUQBFY238YLnPWwSQg05qD7zn5Cat2OmTL5lPZT9cLTttP?=
 =?us-ascii?Q?44M65JafsKK5184HNJtmDBf+YHuQuVQiKYcqCsSiMDd82e7xE870JpGZMG5u?=
 =?us-ascii?Q?FIMTe1foLbRYN6Ja67+jFGjnk8ZDW1jO74ZL+lgEOuUXP2lq1+oUj8qr/KKv?=
 =?us-ascii?Q?nfJNJu0QIwyjsL1IlYbz9eQtY5ehTiOl97Puqf94On4AB02VhLqe6j/gB+q7?=
 =?us-ascii?Q?VubQ3K0zsyxGHvNG8PuSN927lv5BDmIs4mPq966lRGrMOTy95MREz6MfdmvG?=
 =?us-ascii?Q?MDFKgHm3qwU6SGjdtBnpctL+5WD1ePB2txyvkYpCmkWAInQGxH8yN1s2chZx?=
 =?us-ascii?Q?tSOWjztb0wQK3uuHxbaO8SaRkbpvJ2aYhfNpJUL+iIAxWCKL2XXYxmr4CLF6?=
 =?us-ascii?Q?xWjqqslK3wsw/MWuboA7BuE5sdRJTpiufCdtGgRpTF9yEAiXTWu79mkctpiN?=
 =?us-ascii?Q?TZhbiX9mL33B3mA1ecYZKcWJXuqfBEW94+A4uIoZ6u8JEIbERm0WlsnAQzhr?=
 =?us-ascii?Q?yDZa91zXT16BIrBrxse3LI2o7DksYLD+SWUOG2XKMusv2bCxnLx7kdvRX1zz?=
 =?us-ascii?Q?KfiReC31ubJgcvNrswcGQ26aAn3AFebIFktDWo5ckwrdHMAEHqIvnaLUHKyP?=
 =?us-ascii?Q?hrAKzCyyHdhRLUp9q6i+lr8DFYVj4Chm7tdMrSidA8OMjzvC6DG+DTZgHeVc?=
 =?us-ascii?Q?L9SIBOGGiYXKX4GO/BEMf4dzj3u0cBqohKAiXnE/2qlp5fnyH/GWrEDJASGr?=
 =?us-ascii?Q?6PHNh26uJKovynbQ5gk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGdFGh8q+xsdBdMg14shlQNwhPgp/25SVLgQsdjJXIFjbIDastj8EUZR6k9m?=
 =?us-ascii?Q?8IwPjIA5f45wvG0LKWmOthNnUNJWyTrRmA3Ndy4BnA33xVUUbqF3Jcd/MA0c?=
 =?us-ascii?Q?H3SqFbGh29wSDxMqNcRDE++o5d2kB3KIWihYVYVLS+3+Qf/ZXHuVYqwAeSx0?=
 =?us-ascii?Q?b3BMRLiy8DZ2QDlHmrOPAfwNcElF+1VdC1g6hVXQhoQaR5nEufk7LwlYTVnu?=
 =?us-ascii?Q?44RcMSoTFg89Uyv6mwY5Ak1Win1dbEe7g2pAc737ASRtuYO0yjzl14kVUHaG?=
 =?us-ascii?Q?QhoTCq4cRq8sFzSbug5n6PqUWifZ/dyyWUcHZy5PjsN/MI6dGnTpHN5jTCW2?=
 =?us-ascii?Q?20qRqGJGswT6gCb12PFAmQEfKQkprIcf1oJadUf1NOg0Km7WaxJ3YZvXNxBe?=
 =?us-ascii?Q?232ZW/DNn8PQHIxJdFy91eOV3pgMHgcT8Zz0U7cSg+A53zFaKWLZ0cVYXOlp?=
 =?us-ascii?Q?AD70dzKc5qSS9f2dCaQIu1iHUfOpXX88OL7IkQDxVtLV4x6dQHRq0kGPFAjQ?=
 =?us-ascii?Q?AJV9CB1CimoOHCOaKmUQS9huv0SxsVZWx5IYaWLVDoyrjn6G+rcxyIGG9Bsa?=
 =?us-ascii?Q?GG/Cu0K8VulTQl11oZDfwH3KM5M7gqcV0zibLLeYpomfF2qXmY8Hhhl4iu1Y?=
 =?us-ascii?Q?V8u/70lx1lr8U2bVDHxSJmjtg9N+Fj4Tb78SOzS82NVb2cslkfKyE15GIV/t?=
 =?us-ascii?Q?FVctaP6MN3DDJe8RDJWuchpvy1zmrm8swXXQlcOhI65g5BZN8858hnlSJex+?=
 =?us-ascii?Q?//f4vH60GoNVF12xHu5qgNRCV3LpzgIp6eHiVCZ4MD1556/tq/EO6BocwCAg?=
 =?us-ascii?Q?1s/ik9lfcYlisNVtbHpEs666tZvWCJVGugoCQvB4RtZ/Mv1bHE+mIHCehB2n?=
 =?us-ascii?Q?nf9dIJ015D1JNqh/koRmEklgs53IFtlvzosgg2UP4Sxg//WmU5M54Kp9QeyR?=
 =?us-ascii?Q?sYaW7jsgKnQnaBLFk7+8Ylb1OfBf1vUsUIVOZZj/AyRPDrezbMGUNTW5FFJo?=
 =?us-ascii?Q?YBhs1QJAjJt1Ig2ubQcIR7y3+5HwNfGmP3QzqcDDrVzKVeUrevvM+8cg7v16?=
 =?us-ascii?Q?Mr6/QIh/rgRWNuUg6ghQFEBRcsmyPSLv2s5Su8N47Qk6Zi5cOzhCqxiFeXTD?=
 =?us-ascii?Q?i677QnwJCkdwUmOpuCFJoZRUMuulOXYy2l1rSfuO5D+crse163IoCAVzSGTD?=
 =?us-ascii?Q?XYsIykeCvE2Pp0UfpUrqQ/LcN4i9+X3jaO1vP2ZxNlpXBo54pmwGPdxGNhnA?=
 =?us-ascii?Q?/NzbLlfmLtNG8kmUj/nOT76chXzLpPoJO3s8kW6SP0OEEwGH5uFSlrjmDs6n?=
 =?us-ascii?Q?BuIYm1GhSKWuBmg1LHOM8UnSetQyk8Oucxna2Nu+Vd8R4LOKVSjGjCti94Ot?=
 =?us-ascii?Q?sYzy6JpJhBq25xfLZx0Hq4qL2muez58PkFyiLxN4w92gTCGnBX6cv3bKn1D0?=
 =?us-ascii?Q?5eeFbhfZ0qCXilFm1a9OkHVUumWI0gh24AmwM6Bkni5yhlFdaV38M5g5ZH9V?=
 =?us-ascii?Q?YN3F02GdpSd8slK6WZoSAY6q8khEyFaN2qUxolmI7JkErcVfsJNJJW+TCuBN?=
 =?us-ascii?Q?jL6lq/sXugp3OJS0vEbXvjCD2QdiDJd0DBK/rb1Q9OIWSCnjF/6Pm+WIgn3F?=
 =?us-ascii?Q?y5lCcnNuo53OkMRUcELQ3Wl0QGebR4CPkHqxKXc4RyD3aT7msMcoHBj1YY5y?=
 =?us-ascii?Q?O/1JtWsRxhKDYC9rJdTDuy7LWUEpQKA2+m3myKSEwtypSV9EV1nzLVm+VK08?=
 =?us-ascii?Q?LbipVVTm0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b9d980-8d82-4033-6876-08de6ec8f3a6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:37:29.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk6CxxydFheVP7WlqGRvz5hAGdheVyGNveFGF7dYNsn1L46q/rf9dMsQXsdYwKW7xUUkB9JE49hhRCch5nSf8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

This prepares for a later commit fixing the ops.dequeue() semantics.
No functional change intended.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3885dd06dd573..9820026b74557 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1010,8 +1010,9 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
 		resched_curr(rq);
 }
 
-static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
-			     struct task_struct *p, u64 enq_flags)
+static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
+			     struct scx_dispatch_q *dsq, struct task_struct *p,
+			     u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
 
@@ -1325,7 +1326,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
+	dispatch_enqueue(sch, rq, dsq, p,
 			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
@@ -1415,7 +1416,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	direct_dispatch(sch, p, enq_flags);
 	return;
 local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, enq_flags);
 	return;
 local:
 	dsq = &rq->scx.local_dsq;
@@ -1435,7 +1436,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1888,7 +1889,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dispatch_dequeue_locked(p, src_dsq);
 		raw_spin_unlock(&src_dsq->lock);
 
-		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
+		dispatch_enqueue(sch, dst_rq, dst_dsq, p, enq_flags);
 	}
 
 	return dst_rq;
@@ -1978,14 +1979,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	 * If dispatching to @rq that @p is already on, no lock dancing needed.
 	 */
 	if (rq == src_rq && rq == dst_rq) {
-		dispatch_enqueue(sch, dst_dsq, p,
+		dispatch_enqueue(sch, rq, dst_dsq, p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
+		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2023,7 +2024,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		 */
 		if (src_rq == dst_rq) {
 			p->scx.holding_cpu = -1;
-			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
 		} else {
 			move_remote_task_to_local_dsq(p, enq_flags,
@@ -2122,7 +2123,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	else
-		dispatch_enqueue(sch, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(sch, rq, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -2423,7 +2424,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ.
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
-			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
 					 SCX_ENQ_HEAD);
 			goto switch_class;
 		}
@@ -3954,7 +3955,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		 * between bypass DSQs.
 		 */
 		dispatch_dequeue_locked(p, donor_dsq);
-		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
+		dispatch_enqueue(sch, donee_rq, donee_dsq, p, SCX_ENQ_NESTED);
 
 		/*
 		 * $donee might have been idle and need to be woken up. No need
-- 
2.53.0

