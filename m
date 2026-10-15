Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2E21A447
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086448; cv=fail; b=YBGY1MF36TmGG7yb9pgnGOZsOSeuYXG8RK41OnlOurE4nMnA8WVxmRXZq28xsYRD4pwc53by1dTWB8gCo1lRYBsI4bUAsQKi52zl8miTOvtbmcbYEHY74KHic1QbErwMtSP2ibqf2eDlcFQjRAmvrY7M3iLeG5fRHDkd2me4Nf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086448; c=relaxed/simple;
	bh=VcyHddYBHqJ6e/TZAmrv6oBM5qISJ8RO9JgbvEjqMjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sUhAVWD4n+x3s8ia+hR2Zn+0obFMTgo2eJfcWfiAUfX1epQ4uufNyBgMtMd84xMqYjmsPQ4wNRim26wSedml8dzYlAj++aborfLwyUxyxW/9nFdS7OTxF/6bWDDme4RM6JLHhO9muehwlxFiZjF5FnunYCH1NbU9r0RJ9hWddLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AiLo8NRt; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AiLo8NRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7YsjG+w7o7mt12fNt3B7nx1R3N7YsUzUZh0df81FD0lUbpZolNwsYo12OBE0QriBjnqrMITWMC/RzPPXiiSTVQTekEn/KFQ1eVJV6wf8kcAsIsLJ6/qHye3V+1ysHcDWbr7cXv4M1QUedf1WVmfod2Uk/BLUigl+7dU5Ta7tmUQXkMLNOWKPX2I82ryc6mtnhxAMMcGxczyC+yEBCtYvgYL2C2a5t+SK4h92/H809wOGPs8bIjoQX9fErRWAdLLSL50LHPIzD4scYrzSBccZ1I97C0E9Z56SYVryHRuSWPBHkIgGmU8glrM9AM2ijp1nMRVcWf1CX/yVwiPDWYQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKAOu1UHpHBX1M3TtTidxJLm8+Z29fkGSm4YqBUIXJ8=;
 b=Zo5DYHtAZ9p3I8u4QT/UXsBXNpkV+4iOhWhDZVeYrgTDG57ooEFegdUcBAy3sgwSksNwVrdgo52J6jgm6PIwcITLRxCPqylOKdXsGhpAuM62RD3jNYwQKgXLTl6GaXGL385a8tch1Mcdf7Z+g4/ckf4lQWqC+sI9RA+v7LQ138mEGBR50oR/tXv04iLqTnW8jA8xKEzgGSJcRnWixwjoIwpZVUt4ubtuqr5X75mqImOu2KEAE2xMrqoNzK35n+5O4T6FEJbF0MG4uq+3AaWRJl74dFTym3drDfxMLHNWZ7mQ2BGhGT07uAlXlTLGRSaOJa0E11t+sepsNVKm0YaUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKAOu1UHpHBX1M3TtTidxJLm8+Z29fkGSm4YqBUIXJ8=;
 b=AiLo8NRtJb2qfoak7m4WCMEKw1+bz0/PH+elaR4kVV5yqBqjxlgyyepbFPYsCEt4pkqRCFfqNqCd0ZyzaIp7STAyvZiwRhw+BQJpj6H23PXk8/3jDSKK6nx4YpUxDd99ni+zTwo1lgidIBSye4GAsIeU5AFwcTDkIxxJ1S3QbU1091+c10MCg3FehOk0Rp3MJsm83dPG8uiohHF4uZOgq5zIjoafxf8ALU5Xqzb2gVDb5/wfp7rPCrl76RJDU7ieDLoSHXbdwyP7U4YFt/WpJpNsE9459SpaERSFEkZ8ZPauSuGIAzFjjBt3L/flsUUPa9y/33u9G4sIjZb/K2KUeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:47:15 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:47:15 +0000
Date: Thu, 15 Oct 2026 19:47:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free of
 a local reenq node left on an inactive cpu
