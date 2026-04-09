Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEC340A57
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704929; cv=none; b=HWNG/EoEZgJ/6i5BfT01iBg5eqIckQ9JVuEaCRIqjaJOyEuoEwnrmEk6U6YeN8mTHKBYX6Q5p3hRJvJ4CkH0CaynjlTwaBB1OJLgSp7h0nbyVaduCuu4TuSda3uWm0KpG93tof1Olbi2MR95v7FuDQCJaDFy8kXVCHHKnuzejh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704929; c=relaxed/simple;
	bh=LmPKmCfAZ5wsl1OBSSMU1qOTEVoG8ZM58tc+JFRlHSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppQFme3f7VsTivTdFGg2l9RaseOXpiSGhkBfSsmt+TrhFa1T9AivQNd2fpjxaUSF+L52760YIzr/Hf2nzThGExxIKToMdV9qm4AAGFUd0/kCKGUYOesIVmfeBr5T3uoIIuN+5LYGhikPeUsUsxFiY6v5ALjp2kY8/n7fKT2xOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=B9G3NJ33; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="B9G3NJ33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8n
	9WYBrN5UUJjB3BMuY9nSyPWcWh8BiVPf4rpMIzsV4=; b=B9G3NJ33t249WBnuCb
	0F+rOUUb9jE1nPbug9s0JfN/QETz3cNGD6l8jUS8btEaa+cElKSZrEHcOSCE0FPn
	+oEW6Pl0WTuIQ3M2jPw++KmCjxPGjVOWZ17sENVIlrYeBPwnxmNefJ5OmlScMB31
	4Jz8iSN0lFUpZX7Togn8teYUM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDndx5AG9dpKePoBA--.19355S2;
	Thu, 09 Apr 2026 11:21:37 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 0/3] sched_ext: Fix kick_cpus_irq_workfn() NULL pointer warning during exit
Date: Thu,  9 Apr 2026 11:21:23 +0800
Message-ID: <20260409032126.114812-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDndx5AG9dpKePoBA--.19355S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyxKFWxGr1UCF15tFW3GFg_yoWrJFy8pF
	W3tFW8Cr4IgrWjvw17Aw4vq345GFWqyay7tr4UKFnrAF45CF4kXr1xta17Xrn8Cr45C342
	vF1qg395KF1jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMyIUUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlgEnnmnXG0FMiQAA3P

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

On PC with 8 core, when running scx_central with stress-ng -c 2 --io 8,
if enable/disable scx_central frequently, dmesg will pop an message:

[   38.214510] sched_ext: BPF scheduler "central" enabled
[   47.809167] hrtimer: interrupt took 11287895 ns
[   48.233813] sched_ext: BPF scheduler "central" disabled (unregistered from user space)
[   48.248460] kick_cpus_irq_workfn() called with NULL scx_kick_syncs <---- here
[   54.597735] sched_ext: BPF scheduler "central" enabled

After adding dump stack in the warning code, it shows:

[  231.269159] sched_ext: BPF scheduler "central" disabled (unregistered from user space)
[  231.278500] CPU: 0 UID: 0 PID: 123 Comm: tmux: server Not tainted 7.0.0-rc2-virtme #13 PREEMPT(full)
[  231.278519] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  231.278536] Call Trace:
[  231.278556]  <IRQ>
[  231.278571]  dump_stack_lvl+0x6f/0xb0
[  231.278640]  kick_cpus_irq_workfn.cold+0x19/0x57
[  231.278670]  ? mark_held_locks+0x40/0x70
[  231.278691]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
[  231.278716]  ? __pfx_kick_cpus_irq_workfn+0x10/0x10
[  231.278750]  irq_work_single+0xcd/0x250
[  231.278776]  irq_work_run_list+0x6a/0xa0
[  231.278794]  irq_work_run+0x18/0x30
[  231.278805]  __sysvec_irq_work+0x4f/0x320
[  231.278842]  sysvec_irq_work+0x43/0xb0
[  231.278863]  asm_sysvec_irq_work+0x1a/0x20
[  231.278883] RIP: 0010:scx_kick_cpu.part.0+0x25b/0x680
[  231.278897] Code: 00 02 75 31 48 89 df e8 03 34 fd ff 4d 85 ed 0f 84 3c ff
[  231.278906] RSP: 0018:ffff888035e08cb8 EFLAGS: 00000286
[  231.278934] RAX: 0000000000000082 RBX: 0000000000000000 RCX: ffffffff88cec5cb
[  231.278946] RDX: ffff888002821d40 RSI: 0000000000000000 RDI: ffffffff88cec5cb
[  231.278956] RBP: ffff888035e49d00 R08: 0000000000000000 R09: 0000000000000001
[  231.278961] R10: ffff8880028228a0 R11: ffff888002821d40 R12: 0000000000000004
[  231.278967] R13: 0000000000000200 R14: 0000000000000002 R15: 0000000400000000
[  231.278998]  ? scx_kick_cpu.part.0+0x24b/0x680
[  231.279015]  ? scx_kick_cpu.part.0+0x24b/0x680
[  231.279039]  ? ops_cpu_valid+0x6c/0xf0
[  231.279060]  scx_bpf_kick_cpu+0xba/0x2e0
[  231.279086]  bpf_prog_402c05d73c49876a_central_timerfn+0x24f/0x26c
[  231.279117]  ? 0xffffffffc0409050
[  231.279150]  ? rcu_read_lock_bh_held+0x2b/0x60
[  231.279181]  bpf_timer_cb+0x168/0x2b0
[  231.279201]  ? __pfx_bpf_timer_cb+0x10/0x10

The whole process is: in scx_root_disable(), after setting scx_kick_syncs
to NULL in free_kick_syncs(), it then exits bypass mode. Since the BPF
timer is stored in BPF map, which is only destroyed at BPF program
exiting, it now can still fire and call scx_bpf_kick_cpu(). It will pass
the scx_bypassing() check and queue irq work, as a result, the null check
in kick_cpus_irq_workfn() is hitted.

Fix it in two aspects:
1. In kernel, check sch->aborting in scx_kick_cpu, prevent new kicks if
the scheduler is in aborting state.
2. In scx_central, cancel bpf timer in op.exit, which will called before
free_kick_syncs(), this avoid the cpu kick from source.

Besides, in Patch 3, propose replacing pr_warn_once with WARN_ON_ONCE to
add stronger race check, and if it is considered not appropriate, we can
drop it.

Zhao Mengmeng (3):
  sched_ext: Prevent CPU kicks from exiting schedulers
  scx_central: Cancel BPF timer during ops.exit
  sched_ext: Use WARN_ON_ONCE to check whether scx_kick_syncs is NULL

 kernel/sched/ext.c                | 7 ++++---
 tools/sched_ext/scx_central.bpf.c | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0

