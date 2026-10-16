Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B63101A0
	for <sched-ext@lists.linux.dev>; Fri, 16 Oct 2026 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122196; cv=fail; b=WhmhBfFGs/YCkCuSVfKy61xSCV6pxR3g9ECmX+tHec/rB51/nY1v58KIbgkqUaKlhjeVdCMTdSp+CTB+tZaoDQn2bxFzTqVZKXscfxUL/WIkucwqqSzcmp1Zv73g6qaU1f8V/kyFVPE68EFjrQ4cTvjI8xwubugf6aIASOMw6Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122196; c=relaxed/simple;
	bh=aT+35x8X0UxVrzePYcw+8fExQOzhcqaqThbADlayPCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=up1mPv8tVCycwySg3DC/3g/FiE+q283/AgKJ/ETNqb+D666WqPBGdpvA/aVqZQ5pTP9RwcU0UA7cfommO5D/AmEUJMe/s0Dw1Rq3qiOaw9Z/NcBYVjiiVryAlTW4eE76AChnwpTSJOageOXIGijthc3i8ZjjRiyF0KyzqE8L6oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O6sVBcqZ; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O6sVBcqZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx6YgJL28fjCdRwnhqrwdxcnkznq6xJKj72u4U6ZH9I8E/803BcjvNIN2lhKFVpH0jEHD60ns+goUAce8SVVBeYjrnoLU4J9uctu9tHmXRrQbG87nszU6WeLP9YljRRPh0khlYY58lAwv5caZM7UJQxtAAy0LrNqMzqlYxj+3A5hpbf2R7eQSk7JDCZiTZ4ZnhjufABmpcPFqnc0tBkCC/q+ogLgYClt0mLfT1qquAdxr1cpuoUVoDVEw5Hq8ijcuBU9Ck8ZhVC7WYtrqZMl89O2eUPZEw49JYMFb2JDjw4oVlKy2cI6t0aQVT3fychtdBnJ48HTigYRRsOg0RokUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsE+79LQHvqbNhXjMpovejNxPVi0xgDd6PBSdwNAnMI=;
 b=J3K/pak1xMhYbliQQ/cYLQuUucZOhFoISDg4XT50jPs7pPUlfv54chX6JALBDsgjLPYe95PRH4DlzF5SHfmkT1xeibZPxTqciaLVQDFe5Lbepe7oINwXbLllUMxVxcdj1rO4pbqBdLnjr4Zi9PruCFsR84Cc2INL52kRoV8rR2rdu4KUa7UDdkBWVSkFgArZImgwwIlfTHHRNKfitVZnmseFgnMQkelvMTzSgHaoR1wgF8HHS3gSSh44UDGoVnzwDr15WEYLUsGhfGJrMC5Ia76g/mD3PEpZT74i+Qmo/9q2TpjdowFXQO38dzkyQVj2R2R2gi2UCQ9uivC7A0OfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsE+79LQHvqbNhXjMpovejNxPVi0xgDd6PBSdwNAnMI=;
 b=O6sVBcqZlPyYc3RDjgh0KqtnIAoZQbcauMZKxOpxcTjuXwtNh9nszXn1Gjepr4FaQHu+ETC83egHRuSCm/C4co1hVQEwT9ucfcPAHXVmSS4sxJUXE67Hj3BBYcbIVsehyBdtBj9cSBEmJjOsz8lEOvSzIYC5PRfIn1sOTgD2wkI=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by LV0PR12MB268673.namprd12.prod.outlook.com (2603:10b6:408:60f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:43:10 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::1) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 03:43:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 03:43:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 22:43:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 22:43:03 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 22:42:58 -0500
Message-ID: <52e9ca5e-0147-4450-928e-5b1c56e5d1a5@amd.com>
Date: Fri, 16 Oct 2026 09:12:57 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC] sched_ext: Support RT task within sched_ext
To: Tengfei Fan <tengfei.fan@oss.qualcomm.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>, Cheng-Yang Chou
	<yphbchou0911@gmail.com>, "Emil Tsalapatis" <etsal@meta.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
CC: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<trilok.soni@oss.qualcomm.com>, <aiqun.yu@oss.qualcomm.com>,
	<abhijeet.dharmapurikar@oss.qualcomm.com>