Message-ID: <atERmiNFIgyR2ykL@gpd4>
References: <20261015171628.714661316-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015171628.714661316-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d526ec-206d-4e8a-5714-08df2ae459a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|10067099003|261009223027099003|11063799006|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	m4ugHU1NPzN7briggMB+SAud1JvR1gFx/+VQbUlZ+EYWFL4s2I+GWWt+yh+sQ1yl706YNNc2HTbhh2y9nVBzzxBiUE1IYphJ6oDMaDs4nwxySuiW8d61Mi32+zaE4VJ4BPt39JzQ6xLMfTkNT/13Fjtt9S3G0pk93srxW/RZrSXT9Nl1J26lN4mhut3BrwpixNB3e/mInVugSK4tnndFFjyX+DTfL9TCdMyNyLNNnsM0+ZRHzTDDYCjQHd5+OLhDhPEWWMEP3+zv+gcTKoK+ORnr5+aoINf2c3uy2GChh7NF2+2OxUSUEotudoRvDzA4fDG9Xm66BoSvO35dGhLr2Tb3MB0SmSY6nczdET1WUiou7Rhyksntk3Vc16Zx/i+jhtYmeEWjaV0/Frstsx73D3WaP++ImGITolunsVc3vRxi07yoI+ZcHYKIyXPC2dAFv2Hl0RcYXIh3eDk+cncGGRJ3N9RM7gKnvgJsgzUeglcstvMIoaeDU/aqDo7qh2Zcf5s6Xx/RV53TMez4PYyCFjWU7eTO5LE0Ks724/3lACror+DRFp81V7VFe5KdFZth0U6Q8rZVPo16HGw7kPrGk2HIe2Hn5JpFJ47Pli8gHLiZavYhyg/YX4oxNTpNMOs7Qv62HDEIjcG4PSLrwtT+jdAGiMkOo1P33ENZy12AVXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMF77+7GocqBlYV+cg/TcZgdKi2Kv5AWFtTHkTXkiFtLPL69O8ZFhKa+IPcS?=
 =?us-ascii?Q?wE4yFAwjVnFXdVi5XgEGxYU6I3luUZExa46ImTi5qi398S9wyKkxn7Lqzdoe?=
 =?us-ascii?Q?FGzsd6nZGjdJkWUahcgqyWtmfY23oDlPBrjHsM8PxjC27od2Drc0M3Qh80M0?=
 =?us-ascii?Q?YbcqIT22ZTL3CMC+1fGvC7tM6V1saxqwrNDBQXrRXC+XF4gpDTJqC3XNdFBP?=
 =?us-ascii?Q?6mLWBmnoTultc6+5g082KOP7R8I+jZnLR7Bo8ZJbqTp2a3HSuwopQL5VnCuw?=
 =?us-ascii?Q?0Eibd4+Q0kSma9yL8OGb3LLn9kYesJcJ6gncq4mgrPDKrOXy7hiUzQ9X7tC1?=
 =?us-ascii?Q?hQ7JQ9bPA/4dflpRtThOA0VjYdHJfG1ASRx+/OhMSfNN/Sgq+f8pjnzCZNKP?=
 =?us-ascii?Q?ULK93kkgjIC7bWWqxIRosjNIuwwSW0Rw/TtruNDTglLoWQqbYycnq36jAUcv?=
 =?us-ascii?Q?KapCUwDiKqGs0PaE81h/5fs6HDqonzSV5lmLWpdlNhJvmnbKQ3gAX1Dv5JRq?=
 =?us-ascii?Q?1c8UFoAKutNUl86FN3pws0T/N0AfkpQ01F1a9/1UyuZZOY9/KnBAnMv0IlqZ?=
 =?us-ascii?Q?Nfy3wp/EUlFbxAbR1PTMFbkaaInXcExxH0Fcl56DN+6t0B1hS0s6Zz26r6g/?=
 =?us-ascii?Q?dNQ55hs6lPWznb7v/LtPX2ba4VticZx1/ECDR31y7BbjXjqKYyNRQ0YkDY1q?=
 =?us-ascii?Q?QeYc5Sjz5r3khUfSKukdnqlYwvZ+BUdatDiow5zIbH696HjuLXVRv1lP0vt0?=
 =?us-ascii?Q?vtvZfjp/Nx4L2B4RXVyEtJ3nWc38mkpUUwtOnr7mMbakb2cF6aLwmWdrgddE?=
 =?us-ascii?Q?OfVBcwi58jipYugvBMiyL9CxO7XKHeFSJOitna9TbRAGb2w4ZCfc7TB0sajZ?=
 =?us-ascii?Q?Tt0NwkkfYZxrh36rHm16Q4cfUbJe++rcSONOizaO854BnFVWiGjb54/ISq+a?=
 =?us-ascii?Q?c4Btnwfe4jh1WaFFOEjAgs4eSnf4Z3VBlbJ3hlNtp0g58lrsCafa1AmM84pL?=
 =?us-ascii?Q?9RL/0WkixhDF7/g/oTHXpwu38cSPlxgJswVMbSC92oOOS1PMBAMR0LlfGHtB?=
 =?us-ascii?Q?G2tQbQZlh2m2T8Nyl9s8AukWArzPe1ET8i6mG30MudqZY8k7JHY78I9iENo1?=
 =?us-ascii?Q?IpebWrvM7B4r01ko+7rKAysm0tzis/40oDKBZHldE5xYfLEFcOHuW3MLuJFO?=
 =?us-ascii?Q?uUXvto3uYQCAHn1J0KyFce8UCRlq4bG9IKck/Xg7FbBBsq0r+7V5Odm+2UKm?=
 =?us-ascii?Q?itUmAePP+nXMV0Cy9Iwc9izNMMl0LVnpR1vjksHgv5Sh7HEa2yUHdDT9h0JC?=
 =?us-ascii?Q?ZixbJmMC+QrsqHa5UGo9QiLa/45bUxY6yqWTpvBMOvWZobPlwcKS4n/tOOe0?=
 =?us-ascii?Q?jq8EOtvqGizAPzWDirmOVh1qXeFta3swMH3DL/DJQGBJVDqniQuOgHklvDwR?=
 =?us-ascii?Q?bPBGKaM5WaAuzdOvTg1t3RvLJtCQyAwJf86F/bzjV8Ufg2DMHYhBCX6q6ADT?=
 =?us-ascii?Q?w5QjpNY828knFcLsO6bWpYIr9z/Z7YMrTYt5YVws9wKdQROvZvD6UaF3qfjt?=
 =?us-ascii?Q?yjR3DRzc0skj9sqVROaar87y/r0RSNjE2vBHbilzZHvCOogbPTuX/h0B/YH2?=
 =?us-ascii?Q?XNApymq7qhvqThRk8ivD55VVY9otM0kZLQZ1CNLU/nmLo5Sw9Gr3TFwMqZod?=
 =?us-ascii?Q?AXvf39h/j6HkVJOM8pAR7E1xQSnKmK4f1gTyCAyTCB34I4jY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d526ec-206d-4e8a-5714-08df2ae459a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:47:15.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZeLcHPwzojazpEP5/CAHUx9m721COuO9yofrS0+TQViYhyDPabdgUHThYIgwhU7VuRaS5VZ+TxU1JCQ2MeKvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214

