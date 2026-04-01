Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA730DEDC
	for <sched-ext@lists.linux.dev>; Wed,  1 Apr 2026 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080598; cv=fail; b=XFVBeJznFDXoVTUZvbWvQ4157010Dey50PBGU9iUTGMwgFVWbB6cO5xvgQKK/EjxcTVQ6ThVpEDjgpHEGZb8waRFhlBrCHcmIJnHEXwWy8Xd6mEqUadTkkBtDvSshq1IdWhrVKFclCF2PH+Nu11wMX1iQhC8uRBG/ropHSnJ+oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080598; c=relaxed/simple;
	bh=0FpGtBmkNqsVkEj+ZuwMkVQCNYY0W13vQ0GfV5S+ctc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KnEOMgXtQrmpVyBwQS0V+5BswObs7YKn9PSrBAT6BWsTykJKlvF9GzeOXaChDPVc2gihP1aEyV6dn2LKBE12ZnVfw73cbE8GMBYWLwxtjQmHVg/5bksNzbq/FYNmzlyvovM6PG4JPi5nvtiRtzS+LVD7AlF+GJILb/TahhGJuDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IdYx43pQ; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IdYx43pQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYSDZK8yybtRLB8vOqWpxpa8o3auSsdWD3qQZk8sn2JWBGKmDNXBypS1OaQjtB9pB+mBve28Oyz1xB2LEIFXqas5IkTycU/D1RhM5tsu3msjJSmL+1ptSnpl7FkG/GhBjMLt0UPODtR1DbMmcv7Wi73KvRxe6yOWN+eJTgwmoNnWxrjQuyOlVTtOCKqq+V9HJ5P1Rp1wrQT53yawpGrFqhjDWSMTcnf8jfAu+GAGFQGVVQ1/REP3xOqqq7fjTzPcGw8fC0Kc1lBk/oG95EBsx/pLFW+MPTZCFrhDu1HrwODFisKSA3/Ujzns4550tMWv7exPD01ID+XiTT4iZXExpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf3s8VR6PpPmIkrXo73Mjc92kvmQqzA7O4dqWep8mek=;
 b=IwI97756cNAzHvMYQN99lA+HroslDDxdfePp8sCx2/Ho+l0jqu9o/bbJkuvZFXtzAHSL+SyOYa/P0emaVv1bX47QJ7E/f0rkeYvAypt//kW3UxBSYwREOuPMv1owFxvmRC94DKzGpfcXOv2OkPgVyjq1ePCth7jgOdchyeMfCF3QfnntuaCrq5Gjx90gU1mLrUsSL7DEj+3tivtAK+Tr1Vt/YZzY2jL72Hy+fkPpDLEAw2QbDIXbNpKypONTzhg5NoW2/7LLo170mjuZ++aXJ4vm9n8G8R9/ANsxZg3Ehxu2rgNbddYIN4K73n3e05sJaRbCs+L/bRQNVrMzpX+HXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf3s8VR6PpPmIkrXo73Mjc92kvmQqzA7O4dqWep8mek=;
 b=IdYx43pQ3mNXbXyAYl4spkKIRnbTz8DL37yCKAmLYCQStRoj8SCjENM29Eh73T5lSuSq9DKp0kaxOqE4fko9IWMASCBW07G0DhEC/Gx77jQKpjjmukMNjmvB7zt8cILzgVnAQQGFAlUeNcm7X5UPZVTASYQVYi90t4is1KQAvlP1iZuqR1TsxXoxcEOgt1gNTxsuTjI8fxl2mQDnzYJcU72uqTnfG9VHzR7HllqJwYlvLDSnn8l47ljSeYftmaISyMUIClR9eX2jYw/rmVr8ysJDNsykMzfsMLldRcT1Y6JfuTXUwEXFwm6FZbbdwlEB8h566ktLYCci+ZisXJ7C6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 21:56:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 21:56:29 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Date: Wed,  1 Apr 2026 23:56:19 +0200
