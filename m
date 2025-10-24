Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BF38DE1
	for <sched-ext@lists.linux.dev>; Fri, 24 Oct 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343277; cv=fail; b=NkgztGw2Kea1jz8SBWnQUYmmhO51GLUVKMwatigUEFy6jt+PmVTEjomwFs9vwXuaErG2cGxTFpYCHeJZG5RHMlxJdP9in/eDF1Yv7ae4ZnxQn/0fapWOo2hxhz+qnNMXHqyTYT3lUASLp7d86acbuSlhHYylmeh8UFcA8HkhJWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343277; c=relaxed/simple;
	bh=1vIRFTEVPmfzuxOj/1lVblkL3YH6fr5NpAu90ONJ+To=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bdmQtsCe3n2hGhBSKKT6YXd5JDbvqfPIgASivxkJZDkeJRNM614f8XhSEtHJExDHvXkOoCBOvbtLE+seIyeXlYBTvz/IWTJdDUOHZ3DsOwbvsW9Y0Tc4tIVf+lQOdXHxdOSwFgsenGixcgiTQvG7BUyxp3OCsM16rMm88LRfm8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9Oo6DmM; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9Oo6DmM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7ZVsO8QCH+Ba6WSHzqxmK/Ud0h8jin6uI4a6Md+81Hsfu3DKkLRmjO7JHLAb7jrbJIWjD0COh2VC9Eb7Q0B8ypajskF3Zf79B6XQTHeyEsroez6X+dkZGE067Dax4A4AbNb8SrDEFCQSDUdmiCaNUFwT1TikA24wItLvkYO4QtSl/G+YSa/7FjJEQsZTInsZ93awmcSHMyfcZZ8Z/rU20ahcjsXhagS3JyNA/u5gjIer+eI7OskdofYWMlmuFsWf4R5AjlFTYMJto7n71ufu27KfPSu3IFMNjZ4gLjbSzonhbwKQdncRp/tDvZ4v5DkOEU12DbigRA05nHRmZI+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfkslWn68uMiN2PyOAUugf7+9yEq/oGFEjN1rSiaHvY=;
 b=M8q2qICRwQDFx3PNowfLLxXuvXdu0QgQD7TZ2K4r56xKSpBU0R8L+DSEuFOvO1FNFJ3kSe/IICKuPI58dVrqMZDGGW/od56I0j3j6+i12W8YIXN3LnBcV4kQs0eL/N4VNEkj2A9y7/8KVRhOJnh5EGS7RcSi3K+iut65pjGqfUvQfZJqBbHsTgF7/DXhuuxdFBaYWRB04LX6pzSUujyvEpBEdHrDpg0IIU7uZQ+FR3GdU7qaJevuu+XfHugV5G7iVNpr35bHDpG3vznQ+RIZLKSMYzyhYGECPhPT2ypa6juWoJQjMnHKfblZnoijXaq4JZcecsTxIj2gSfeEmww12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfkslWn68uMiN2PyOAUugf7+9yEq/oGFEjN1rSiaHvY=;
 b=t9Oo6DmMp5OL4rGxLOoX2bss1HvLD66GddgDy21Nea9UrSGBfIBVzQdffZavNdnL4sHn4O8tJJWoR3A51y7puhjrK3obdeXFyp9zYCscMkhJAEJFpD/unmNZhG8wfpuYVjVhGN0X2TNvoVQ4GHB+cbnD1oL8g438RKhEwdOBkWHw/tSZ+rshNZ8pT19cwKMjXoIfIuhPdHCgN11eNn12jFSm57BKgLIjSLwLLRCejjPDAydSrc6iV7SyyEg1nqAthZXe/yVQcrKc5u8lMkE1JVzDQtdcL70+5PMOrWgH+o8NyrWheg21egB0Mwyt11/toIGlVVXMtE91rMFl1mvDGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 22:01:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 22:01:11 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ryan Newton <newton@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Fix scx_bpf_dsq_peek() with FIFO DSQs
