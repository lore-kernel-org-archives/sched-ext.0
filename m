Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566526059D
	for <sched-ext@lists.linux.dev>; Sun,  1 Feb 2026 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986049; cv=none; b=YecwrJWrRXicKde9ILi3BUqwOKWWkcTebFYQCxC0oqrOO8DVK1c11YcBWSzB3H5gCI/esl8rU+1GBgitfehtyJPIitWupyYadLRba9WkkWt8lxMJmMIYeGfn9xude89XV5zgB0BUYS0qCi/z4wYNFUVsqlCnknF8EG7DhTI1528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986049; c=relaxed/simple;
	bh=cJBSNyOA84AUffGCQxajbcBZHLEtYq5gQaYCVDWF1bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCpHw5TjyEiljoQyhUB+YzGg5JUmp8B7yV96bGpoM35zlD5Q+FFmcfWAva651ZDaG54eY22nsu2gSM9DbPsT8LuGANRATglwMXDkQZF2AtnODiVaXRb7wfUgw7LxNAzAqXsE+PyhsgL8Lemd1tc84/2jgfzbn9zfOF5Hap9nSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA77339;
	Sun,  1 Feb 2026 14:47:19 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BF613F740;
	Sun,  1 Feb 2026 14:47:24 -0800 (PST)
Message-ID: <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com>
Date: Sun, 1 Feb 2026 22:47:22 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260201091318.178710-2-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/26 09:08, Andrea Righi wrote:
> Currently, ops.dequeue() is only invoked when the sched_ext core knows
> that a task resides in BPF-managed data structures, which causes it to
> miss scheduling property change events. In addition, ops.dequeue()
> callbacks are completely skipped when tasks are dispatched to non-local
> DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
> track task state.
> 
> Fix this by guaranteeing that each task entering the BPF scheduler's
> custody triggers exactly one ops.dequeue() call when it leaves that
> custody, whether the exit is due to a dispatch (regular or via a core
> scheduling pick) or to a scheduling property change (e.g.
> sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> balancing, etc.).
> 
> BPF scheduler custody concept: a task is considered to be in "BPF
> scheduler's custody" when it has been queued in BPF-managed data
> structures and the BPF scheduler is responsible for its lifecycle.
> Custody ends when the task is dispatched to a local DSQ, selected by
> core scheduling, or removed due to a property change.
> 
> Tasks directly dispatched to local DSQs (via %SCX_DSQ_LOCAL or
> %SCX_DSQ_LOCAL_ON) bypass the BPF scheduler entirely and are not in its
> custody. As a result, ops.dequeue() is not invoked for these tasks.
> 
> To identify dequeues triggered by scheduling property changes, introduce
> the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> the dequeue was caused by a scheduling property change.
> 
> New ops.dequeue() semantics:
>  - ops.dequeue() is invoked exactly once when the task leaves the BPF
>    scheduler's custody, in one of the following cases:
>    a) regular dispatch: task was dispatched to a non-local DSQ (global
>       or user DSQ), ops.dequeue() called without any special flags set
>    b) core scheduling dispatch: core-sched picks task before dispatch,
>       dequeue called with %SCX_DEQ_CORE_SCHED_EXEC flag set
>    c) property change: task properties modified before dispatch,
>       dequeue called with %SCX_DEQ_SCHED_CHANGE flag set
> 
> This allows BPF schedulers to:
>  - reliably track task ownership and lifecycle,
>  - maintain accurate accounting of managed tasks,
>  - update internal state when tasks change properties.
> 

So I have finally gotten around updating scx_storm to the new semantics,
see:
https://github.com/cloehle/scx/tree/cloehle/scx-storm-qmap-insert-local-dequeue-semantics

I don't think the new ops.dequeue() are enough to make inserts to local-on
from anywhere safe, because it's still racing with dequeue from another CPU?

Furthermore I can reproduce the following with this patch applied quite easily
with something like

hackbench -l 1000 & timeout 10 ./build/scheds/c/scx_storm