Hi Tejun,

On Thu, Oct 15, 2026 at 07:18:05AM -1000, Tejun Heo wrote:
> A local DSQ reenq is queued on the rq through a per-sched node and run from
> deferred work. When the reenq is requested from dispatch, the work is a
> balance callback queued once dispatch is done. A cpu going down installs
> balance push early in its teardown, and queue_balance_callback() refuses new
> callbacks from then on. ops.dispatch() keeps running on that cpu until the
> rq goes offline after an RCU grace period, so a reenq it requests in that
> window may never run. The IMMED handling in dispatch_one() requests one the
> same way.
> 
> A reenq requested from elsewhere for a cpu that is already offline goes
> through irq_work_queue_on(), which warns, and its work doesn't run until the
> cpu comes back.
> 
> Either way the node stays on the rq's list. When the scheduler is freed,
> scx_sched_free_rcu_work() warns and frees the pcpu with the node still
> linked, and the list is walked again once the cpu comes back.
> 
> An inactive cpu's local DSQ holds only tasks that are bound to it or are
> being moved off, so the reenq is pointless. Ignore reenqs of an inactive
> cpu's local DSQ.
> 
> The test is lockless. The hotplug thread of a cpu going down runs on that
> cpu, and it marks the cpu inactive before it installs balance push. A
> dispatch on the cpu runs to completion before that thread can run there, so
> a dispatch that saw the cpu active has queued its callback by then. Requests
> from outside dispatch run from the wakeup path or through irq_work, which
> balance push doesn't affect. The grace period after the cpu goes inactive
> waits for any requester that saw it active, so that irq_work is queued while
> the cpu is online.
> 
> Fixes: 238eba8c210d ("sched_ext: Use schedule_deferred_locked() in schedule_dsq_reenq()")
> Fixes: 76edc2761ab8 ("sched_ext: Use irq_work_queue_on() in schedule_deferred()")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good and validated in virtme-ng with the following AI-generated
reproducer.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Tested-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index af919a56a4f4f..f0af0c3b32076 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -184,6 +184,7 @@ auto-test-targets :=			\
 	allowed_cpus			\
 	peek_dsq			\
 	prog_run			\