References: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|LV0PR12MB268673:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c5143a-5904-4a9c-2e1f-08df2b37993c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	wAXm0kLkcwkweWCS+PmdLWRDNBKg6NTfKk68Mnf/rCzEHWEHj7Zgs0EFZ30N7OM8WAkqLt6KKBGiBAwUmpLklabf8JO53VG4jGqYVMd7S/JcvanuraaDbZzqEp7p3vybKSAj+/gBKz4LI3wh2JefewlEXJ2sP7YGH/JUuXWXKybqlLhZeqh1y3dQMB/X+F6XKOo5SzJlUWuklbcByIZYuUnabkRM0eJUEuWx/OTc+Xm2Gt2RUaBIXXmgoesTq7ayJpCNJgXJJk1VSd9EflD91oL77ctnyGOVMjFNGoufqgUwpvAqkol303f3mnyBGwGYI+4NQsxYGeL/6ti000DSIxpZr+gJ/r88CAq/4orsOyAs/9NF40of/Vs8ujB1uZOMSfXG8SAg6P+aLCR6W6t8xeOhPgzrk1ZXyoq4OpVCVhZhx+6ARTvMvgUa1+g7Phx59D5RSZS+6OpJ44uAaFxQub+5e5nukIPqDpg6QoSbU4fcQetUbNQeSGWy1SOu0JyU4KxI6Cct0qk7+Op3NYAPrjPHlQl/pZRvqT0O+JYYE710OiH5T+3cvZVf7DgmnPgir4kNdPNMI8TLyHZQ5xZhgY60U+MjAk2CpvKW2hoBh3Zm7JMUXemM9Vp5Bd3aI72WH/8c16EHS9/V2Zkqx2R4V24V4RvJUAewbfGPUrc8WWXK4bDdA8yON+6X95CVWmNjHBXYgoVoXbrZYhk9W8zFxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aeLbcOVWvKW4456hFKUiEyPAdM0aN+LjIkI6789XlYktnqQkpyVQ9ia4K07ZfugLzTycSD/woE6qWx/1KVbWnJRwLFx54b5BI+Mb478jGlyd74B7QZzgZ3T5T0OgPMPMG9XWOclK2Xzrj77wadGRGiiUtY0QH4oAEREv36NTUR1C5jE3grCSe8uuKhKV5qEF5YeqUanLw8xhr0YDurHhCrlC2a/4eU4DFkLvjY7LXDEIbOb0+e13+sXbHJnQhWmwGWg4CNr70gge5x7Q0/k9Y2rilfrjbIu5GsLoG1XTw7dWYU25QadNtwLkUcY3RIO0E9nOoAY0iR1RmyyZd416dIiXPjZFWCFPPT++zRGgyvSyUxPt2TlGaEn+FDUIdR4XU9EJdbcdd2uP1O3Airp+7y6SlK0DZVcQPKDoa3v38RToiOx+aHrgDjQSLfkQnKAr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 03:43:10.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c5143a-5904-4a9c-2e1f-08df2b37993c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB268673

Hello Tengfei,

On 10/15/2026 6:17 PM, Tengfei Fan wrote:
> Sorry for resending this as plain text. The previous email was rejected
> by the sched-ext mailing list because it contained HTML.
> 
> Hi all,
> 
> We would like to discuss how RT tasks can best coordinate with sched_ext
> for cpu placement, cpu balance, and sched load reporting to schedutil
> governor. This RFC is intended to continue the discussion in email list
> from last LPC[1].
> 
> One of the options we would like to explore is allowing sched_ext to
> schedule some explicitly selected SCHED_FIFO/SCHED_RR tasks.
> 
> We received feedback from Changwoo that the issue is valid, and in
> LAVD sched-ext, they tried affining RT tasks to a limited set of CPUs as a
> workaround for the scheduler placement, but we do know that it is not a
> flexible enough solution.
> 
> We also had a discussion with Andrea Righi, that he acknowledged that
> he understands the scenario and current problem, and he would suggest
> not changing the current core scheduler, but instead using bpf ops to
> bring the RT tasks under the sched-ext control. We are trying to explore
> more on this path, and welcome to suggest or comment here.