Message-ID: <20260401215619.1188194-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3765c4-ac0f-473c-fb8e-08de90398756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	i+GIKE3q+wFwZXgQ4aNwq6LX3Ac9P3C13CIAim74MXutEjraUImuFAKIIWh/frNXV8kfgP+wFQY349Q4zc6W1BN7zr8vM4ehlEISlQe9fsfynVT08Xt0DiHpIaPcVYMo09wPlwawPX7S0A8Iervr/x91LcQWA/uSgH0mpV+QuybNCrbDZ7vQTzD3Vu2c+N+Y5VjDbMYdxVaHfTuHr/CttQDjVdCuBOWEKOfQpXpj77hiQXlaR3amARiQ7c5tjD6gtz5KBSrr3+jseGCOjRbOvjPeh0P2Y8FgBwTdiabLcuQXF1I3NRng34JZ36IeLNICZgyssTGOuO5M7eQX4JkQ+Oa0ZPPMWhs8CuHCJ6AZbO/xLgE2736b34UKWj141tt+itP53DVstI8UwxEA8NveKA8j6RoTSxjkArL39zQX3OeFnCrUzViv3kjZMyhJV/d+a8EtJl0k3geZcZM5h82GjSIT4bGgYVzi5KBMtcXoUQiIQw9GCmmNa3hINw3q+z7oD8hSCodMgGRVowauNubHRpEDZzNDNYjHV0fiGbmLNns99hhCNBiux7utwKTbpp9OxwrAKrd0mlv9qWKWpiz+qy3KBiDOb6iznQVG0e/sowpARw+6So5bpWEbDx4wcJValjvPxVwQWQlMgG7CWVXcaoz7aFSPX0O56WHtvSIvQxiYPR4NQg7ZEpYJ2viFjtaQ5BWvdm6W6trlM5R1aPZ8L5QxwwzFPMhRCex9nRvJmaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPKlqC7V57JNDwANZlGU8YDxuhuARgqbt7IxFkYEbUcu1Vju1gk221ETftEJ?=
 =?us-ascii?Q?gsYKefJxsQQGKF03zo/kdOSFcegrihDtEoL1NrQOLHOsmVIfnzFyYs1pM4FR?=
 =?us-ascii?Q?8gtXrMtwYdkSpJfkwvHCQC0N7R9kdvawVKE1QwLhTc8H6ekfgzi2CsPyZrC+?=
 =?us-ascii?Q?Cs49mIRKM8zWkmZUr3D8ZimQ4S9EIPV+Kj1kAZsrmi4UeuNUAau4xU2GTfVS?=
 =?us-ascii?Q?8iqcGPFVjpf4LyIO8gPKnYgljr64LWHNfriSw4NKYQ/WjAe23wu0XJ7E0umF?=
 =?us-ascii?Q?fhrRHkwzemUNR9E2NNXn8foTP6qm8zDMzwpvgGW6STQfJT3cOXV/FzCRzK5V?=
 =?us-ascii?Q?r+Bd+vmou4cFHzjs7XwiYtEiiSpsJiX1Xx4lHbq/KfzVDVniYG7w7xl7gUsz?=
 =?us-ascii?Q?jCtlQeChDGYhkGCg6tbh5+3eQ4Dz2n7nS9IAptDpxMoLC62lO/v8fcokujmi?=
 =?us-ascii?Q?EtVYdj5XbFJS6V6N7IPS6csqfJ3YBjs14bSsByHspRKenNEW7HZluuXeMo2T?=
 =?us-ascii?Q?WWgw47wjOo4Rvqx0nOUfqVTbLn8mR3TABb84WOZ/7qDDw+I5v3ClL6K/NrDs?=
 =?us-ascii?Q?eGeePLKHrnhJKktOk41Y1METdy6RXWJbkGYW9oOKi11sSaULu8mBXczc3JFm?=
 =?us-ascii?Q?8K+c7vIjY9awm6ECjZxEkbkFMS83v7rYOir8mXnBTgOC4X6pcHswYlVWjZFw?=
 =?us-ascii?Q?h42TNKeYDiyM64+x+fIR7MUu2czRUR5819gPxbcnBm85DfSbhMg69TDjt2gn?=
 =?us-ascii?Q?B5hpNORglKOWG52S8cMso1oxMgyPUvpbXpuUBIuxhY3SBm2CqxWa+d+RO4+x?=
 =?us-ascii?Q?OwI2m9lVPlA/PPFZdcZemcvP02xW3I9c19jNiNeSysf76Tlla/8J2LW1gu/f?=
 =?us-ascii?Q?tvrTnBIgzTC0bFycIoDaO8NI5+cEGMQZArINfpKFw9pFpk5+c+UcSNKJSFEz?=
 =?us-ascii?Q?tVD0M2As8O2h49PYw7I4iciVkS8O9C1lXXwTNafUVgkpJvhPmUQFDaa2AZ67?=
 =?us-ascii?Q?O/e2vH0Inx/MoNIHDhuBMlROynT8FGCgxsLmPs4nLffbGVP3UtOQjzWybOGB?=
 =?us-ascii?Q?y+TG8KSFdI+E0i1ez7aUIgKhbillrr0eXXzjnPYMROyDp4XvyJeRmODUgn/O?=
 =?us-ascii?Q?44uIaMjWnZfFExWV/Vx8srWKOjh0T0xsxn5tJh07TYF+YDJEiJHYc6EcM+Ko?=
 =?us-ascii?Q?eEP7NIJktd0toUpcOZDfUVdNbrEQt0OZ1XN24je8uUbdZoGF3L4Pge1qyKzE?=
 =?us-ascii?Q?ZRHzH0Ox+VEsL87mM5gfuZiMKwThzsznG91g0cLFa6x30lF9u2JLYSMKYOTO?=
 =?us-ascii?Q?4aKAClAg8zjgmZt2gHbZFV2iMP9jabohAbYd/5W6b1x1glBnobDfjJg3g1Yp?=
 =?us-ascii?Q?Bud8pwc8JTnBa15hDh3T37Oxl7cxex8oAVvS66AdkJ0A58igt1TmHBF52fVl?=
 =?us-ascii?Q?w6VR8iLHVAJIZKTaUPCUBNwvlPTGX9DV3El3BjoaSUWduTCcrmajPhDHconG?=
 =?us-ascii?Q?fFpz3H00s66bvYANJK4VkyXu7RoLVgbpIWraO7o/cUL3S6XwK4PbWmm5gqmF?=
 =?us-ascii?Q?Tg3t32ZBoHghXITI237EVeZGSnmGN4r7rtg5bIQvHOAy7lGMnxrpgu4cdMkT?=
 =?us-ascii?Q?F0/1fuXdX1YWAUX24JUJB1/JL6DMWsWJOqWw01JlDbNTFSfQcmjCirWEuJZ6?=
 =?us-ascii?Q?6I9ac94pxP17nTLp2MnU3dr+qQnfTaONGFvCyC0LgR3Ubc3jUjejPsgpXJwT?=
 =?us-ascii?Q?9KzwOlwDMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3765c4-ac0f-473c-fb8e-08de90398756
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 21:56:29.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmHDLgJkSe838KgtFvUOaPxUT/nG7l3+N1PY8n/4OemZZG0ejU68Y404cDmjXzV9/J5k7oisf6uVTmJI097gNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