Date: Sat, 25 Oct 2025 00:01:02 +0200
Message-ID: <20251024220102.1556384-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 7808e50e-5db6-4a27-c21c-08de1348d7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jfSIWtl4wa0lkqoA3M1kEW4tab+gnAtPz4DPpGIjjqajF6jU7IDlnVBQaKmG?=
 =?us-ascii?Q?F0pKtY5nu5LEI0X3hYU7a2LTHAFLNrd59D3kSIinsTqJwnC1Wk7Rh7k1ptJU?=
 =?us-ascii?Q?jlS7bl4WeKbZL+KFnkBT9+2s83jz3MGNX6/kCwMZhEoj5brWBgx7AD1dqnJj?=
 =?us-ascii?Q?fYYKGo03G/A96I6zfbcrff6xqIeABpdTfSxypuXFujiuvS9lNKbswGmH8OM5?=
 =?us-ascii?Q?/9FC4U1T1VBM4kKIMkpVw/2Ub3PZjphCofXxzMWccI0YB4NTdeXRgdm3/vwI?=
 =?us-ascii?Q?eSic910pIJQgyk4bz1TrycP8zwzrxdNLZoBkbB709qsbuPZaVoagd5/ZXuXS?=
 =?us-ascii?Q?Z0WFHOWtrIcx8D/P3/I1w2JswzudGORok/lI2fC/eMWzVs4k6ReV48osmUcX?=
 =?us-ascii?Q?KIV1Ry6blrfHXz80QL0leuFGifE0OKcIulEkKfhaM0hiR77yEknhbBaKplxe?=
 =?us-ascii?Q?43DES0bt1S77OCno3Op1sr7ziIy7gDyl8tOOPN0YNQY6iz8gHimrTU2yYRRe?=
 =?us-ascii?Q?+E+FkPYj/8sKq6WtmGwuhywwLW//Bv8gdh7U9XNT66yVtHp9vUkc+DfuxOdO?=
 =?us-ascii?Q?aeuooR8xyauqjXP2UqNUjsqHGeCdWde2A0bOTYNSKgbCLLkOp2dmKWemQFmB?=
 =?us-ascii?Q?tZHfFIMOzNQXddFS4J3r/xzwBPUfwlqnIgIa8TlgdcBlKgDsIYl5cG4f2kAq?=
 =?us-ascii?Q?e/W2y88qXRIx9tW59Ri4+nwIWSY1M8k+ZAo1cNQl3hfyTTA4+F5QSIJKGPKT?=
 =?us-ascii?Q?OFd9kPgF1kUH0r87dTcLsiPOWYSVYWaAMP+WXro8XM9oSbJtnOXq9pmyyEJp?=
 =?us-ascii?Q?sKtAeK3XgwDFuECJLAGgBTUOy0uUimJsJA5I1SKbo8De8IOMKvYRtRB8dAhy?=
 =?us-ascii?Q?PGAs1u2nHgW+lokJNRbx+zGrh/UXimAbzTHo8T+11Htgc+s979ojt8dhltFl?=
 =?us-ascii?Q?pQ6x4dDUtfsgmiR+0EtDwdzqNhzGk9R/3kwxx9gYE25hon1VLoEo4oZYEd+p?=
 =?us-ascii?Q?KgsSYs5ZGHswAFaJAa7PkYCBzR2jtDGk23o+CD/60c1FCFBhA/ECyAaIQJCB?=
 =?us-ascii?Q?clLtVflS0sJiv1R9Dn9fx2ekGbaXizBPodO0y/Ka4N2GkvvlOg3AAy/LW4Jv?=
 =?us-ascii?Q?RPpyePeXWlVypeDnSUcykkAb4vtL+9VNG2fvn2DAEQ1CmWIOc6fzCgRq3OxU?=
 =?us-ascii?Q?QH7k/wir6+Z6/g37HRsxjriuGhpexzdD60DXdPwCLwZpcK6cgLaYXeSNFebg?=
 =?us-ascii?Q?C2rLB/hAb2LvPT2itKtk0gAYEnqMzfnNoT8HYzMxEC50vQ0HhNSsfBzi/hbM?=
 =?us-ascii?Q?KklQVfU1pcHzdlhkShjUmPNyIqFuATZfrCPmlO71yp/liMNkqfSf44pACOzW?=
 =?us-ascii?Q?rEl1inr8vKiIK7RFfcv0cRZcESIWhqjA8Y5N+hjPLLfYV0bn5Dk+SS3l+PjB?=
 =?us-ascii?Q?enGjttylnEm/YjgoAE8xEoXk7X/SjFhD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?we3UBMUZK5n75LxvoTR4BNED0HN6sXcXYUtGEVFbyd2zakFbGs/Pnu9zeJHQ?=
 =?us-ascii?Q?vJrlNt7n9EJsruJBkgJ5XGv//CAEcBka1FrrjwV0nAgm1YAMLOmhHguLENpI?=
 =?us-ascii?Q?rS1pCQhuHb8b8JgAvDBqFF2oFj0ox9VVxiMsFuHlVrlP7dcousonBL2ZXOtN?=
 =?us-ascii?Q?jualRV9b4d2ZSrZvkXPpvA4eIbolzZhAW4nRQF+CWCVe0tWhp0b6osiuHsAB?=
 =?us-ascii?Q?fdpvarm3cqvwsw32Y4l2vFWgEpAClq3R9M6osz53x4z+LHb/hU7SdHD+OFzH?=
 =?us-ascii?Q?JrPrCChRbfTx4JM1MXiaPWq+0MSnKYWI66+jMZ1VnMeTRlMge60q+47zbbxb?=
 =?us-ascii?Q?Svx+V/hmum/uZrMQ1bpqAsqGmWk1nw9Sqyf8quOG9ox9CG9Eaa1A1l8mR8sn?=
 =?us-ascii?Q?mXWOA2QPB563tO8AIEl9TE/9TF+rMGp48N4nxvODI2fXgw6npoiluht/Zzmw?=
 =?us-ascii?Q?23W0UnBEFC6gfM+A7vpn4mf2G8FdbNou5Rk/kNtdTeGg0Kfpq1n+zEdoKNi9?=
 =?us-ascii?Q?QWDt2H3Apfq6iHUuhRhFmP59WVRZxFdIS4ewUPN7d7Mk++62RfwmHwBj6tGA?=
 =?us-ascii?Q?11Amqsp5Ej+ZujedQ7aR3l3ORfjD17IMVtldQykxCmayo8gzJcr4YvphwobD?=
 =?us-ascii?Q?AxtnO2D9dySekhJSwEHQnOUnQszoWXtmCXamWS2MryAD5krSSJBknKGKMQUp?=
 =?us-ascii?Q?zrabK6Ps9wpgooNXi+JDKFtSBfqU7bg/8Hcq+oIHmteTGvysX4V0kCXf2A/e?=
 =?us-ascii?Q?1NTpS/C3K3rOMkI4AIKBpmWJDraYx88tNRFTL3HazHeRvi9aiKTqk+8mr6dN?=
 =?us-ascii?Q?lxBpGbexyqJRcWraE13Figey4mci4X7kv42aR4Fs3dIAc3G9DfR1ZrYAxqxP?=
 =?us-ascii?Q?Dg22AfLKASQFTaX8XEHiD0WJ6UV+a89P/rgIFsDTEEPmkZcFJs3ILIVEtgwb?=
 =?us-ascii?Q?uVi59fhW0XyZdEVpaZl9m49/8/cxaP+bxx00jXOBcMxoQDOpuw5klkUmKPQs?=
 =?us-ascii?Q?NnmiNf9h0ocmGgfUL9/h0c4wU3YVLOSrdz6Giuvr93+nMkce7ALOadqhbQ5o?=
 =?us-ascii?Q?zMRE7r8wv+VZqwWY6gD7ksmsIOGqUEs+kxAh78r4zctLRgTy04r6jZ1ovd03?=
 =?us-ascii?Q?ZTM2WjXHeXax1vLRSFVVMH4VLKaTLJ440UJyrxZvC+iKKVDY1s66FyZCCrCq?=
 =?us-ascii?Q?VDimbYnWhbLTvhwt0OQw3/XpsYJHEK6KjKZXUzp2UPMqvqbjuV8QkUoOdpa4?=
 =?us-ascii?Q?QAHoLNkRNKg9Bfu087Wthg8ZKg20WG3RB6JGzV56wlZGtpf1LZfxw9alth7h?=
 =?us-ascii?Q?7teQ4zRYMgalMuRINwn3p8yj+ob7b8yrF9QcAx7MevE+CRo8wwJM6rhYUxd4?=
 =?us-ascii?Q?7cQ7asCvW8LdZdmc0Eq4rbu2BjsuV6CWNCzYhiXr1v8vDxJ2UIypbzCQyRhg?=
 =?us-ascii?Q?1uJvE7NUxNWtlXUR7TJNjC5YgJjOKVsHsRD+HWPvalUgqpxiXlEgQ7Jd4+Bl?=
 =?us-ascii?Q?UXeMAlQMNvnTBUNmFB9FKSCqvuSRYt+PJQtTO5WAhiN7HMnWaNGpomdTUkmk?=
 =?us-ascii?Q?UaMIUUNsxFCOtkjfqkAB3ScY8ORs+XUKjJk42XFE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7808e50e-5db6-4a27-c21c-08de1348d7eb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 22:01:11.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slFhoGI76c4xPKsk4ywRFfhf4iiA2VmAE6iv0aGfEUeNly9UVb2/+6DkJROyAa8M51hDIr4sm2t2+JkKPnPwog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

When removing a task from a FIFO DSQ, we must delete it from the list
before updating dsq->first_task, otherwise the following lookup will
just re-read the same task, leaving first_task pointing to removed
entry.

This issue only affects DSQs operating in FIFO mode, as priority DSQs
correctly update the rbtree before re-evaluating the new first task.

Remove the item from the list before refreshing the first task to
guarantee the correct behavior in FIFO DSQs.

Fixes: 44f5c8ec5b9ad ("sched_ext: Add lockless peek operation for DSQs")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bde49e47f1e4b..1cfe4b43d31b0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1044,15 +1044,15 @@ static void task_unlink_from_dsq(struct task_struct *p,
 		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
 
+	list_del_init(&p->scx.dsq_list.node);
+	dsq_mod_nr(dsq, -1);
+
 	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
 		struct task_struct *first_task;
 
 		first_task = nldsq_next_task(dsq, NULL, false);
 		rcu_assign_pointer(dsq->first_task, first_task);
 	}
-
-	list_del_init(&p->scx.dsq_list.node);
-	dsq_mod_nr(dsq, -1);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
-- 
2.51.1