+	reenq_offline			\
 	reload_loop			\
 	select_cpu_dfl			\
 	select_cpu_dfl_nodispatch	\
diff --git a/tools/testing/selftests/sched_ext/reenq_offline.bpf.c b/tools/testing/selftests/sched_ext/reenq_offline.bpf.c
new file mode 100644
index 0000000000000..a3fff2c0e0de6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/reenq_offline.bpf.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+volatile bool trigger_reenq;
+volatile u64 reenq_attempts;
+
+void BPF_STRUCT_OPS(reenq_offline_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (trigger_reenq) {
+		scx_bpf_dsq_reenq(SCX_DSQ_LOCAL_ON | 1, 0);
+		__sync_fetch_and_add(&reenq_attempts, 1);
+	}
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS_SLEEPABLE(reenq_offline_cpu_offline, s32 cpu)
+{}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops reenq_offline_ops = {
+	.enqueue = (void *)reenq_offline_enqueue,
+	.cpu_offline = (void *)reenq_offline_cpu_offline,
+	.name = "reenq_offline",
+};
diff --git a/tools/testing/selftests/sched_ext/reenq_offline.c b/tools/testing/selftests/sched_ext/reenq_offline.c
new file mode 100644
index 0000000000000..739d5b4e22cf7
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/reenq_offline.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sched.h>
+#include <unistd.h>
+
+#include "reenq_offline.bpf.skel.h"
+#include "scx_test.h"
+#include "util.h"
+
+#define CPU1_ONLINE "/sys/devices/system/cpu/cpu1/online"
+
+static enum scx_test_status run(void *ctx)
+{
+	struct reenq_offline *skel = NULL;
+	struct bpf_link *link = NULL;
+	cpu_set_t mask, original_mask;
+	enum scx_test_status status = SCX_TEST_FAIL;
+	int i;
+
+	if (access(CPU1_ONLINE, W_OK) || file_read_long(CPU1_ONLINE) != 1)
+		return SCX_TEST_SKIP;
+
+	if (sched_getaffinity(0, sizeof(original_mask), &original_mask))
+		return SCX_TEST_SKIP;
+
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask))
+		return SCX_TEST_SKIP;
+
+	skel = reenq_offline__open();
+	if (!skel)
+		goto out;
+	SCX_ENUM_INIT(skel);
+	if (reenq_offline__load(skel))
+		goto out;
+
+	link = bpf_map__attach_struct_ops(skel->maps.reenq_offline_ops);
+	if (!link)
+		goto out;
+
+	if (file_write_long(CPU1_ONLINE, 0))
+		goto out;
+
+	skel->bss->trigger_reenq = true;
+	for (i = 0; i < 1000 && !skel->bss->reenq_attempts; i++)
+		usleep(1000);
+	skel->bss->trigger_reenq = false;
+
+	if (!skel->bss->reenq_attempts) {
+		SCX_ERR("No enqueue reached the offline CPU reenqueue request");
+		goto out;
+	}
+
+	status = SCX_TEST_PASS;
+out:
+	/* Detach while CPU 1 is offline to expose a stranded reenq node. */
+	bpf_link__destroy(link);
+	if (link)
+		sleep(1);
+	if (file_read_long(CPU1_ONLINE) == 0 &&
+	    file_write_long(CPU1_ONLINE, 1))
+		status = SCX_TEST_FAIL;
+	if (sched_setaffinity(0, sizeof(original_mask), &original_mask))
+		status = SCX_TEST_FAIL;
+	reenq_offline__destroy(skel);
+	return status;
+}
+
+struct scx_test reenq_offline = {
+	.name = "reenq_offline",
+	.description = "Reenqueue an offline CPU local DSQ and detach",
+	.run = run,
+};
+REGISTER_SCX_TEST(&reenq_offline)