@p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) in three
scenarios, causing a spurious WARN_ON_ONCE() in mark_direct_dispatch()
when the next wakeup's ops.select_cpu() calls scx_bpf_dsq_insert():

1. Deferred dispatch cancellation: when a task is directly dispatched to
   a remote CPU's local DSQ via ops.select_cpu() or ops.enqueue(), the
   dispatch is deferred (since we can't lock the remote rq while holding
   the current one). If the task is dequeued before processing the
   dispatch in process_ddsp_deferred_locals(), dispatch_dequeue()
   removes the task from the list leaving a stale direct dispatch state.

   Fix: clear ddsp_dsq_id and ddsp_enq_flags in the !list_empty branch
   of dispatch_dequeue().

2. Holding-cpu dispatch race: when dispatch_to_local_dsq() transfers a
   task to another CPU's local DSQ, it sets holding_cpu and releases
   DISPATCHING before locking the source rq. If dequeue wins the race
   and clears holding_cpu, dispatch_enqueue() is never called and
   ddsp_dsq_id is not cleared.

   Fix: clear ddsp_dsq_id and ddsp_enq_flags when clearing holding_cpu
   in dispatch_dequeue().

3. Cross-scheduler-instance stale state: When an SCX scheduler exits,
   scx_bypass() iterates over all runnable tasks to dequeue/re-enqueue
   them, but sleeping tasks are not on any runqueue and are not touched.
   If a sleeping task had a deferred dispatch in flight (ddsp_dsq_id
   set) at the time the scheduler exited, the state persists. When a new
   scheduler instance loads and calls scx_enable_task() for all tasks,
   it does not reset this leftover state. The next wakeup's
   ops.select_cpu() then sees a non-INVALID ddsp_dsq_id and triggers:

     WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)

   Fix: clear ddsp_dsq_id and ddsp_enq_flags in scx_enable_task() before
   calling ops.enable(), ensuring each new scheduler instance starts
   with a clean direct dispatch state per task.

With all the fixes applied the SCX_DSQ_INVALID warning doesn't seem to
happen anymore.

Fixes: 5b26f7b920f76 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches")
Cc: stable@vger.kernel.org # v6.12+
Cc: Daniel Hodges <hodgesd@meta.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 26a6ac2f88267..de827ce0ffb74 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1163,20 +1163,32 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	if (!dsq) {
 		/*
 		 * If !dsq && on-list, @p is on @rq's ddsp_deferred_locals.
-		 * Unlinking is all that's needed to cancel.
+		 * Unlink and clear the deferred dispatch state.
 		 */
-		if (unlikely(!list_empty(&p->scx.dsq_list.node)))
+		if (unlikely(!list_empty(&p->scx.dsq_list.node))) {
 			list_del_init(&p->scx.dsq_list.node);
 
+			p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+			p->scx.ddsp_enq_flags = 0;
+		}
+
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
 		 * @p->scx.holding_cpu may be set under the protection of
-		 * %SCX_OPSS_DISPATCHING.
+		 * %SCX_OPSS_DISPATCHING. If we win the race and clear
+		 * holding_cpu before dispatch_to_local_dsq() completes, the
+		 * in-flight dispatch is cancelled and dispatch_enqueue() won't
+		 * be called. Clear the stale direct dispatch state here so the
+		 * next wakeup starts clean.
 		 */
-		if (p->scx.holding_cpu >= 0)
+		if (p->scx.holding_cpu >= 0) {
 			p->scx.holding_cpu = -1;
 
+			p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+			p->scx.ddsp_enq_flags = 0;
+		}
+
 		return;
 	}
 
@@ -2945,6 +2957,9 @@ static void scx_enable_task(struct task_struct *p)
 
 	p->scx.weight = sched_weight_to_cgroup(weight);
 
+	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+	p->scx.ddsp_enq_flags = 0;
+
 	if (SCX_HAS_OP(sch, enable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, enable, rq, p);
 	scx_set_task_state(p, SCX_TASK_ENABLED);
-- 
2.53.0