This doing everything in sched-ext and eBPF attitude needs to change.
Sure it is good and all to ship quickly but you'll be left with a
sub optimal configuration forever and will always be workign around
that.

If you have some magic sauce to detect which scx threads are high
priority and matters for the KPI, why not just send a signal to a
userspace to demote the task temporarily to SCHED_OTHER and then
later move it back to RT when the situation allows?

You can always use a BPF Map to communicate the pids that need
promotion / demotion right? What is stopping you from doing this?
I thought that was the feedback from folks at LPC.

And if that is not possible, maybe you can convince the folks who
originally used the RT (most likely to get around some old issue)
that the custom scheduler is good enough to not hamper performance
and everything can now be a -20 nice task in sched-ext for
scheduler to know that it must be prioritized.

> LPC topic:
> [1] https://lpc.events/event/20/contributions/2561/
> 
> Slides:
> [2]
> https://lpc.events/event/20/contributions/2561/attachments/2025/4612/2026_LPC_Support_RT_tasks_within_sched-ext_.pdf
> 
> 
> Here is a text-based description of the main idea presented at LPC.
> If you already have that context, you can skip the section below.
> 
> 
> Background
> ----------
> 
> In most of the Android gaming, video playback, and livestreaming test
> scenarios, non-RT threads work together with RT threads to construct and
> consume a frame. Finishing the frame on time without frame jank is a
> key performance KPI. A balanced workload across CPUs with fewer
> unnecessary CPU frequency bumps is another key power KPI.
> 
> More specifically, taking a gaming scenario for example, UnityMain and
> UnityGfxDeviceW are the critical normal threads that have significantly
> higher load and usually run on the most performance-efficient cpus in
> gold/prime cluster. Other than those high load tasks, the other normal
> tasks mostly have similar workloads.
> 
> It has RT threads like the display HAL tasks, SurfaceFlinger, and the
> GPU related tasks. Those RT tasks have workloads comparable to those
> of other non-high-load normal tasks.
> 
> In our tests, sched_ext runs in switch-all mode, with
> SCX_OPS_SWITCH_PARTIAL unset. It schedules the non-RT tasks
> covered by this mode. SCHED_FIFO/SCHED_RR tasks still run in
> the native RT class.
> 
> Below, we call these non-RT tasks "SCX tasks".
> SCHED_DEADLINE tasks are not part of this proposal.
> 
> 
> Observed problems
> -----------------
> 
> cpu placement:
> 
> In our tests, RT tasks can run on CPUs used by important SCX tasks.
> This can cause the SCX tasks to be preempted, waiting longer to run,
> or lose cache locality.
> 
> Here is a diagram for easier understanding:
> 
>         RT task + important SCX task
>                     |
>                     v
>                  same CPU
>                     |
>                     v
>               CPU contention
>                     |
>         +-----------+-----------+
>         |           |           |
>    preemption   longer wait   cache impact
>         \           |           /
>          \          |          /
>           +---------+---------+
>                     |
>                     v
>        SCX work may finish later
> 
> RT tasks have higher priority, so the preemption itself is
> expected. However, from the whole scenario perspective, better CPU
> placement could reduce this interference when another suitable CPU
> is available.

Seems like a generic problem, no?

> Load balance:
> 
> RT tasks can be scheduled in the same cluster of non-high load scx
> tasks. This can also be a preferred placement decision. While the
> load balance within the cluster is also hard to maintain.
> 
> We sometimes see RT and SCX tasks on the same CPU while other CPUs
> can become idle very shortly. We need to check whether those newly
> idle CPUs can pull and run the scx tasks. While if RT tasks are also
> in the same scx scheduler, it is easier to make decisions from a load
> balance perspective.

This is also a problem with fair but fair scheduler seems to have
figured it out well - we have newidle balance to pull tasks and as
far as I know, SCX has ops.cpu_release() callaback that can do a
re-enqueue to a different.

Why is this not enough to move this high priority task away and
preempt something else on another CPU?

> sched util calculation:
> 
> We also see a difference in load tracking. Our implementation
> uses a frame-window model for SCX tasks, while the RT load signal
> in our setup uses PELT.
> 
> The SCX task load is flat and steady, while the RT task load
> sometimes spikes. An unnecessary CPU frequency bump up can be triggered
> by RT task load spikes.