[   44.356878] sched_ext: BPF scheduler "simple" enabled
[   59.315370] sched_ext: BPF scheduler "simple" disabled (unregistered from user space)
[   85.366747] sched_ext: BPF scheduler "storm" enabled
[   85.371324] ------------[ cut here ]------------
[   85.373370] WARNING: kernel/sched/sched.h:1571 at update_locked_rq+0x64/0x6c, CPU#5: gmain/1111
[   85.373392] Modules linked in: qrtr
[   85.380088] ------------[ cut here ]------------
[   85.380719] ------------[ cut here ]------------
[   85.380722] WARNING: kernel/sched/sched.h:1571 at update_locked_rq+0x64/0x6c, CPU#10: kworker/u48:1/82
[   85.380728] Modules linked in: qrtr 8021q garp mrp stp llc binfmt_misc sm3_ce r8169 cdns3_pci_wrap nf_tables nfnetlink fuse dm_mod ipv6
[   85.380745] CPU: 10 UID: 0 PID: 82 Comm: kworker/u48:1 Tainted: G S                  6.19.0-rc7-cix-build+ #256 PREEMPT 
[   85.380749] Tainted: [S]=CPU_OUT_OF_SPEC
[   85.380750] Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Orion O6, BIOS 1.1.0-1 2025-12-25T02:55:53+00:00
[   85.380754] Workqueue:  0x0 (events_unbound)
[   85.380760] Sched_ext: storm (enabled+all), task: runnable_at=+0ms
[   85.380762] pstate: 634000c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   85.380764] pc : update_locked_rq+0x64/0x6c
[   85.380767] lr : update_locked_rq+0x60/0x6c
[   85.380769] sp : ffff8000803a3bd0
[   85.380770] x29: ffff8000803a3bd0 x28: fffffdffbf622dc0 x27: ffff0000911e5040
[   85.380773] x26: 0000000000000000 x25: ffffd204426cad80 x24: ffffd20442ba5bb8
[   85.380776] x23: c00000000000000a x22: 0000000000000000 x21: ffffd20442ba4830
[   85.380778] x20: ffff00009af0b000 x19: ffff0001fef2ed80 x18: 0000000000000000
[   85.380781] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaadd996940
[   85.380783] x14: 0000000000000000 x13: 00000000000a0000 x12: 0000000000000000
[   85.380786] x11: 0000000000000040 x10: ffffd204402e7ca0 x9 : ffffd2044324b000
[   85.380788] x8 : ffff0000810e0000 x7 : 0000d00202cc2dc0 x6 : 0000000000000050
[   85.380790] x5 : ffffd204426b5648 x4 : fffffdffbf622dc0 x3 : ffff0000810e0000
[   85.380793] x2 : 0000000000000002 x1 : ffff2dfdbc960000 x0 : 0000000000000000
[   85.380795] Call trace:
[   85.380796]  update_locked_rq+0x64/0x6c (P)
[   85.380799]  flush_dispatch_buf+0x2a8/0x2dc
[   85.380801]  pick_task_scx+0x2b0/0x6d4
[   85.380804]  __schedule+0x62c/0x1060
[   85.380811]  schedule+0x48/0x15c
[   85.380813]  worker_thread+0xdc/0x358
[   85.380824]  kthread+0x134/0x1fc
[   85.380831]  ret_from_fork+0x10/0x20
[   85.380839] irq event stamp: 34386
[   85.380840] hardirqs last  enabled at (34385): [<ffffd20441511408>] _raw_spin_unlock_irq+0x30/0x6c
[   85.380850] hardirqs last disabled at (34386): [<ffffd20441507100>] __schedule+0x510/0x1060
[   85.380852] softirqs last  enabled at (34014): [<ffffd204400c7280>] handle_softirqs+0x514/0x52c
[   85.380865] softirqs last disabled at (34007): [<ffffd204400105c4>] __do_softirq+0x14/0x20
[   85.380867] ---[ end trace 0000000000000000 ]---
[   85.380969] ------------[ cut here ]------------
[   85.380970] WARNING: kernel/sched/sched.h:1571 at update_locked_rq+0x64/0x6c, CPU#10: kworker/u48:1/82
[   85.380974] Modules linked in: qrtr 8021q garp mrp stp llc binfmt_misc sm3_ce r8169 cdns3_pci_wrap nf_tables nfnetlink fuse dm_mod ipv6
[   85.380984] CPU: 10 UID: 0 PID: 82 Comm: kworker/u48:1 Tainted: G S      W           6.19.0-rc7-cix-build+ #256 PREEMPT 
[   85.380987] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   85.380988] Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Orion O6, BIOS 1.1.0-1 2025-12-25T02:55:53+00:00
[   85.380990] Workqueue:  0x0 (events_unbound)
[   85.380993] Sched_ext: storm (enabled+all), task: runnable_at=+0ms
[   85.380994] pstate: 634000c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   85.380996] pc : update_locked_rq+0x64/0x6c
[   85.380997] lr : update_locked_rq+0x60/0x6c
[   85.380999] sp : ffff8000803a3bd0
[   85.381000] x29: ffff8000803a3bd0 x28: fffffdffbf622dc0 x27: ffff00009151b580
[   85.381002] x26: 0000000000000000 x25: ffffd204426cad80 x24: ffffd20442ba5bb8
[   85.381005] x23: c00000000000000a x22: 0000000000000000 x21: ffffd20442ba4830
[   85.381007] x20: ffff00009af0b000 x19: ffff0001fef52d80 x18: 0000000000000000
[   85.381009] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaae6917960
[   85.381012] x14: 0000000000000000 x13: 00000000000a0000 x12: 0000000000000000
[   85.381014] x11: 0000000000000040 x10: ffffd204402e7ca0 x9 : ffffd2044324b000
[   85.381016] x8 : ffff0000810e0000 x7 : 0000d00202cc2dc0 x6 : 0000000000000050
[   85.381019] x5 : ffffd204426b5648 x4 : fffffdffbf622dc0 x3 : ffff0000810e0000
[   85.381021] x2 : 0000000000000002 x1 : ffff2dfdbc960000 x0 : 0000000000000000
[   85.381023] Call trace:
[   85.381024]  update_locked_rq+0x64/0x6c (P)
[   85.381026]  flush_dispatch_buf+0x2a8/0x2dc
[   85.381028]  pick_task_scx+0x2b0/0x6d4
[   85.381030]  __schedule+0x62c/0x1060
[   85.381032]  schedule+0x48/0x15c
[   85.381034]  worker_thread+0xdc/0x358
[   85.381036]  kthread+0x134/0x1fc
[   85.381039]  ret_from_fork+0x10/0x20
[   85.381041] irq event stamp: 34394
[   85.381042] hardirqs last  enabled at (34393): [<ffffd20441511408>] _raw_spin_unlock_irq+0x30/0x6c
[   85.381044] hardirqs last disabled at (34394): [<ffffd20441507100>] __schedule+0x510/0x1060
[   85.381046] softirqs last  enabled at (34014): [<ffffd204400c7280>] handle_softirqs+0x514/0x52c
[   85.381049] softirqs last disabled at (34007): [<ffffd204400105c4>] __do_softirq+0x14/0x20
[   85.381050] ---[ end trace 0000000000000000 ]---
[   85.381199] ------------[ cut here ]------------
[   85.381201] WARNING: kernel/sched/sched.h:1571 at update_locked_rq+0x64/0x6c, CPU#10: kworker/u48:1/82
