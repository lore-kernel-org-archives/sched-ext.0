Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29527707
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775705086; cv=none; b=ZOp/xirThtWM5P4UK91C4p8U2/5D0Lx/10dPg+8XD9lwpTJHk34VuOU79VAqvUe5u8g5DJsg0hVB8gP4vwxGtdTE3LvIvKagCMlbs/82nGMB1aB/uBHSs2vu/y7axfD1VVQc9AtpSPgFQdeuHdviK8KcNwand8Z9qOskmsNKNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775705086; c=relaxed/simple;
	bh=myoYvxEpHaK02ZUpbjNq5jqrcbUXWOp79xzxmXAF2WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOEQce8rMAHkWRx49GoBQ3mS+aXlYfXu2QKY4b/vOoUKdnXHvhLXiQ360JFV3l+Aemsa9kHsXYR6z/mwRs6qypoX5QP8RUOpLT02chb0zW7P1H2O1R2ZAFiN7iwCRr6+Cogn2aP6VuSBQsAbWRx5DMXvng7xR8w5dcwbpRg8NIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DdQlIRSc; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DdQlIRSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dT
	ao++VDJ96s8B+9W0qSmQbSrnA858ROCq3VoD5PONs=; b=DdQlIRScHNv3pCIhAL
	+b5i8/oy2qmZc3dqqjR543MeAMdcN/EHgcwM0LwNqSxAzEP008dv2y4tev0bDaWS
	NwHCFCrWSXKZi7bp9gLvh/rxBljMo5+vTXyozHhhDZ6BzjaW1OjqnVfE+MNfcFWo
	gfOXpWOZwn2nVFPivnKmdb6dA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDndx5AG9dpKePoBA--.19355S3;
	Thu, 09 Apr 2026 11:21:37 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 1/3] sched_ext: Prevent CPU kicks from exiting schedulers
Date: Thu,  9 Apr 2026 11:21:24 +0800
Message-ID: <20260409032126.114812-2-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409032126.114812-1-zhaomzhao@126.com>
References: <20260409032126.114812-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDndx5AG9dpKePoBA--.19355S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyxKFWxGr1UCF15tFW3GFg_yoW5Kw1fpF
	W3tFW8Cr4xWrWjqw1UAw4vq345GFZrAa4xJr4DKFnrAF45CF1kXr1xta17Xr1jkr45C342
	qF1DK395Kr1jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjHq7UUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlwEnnmnXG0GBHAAA3W

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

In kernel side, fix it by checking sch->aborting in scx_kick_cpu, prevent
new kicks if the scheduler is in aborting state.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b757b853b42b..0a2a3c6dc7cc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8679,6 +8679,9 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	if (!ops_cpu_valid(sch, cpu, NULL))
 		return;
 
+	if (unlikely(READ_ONCE(sch->aborting)))
+		return;
+
 	local_irq_save(irq_flags);
 
 	this_rq = this_rq();
-- 
2.43.0