Wasn't UCLAMP specifically designed to avoid those bumps if they
are unnecessary? RT can make sure you preempt first and UCLAMP
can ensure you don't boost frequency unnecessarily.

I think sched-util will request the highest frequency when an RT
task is running but that seems like a more generic problem to
solve.

> Why CPU affinity is not enough
> ------------------------------
> 
> We could use CPU affinity to keep RT and important SCX tasks
> on different CPUs. This could reduce the time they compete
> for the same CPU.
> 
> However, CPU affinity is fixed and strictly limits how tasks can move
> between CPUs. If the number of background tasks increases, CPUs perferred
> for critical SCX tasks may still have spare capacity. With fixed CPU
> affinity, non-critical SCX tasks cannot use those CPUs even when doing
> so would help balance the system load.
> 
> Ideally, the scheduler should be able to choose CPUs dynamically as
> the load changes, while still keeping tasks within their allowed CPU
> masks.
> 
> CPU affinity may still help, but it does not provide the
> flexibility we want here.

If you can consider cpu affinities an option, you can also consider
demoting them to SCHED_OTHER as an option no?

> Possible options
> ----------------
> 
> One option is to let sched_ext schedule some explicitly selected RT
> threads together with SCX tasks.

Who gets to decide this selection of threads?

> This could let one scheduler choose CPUs for both selected RT
> threads and SCX tasks.
> 
> For example, if other cpu is idle, or running a low priority scx task,
> or running a low load scx task, an RT task could use that CPU instead
> of a CPU running an important high load SCX task. This could reduce CPU
> contention for the frame important KPI and help balance RT and SCX tasks
> across CPUs.
> 
> Such placement should remain a preference rather than a fixed
> rule. It must respect the RT task's priority, timing needs, and
> allowed CPU mask. The other CPU must also have enough capacity.

I fail to see how "RT task's priority" is respected if you are
suggesting a SCHED_OTHER task can be prioritized over it.

Also how do you infer a timing needs of RT? From a traditional
theory perspective, if the task is of a higher priority, it
always preempts.

> It could also allow RT and SCX tasks to use the same utilization
> model. We would like to study whether this can make the load
> signal more stable and reduce late CPU frequency changes.
> 
> Another option is to keep all RT tasks in the native RT
> class, but provide enough information for the two schedulers
> to better coordinate CPU placement. However, this would also require
> placement and load synchronization between the RT scheduling class
> and the sched_ext class.

This can be a generic optimization too right? If RT task has a
choice to be scheduled on a bunch of CPU, maybe there are
heuristics that can be used using nice value, CPU load to better
place them.

> After the LPC discussion, we'd like to explore option 1 and use
> BPF-only hooks to achieve current needed RT tasks within scx class.

I don't like it one bit but what exactly are you planning to do
with this BPF op?

Direct RT task placement to another CPU? How is the RT scheduler
supposed to verify if that alternate placement doesn't violate the
RT guarantees? (And please don't say you'll use the ext's dispatch
path to do this) 
> One option is to have all RT tasks with a priority lower than the SCX
>  helper thread go into sched_ext.
> 
> Migration thread, sched-ext enable/disable threads and IRQ threads need
> to remain outside sched_ext. With this option, we will need to verify
> more common scenarios. We can explore the first option first.
> 
> 
> Open questions
> --------------
> 
> * Can sched deadline can used to optimize those scenarios?
> 
>   It is possible, of course, so we put it here, welcome to share the
>   possible configurations of which tasks goes to deadline. However, here
>   we discuss only the topic of plugging RT tasks into and out of
>   sched_ext for these scenarios. For different scenarios optimization,
>   there is of course no single solution. It still can have different
>   scheduler optimization to make a specific tasks a different sched-class.
> 
> * Other ideas?

You can always demote these tasks from the userspace bit of
sched-ext and there is no explanation in this entire write-up
that says why that is bad / insufficient.
> We would appreciate feedback on the problem, the possible
> directions, and what we should try first.
-- 
Thanks and Regards,
Prateek

