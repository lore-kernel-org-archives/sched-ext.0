Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C934BA36;
	Fri, 19 Sep 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290661; cv=none; b=Z6aeFGbaQKlXU1U7xohK2Z08Mort99d+0i1xRjmCuyNslD2CoQwSiqd2Q0kdl/ZBDQyw/pcQN7YosEKA2FGlR4rCHhKJDSWZ+ksWx4reLWFaZXvubEeF92NTulsL2q/Psvj5aCZSJT4iNlyoDNKcmVGaSQ2++HvLSsfQnpAg+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290661; c=relaxed/simple;
	bh=XL5yArtNUTY+ZemwibXmY1EtDuge39/hSn+BkqgTHKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjyIStyuItxKMIfWPD6NT49W538nVb4JDq/kLLCFt3iSlzJyns52/DgmnP/IMe5SpnoTBvAD9qrMK1OZt1GKzykT8bDEO7/EMxQiXJCqCaDP6aleTDABpFjWMRac9ghZDgxvduz5IROHrXT33aP5aYaZUgWXzmXamuMyN9f2L/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71CC3169C;
	Fri, 19 Sep 2025 07:04:09 -0700 (PDT)
Received: from [10.57.94.196] (unknown [10.57.94.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C623F673;
	Fri, 19 Sep 2025 07:04:16 -0700 (PDT)
Message-ID: <a481e0bc-5a38-498b-b010-bf53c85bfd61@arm.com>
Date: Fri, 19 Sep 2025 15:04:14 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [peterz-queue:sched/cleanup] [sched] b55442cb4e:
 WARNING:possible_circular_locking_dependency_detected
To: kernel test robot <oliver.sang@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, aubrey.li@linux.intel.com, yu.c.chen@intel.com
References: <202509191647.c48ab569-lkp@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202509191647.c48ab569-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 14:24, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:
> 
> commit: b55442cb4ec1669a2034af5d0e65ff30046410f8 ("sched: Employ sched_change guards")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/cleanup
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20241228
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-01
> 	nr_groups: 5
> 
> 
> config: x86_64-randconfig-007-20250917
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509191647.c48ab569-lkp@intel.com
> 
> 
> since we don't have enable knowledge about the relation between this commit
> and the issues we observed, we just try to run more times. parent keeps clean
> while this commit shows various issues.
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
>   vm-snb/trinity/debian-12-x86_64-20240206.cgz/x86_64-randconfig-007-20250917/clang-20/300s/group-01/5
> 
> 5b726e9bf9544a34 b55442cb4ec1669a2034af5d0e6
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :200         28%          55:198   dmesg.BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
>            :200          5%          10:198   dmesg.BUG:kernel_hang_in_test_stage
>            :200          0%           1:198   dmesg.BUG:soft_lockup-CPU##stuck_for#s![(udev-worker):#]
>            :200          0%           1:198   dmesg.BUG:soft_lockup-CPU##stuck_for#s![sed:#]
>            :200          0%           1:198   dmesg.BUG:soft_lockup-CPU##stuck_for#s![trinity##]
>            :200          3%           6:198   dmesg.KASAN:null-ptr-deref_in_range[#-#]
>            :200          3%           6:198   dmesg.Kernel_panic-not_syncing:Fatal_exception
>            :200          2%           3:198   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
>            :200          3%           6:198   dmesg.Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
>            :200          2%           4:198   dmesg.RIP:__rb_erase_color
>            :200          9%          18:198   dmesg.RIP:pick_next_task_fair
>            :200          1%           2:198   dmesg.RIP:pick_task_fair
>            :200          0%           1:198   dmesg.RIP:place_entity
>            :200         10%          19:198   dmesg.RIP:put_prev_task_fair
>            :200         10%          19:198   dmesg.RIP:sched_change_begin
>            :200          2%           3:198   dmesg.RIP:smp_call_function_many_cond
>            :200          9%          18:198   dmesg.WARNING:at_kernel/sched/fair.c:#pick_next_task_fair
>            :200          0%           1:198   dmesg.WARNING:at_kernel/sched/fair.c:#place_entity
>            :200         10%          19:198   dmesg.WARNING:at_kernel/sched/fair.c:#put_prev_task_fair
>            :200         10%          19:198   dmesg.WARNING:at_kernel/sched/sched.h:#sched_change_begin
>            :200         10%          19:198   dmesg.WARNING:possible_circular_locking_dependency_detected
> 
> 
> 
> [   37.369088][  T318] ------------[ cut here ]------------
> [   37.369228][  T318]
> [   37.369230][  T318] ======================================================
> [   37.369231][  T318] WARNING: possible circular locking dependency detected
> [   37.369233][  T318] 6.17.0-rc4-00010-gb55442cb4ec1 #1 Not tainted
> [   37.369235][  T318] ------------------------------------------------------
> [   37.369236][  T318] v4l_id/318 is trying to acquire lock:
> [ 37.369237][ T318] ffffffff85719f40 (console_owner){-.-.}-{0:0}, at: console_flush_all (include/linux/rcupdate.h:336 include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
> [   37.369249][  T318]
> [   37.369249][  T318] but task is already holding lock:
> [ 37.369250][ T318] ffff8883aeff5298 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:?) 
> [   37.369255][  T318]
> [   37.369255][  T318] which lock already depends on the new lock.
> [   37.369255][  T318]
> [   37.369256][  T318]
> [   37.369256][  T318] the existing dependency chain (in reverse order) is:
> [   37.369257][  T318]
> [   37.369257][  T318] -> #4 (&rq->__lock){-.-.}-{2:2}:
> [ 37.369260][ T318] _raw_spin_lock_nested (kernel/locking/spinlock.c:378) 
> [ 37.369263][ T318] raw_spin_rq_lock_nested (kernel/sched/core.c:?) 
> [ 37.369265][ T318] __task_rq_lock (include/linux/sched.h:2226) 
> [ 37.369267][ T318] wake_up_new_task (kernel/sched/core.c:4867) 
> [ 37.369269][ T318] kernel_clone (kernel/fork.c:2639) 
> [ 37.369272][ T318] user_mode_thread (kernel/fork.c:2683) 
> [ 37.369274][ T318] rest_init (init/main.c:709) 
> [ 37.369276][ T318] start_kernel (init/main.c:1038) 
> [ 37.369279][ T318] x86_64_start_reservations (??:?) 
> [ 37.369282][ T318] x86_64_start_kernel (arch/x86/kernel/head64.c:231) 
> [ 37.369284][ T318] common_startup_64 (arch/x86/kernel/head_64.S:419) 
> [   37.369285][  T318]
> [   37.369285][  T318] -> #3 (&p->pi_lock){-.-.}-{2:2}:
> [ 37.369288][ T318] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
> [ 37.369290][ T318] try_to_wake_up (include/linux/spinlock.h:? kernel/sched/core.c:4216) 
> [ 37.369292][ T318] __wake_up_common_lock (kernel/sched/wait.c:109) 
> [ 37.369295][ T318] tty_port_default_wakeup (drivers/tty/tty_port.c:70) 
> [ 37.369298][ T318] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1735) 
> [ 37.369300][ T318] serial8250_handle_irq (include/linux/serial_core.h:1231) 
> [ 37.369301][ T318] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:82) 
> [ 37.369305][ T318] __handle_irq_event_percpu (kernel/irq/handle.c:?) 
> [ 37.369306][ T318] handle_irq_event (kernel/irq/handle.c:?) 
> [ 37.369308][ T318] handle_edge_irq (kernel/irq/chip.c:857) 
> [ 37.369310][ T318] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:328) 
> [ 37.369312][ T318] common_interrupt (arch/x86/kernel/irq.c:318) 
> [ 37.369315][ T318] asm_common_interrupt (arch/x86/include/asm/idtentry.h:693) 
> [ 37.369317][ T318] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152) 
> [ 37.369319][ T318] stack_depot_save_flags (lib/stackdepot.c:722) 
> [ 37.369322][ T318] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
> [ 37.369324][ T318] __kasan_slab_alloc (mm/kasan/common.c:359) 
> [ 37.369326][ T318] kmem_cache_alloc_noprof (include/linux/kasan.h:250 mm/slub.c:4180 mm/slub.c:4229 mm/slub.c:4236) 
> [ 37.369329][ T318] fill_pool (lib/debugobjects.c:372) 
> [ 37.369331][ T318] debug_object_assert_init (lib/debugobjects.c:726) 
> [ 37.369332][ T318] __try_to_del_timer_sync (kernel/time/timer.c:? kernel/time/timer.c:848 kernel/time/timer.c:1457) 
> [ 37.369336][ T318] __timer_delete_sync (kernel/time/timer.c:1622) 
> [ 37.369337][ T318] schedule_timeout (kernel/time/sleep_timeout.c:103) 
> [ 37.369339][ T318] rcu_gp_fqs_loop (kernel/rcu/tree.c:2083) 
> [ 37.369341][ T318] rcu_gp_kthread (kernel/rcu/tree.c:2288) 
> [ 37.369342][ T318] kthread (kernel/kthread.c:465) 
> [ 37.369344][ T318] ret_from_fork (arch/x86/kernel/process.c:154) 
> [ 37.369346][ T318] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
> [   37.369350][  T318]
> [   37.369350][  T318] -> #2 (&tty->write_wait){-.-.}-{3:3}:
> [ 37.369352][ T318] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
> [ 37.369354][ T318] __wake_up_common_lock (kernel/sched/wait.c:?) 
> [ 37.369356][ T318] tty_port_default_wakeup (drivers/tty/tty_port.c:70) 
> [ 37.369358][ T318] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1735) 
> [ 37.369359][ T318] serial8250_handle_irq (include/linux/serial_core.h:1231) 
> [ 37.369360][ T318] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:82) 
> [ 37.369363][ T318] __handle_irq_event_percpu (kernel/irq/handle.c:?) 
> [ 37.369364][ T318] handle_irq_event (kernel/irq/handle.c:?) 
> [ 37.369365][ T318] handle_edge_irq (kernel/irq/chip.c:857) 
> [ 37.369367][ T318] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:328) 
> [ 37.369369][ T318] common_interrupt (arch/x86/kernel/irq.c:318) 
> [ 37.369371][ T318] asm_common_interrupt (arch/x86/include/asm/idtentry.h:693) 
> [ 37.369372][ T318] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152) 
> [ 37.369374][ T318] uart_port_unlock_deref (drivers/tty/serial/serial_core.c:74 drivers/tty/serial/serial_core.c:92) 
> [ 37.369375][ T318] uart_write (drivers/tty/serial/serial_core.c:639) 
> [ 37.369377][ T318] do_output_char (drivers/tty/n_tty.c:?) 
> [ 37.369380][ T318] n_tty_write (drivers/tty/n_tty.c:486 drivers/tty/n_tty.c:2388) 
> [ 37.369381][ T318] file_tty_write (drivers/tty/tty_io.c:1006) 
> [ 37.369382][ T318] do_iter_readv_writev (fs/read_write.c:828) 
> [ 37.369385][ T318] vfs_writev (fs/read_write.c:1057) 
> [ 37.369387][ T318] do_writev (fs/read_write.c:?) 
> [ 37.369389][ T318] do_syscall_64 (arch/x86/entry/syscall_64.c:?) 
> [ 37.369391][ T318] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [   37.369393][  T318]
> [   37.369393][  T318] -> #1 (&port_lock_key){-.-.}-{3:3}:
> [ 37.369395][ T318] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
> [ 37.369397][ T318] serial8250_console_write (include/linux/serial_core.h:?) 
> [ 37.369399][ T318] console_flush_all (kernel/printk/printk.c:3055 kernel/printk/printk.c:3139 kernel/printk/printk.c:3226) 
> [ 37.369400][ T318] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
> [ 37.369401][ T318] vprintk_emit (kernel/printk/printk.c:?) 
> [ 37.369403][ T318] _printk (kernel/printk/printk.c:2478) 
> [ 37.369405][ T318] register_console (kernel/printk/printk.c:4127) 
> [ 37.369406][ T318] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:?) 
> [ 37.369408][ T318] console_init (kernel/printk/printk.c:4325) 
> [ 37.369411][ T318] start_kernel (init/main.c:1036) 
> [ 37.369413][ T318] x86_64_start_reservations (??:?) 
> [ 37.369415][ T318] x86_64_start_kernel (arch/x86/kernel/head64.c:231) 
> [ 37.369417][ T318] common_startup_64 (arch/x86/kernel/head_64.S:419) 
> [   37.369418][  T318]
> [   37.369418][  T318] -> #0 (console_owner){-.-.}-{0:0}:
> [ 37.369420][ T318] __lock_acquire (kernel/locking/lockdep.c:3166) 
> [ 37.369422][ T318] lock_acquire (kernel/locking/lockdep.c:5868) 
> [ 37.369424][ T318] console_flush_all (kernel/printk/printk.c:1924) 
> [ 37.369426][ T318] console_unlock (kernel/printk/printk.c:3285 kernel/printk/printk.c:3325) 
> [ 37.369427][ T318] vprintk_emit (kernel/printk/printk.c:?) 
> [ 37.369428][ T318] _printk (kernel/printk/printk.c:2478) 
> [ 37.369429][ T318] report_bug (lib/bug.c:?) 
> [ 37.369431][ T318] handle_bug (arch/x86/kernel/traps.c:338) 
> [ 37.369433][ T318] exc_invalid_op (arch/x86/kernel/traps.c:392) 
> [ 37.369435][ T318] asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> [ 37.369437][ T318] sched_change_begin (kernel/sched/sched.h:2447) 
> [ 37.369439][ T318] sched_move_task (kernel/sched/sched.h:3873 kernel/sched/core.c:9226) 
> [ 37.369440][ T318] do_exit (kernel/exit.c:965) 
> [ 37.369442][ T318] do_group_exit (kernel/exit.c:1081) 
> [ 37.369444][ T318] __cfi___ia32_sys_exit_group (kernel/exit.c:1113) 
> [ 37.369446][ T318] x64_sys_call (??:?) 
> [ 37.369447][ T318] do_syscall_64 (arch/x86/entry/syscall_64.c:?) 
> [ 37.369449][ T318] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [   37.369451][  T318]
> [   37.369451][  T318] other info that might help us debug this:
> [   37.369451][  T318]
> [   37.369451][  T318] Chain exists of:
> [   37.369451][  T318]   console_owner --> &p->pi_lock --> &rq->__lock
> [   37.369451][  T318]
> [   37.369455][  T318]  Possible unsafe locking scenario:
> [   37.369455][  T318]
> [   37.369456][  T318]        CPU0                    CPU1
> [   37.369456][  T318]        ----                    ----
> [   37.369457][  T318]   lock(&rq->__lock);
> [   37.369458][  T318]                                lock(&p->pi_lock);
> [   37.369460][  T318]                                lock(&rq->__lock);
> [   37.369461][  T318]   lock(console_owner);
> [   37.369463][  T318]
> [   37.369463][  T318]  *** DEADLOCK ***
> [   37.369463][  T318]
> [   37.369464][  T318] 4 locks held by v4l_id/318:
> [ 37.369465][ T318] #0: ffff8881ab704378 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock (kernel/sched/core.c:734) 
> [ 37.369470][ T318] #1: ffff8883aeff5298 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:?) 
> [ 37.369474][ T318] #2: ffffffff85719fa0 (console_lock){+.+.}-{0:0}, at: _printk (kernel/printk/printk.c:2478) 
> [ 37.369478][ T318] #3: ffffffff85329830 (console_srcu){....}-{0:0}, at: console_flush_all (include/linux/rcupdate.h:336 include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
> [   37.369482][  T318]
> [   37.369482][  T318] stack backtrace:
> [   37.369484][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Not tainted 6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
> [   37.369487][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   37.369490][  T318] Call Trace:
> [   37.369492][  T318]  <TASK>
> [ 37.369493][ T318] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 37.369497][ T318] print_circular_bug (kernel/locking/lockdep.c:2045) 
> [ 37.369501][ T318] check_noncircular (kernel/locking/lockdep.c:?) 
> [ 37.369505][ T318] __lock_acquire (kernel/locking/lockdep.c:3166) 
> [ 37.369512][ T318] lock_acquire (kernel/locking/lockdep.c:5868) 
> [ 37.369514][ T318] ? console_flush_all (include/linux/rcupdate.h:336 include/linux/srcu.h:319 kernel/printk/printk.c:288 kernel/printk/printk.c:3203) 
> [ 37.369517][ T318] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23) 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250919/202509191647.c48ab569-lkp@intel.com
> 
> 

To save everyone a click, I guess what you're interested in is cut off above, so:

[   37.422211][  T318] WARNING: CPU: 1 PID: 318 at kernel/sched/sched.h:2447 sched_change_begin+0x318/0x4b0
[   37.422652][  T318] Modules linked in:
[   37.422836][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Not tainted 6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
[   37.423500][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.423970][  T318] RIP: 0010:sched_change_begin+0x318/0x4b0
[   37.424239][  T318] Code: 53 fc 74 02 0f 0b 41 ff d3 4c 89 f0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c9 31 ff 31 d2 31 f6 c3 0f 0b e9 30 fe ff ff <0f> 0b e9 7a ff ff ff 48 c7 c7 60 1a 31 85 4c 89 f6 e8 f2 88 f4 00
[   37.425120][  T318] RSP: 0018:ffff8881197dfcf0 EFLAGS: 00010087
[   37.425400][  T318] RAX: 1ffff11075dfeba9 RBX: ffff8881ab703b80 RCX: 0000000000000000
[   37.425762][  T318] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   37.426144][  T318] RBP: ffff8881197dfd28 R08: 0000000000000000 R09: 0000000000000000
[   37.426657][  T318] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8883aeff5280
[   37.427182][  T318] R13: 1ffff11075dc45be R14: ffff8883aee22de8 R15: ffff8883aeff5d48
[   37.427706][  T318] FS:  0000000000000000(0000) GS:ffff88842823c000(0000) knlGS:0000000000000000
[   37.428300][  T318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.428753][  T318] CR2: 00007fa3f071a520 CR3: 0000000005274000 CR4: 00000000000406b0
[   37.429292][  T318] Call Trace:
[   37.429501][  T318]  <TASK>
[   37.429687][  T318]  sched_move_task+0x68/0x620
[   37.429989][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.430305][  T318]  do_exit+0x6be/0x1b30
[   37.430578][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.430926][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.431266][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.431676][  T318]  ? preempt_count_sub+0x9e/0x1b0
[   37.432042][  T318]  do_group_exit+0x1b2/0x280
[   37.432377][  T318]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.432814][  T318]  __x64_sys_exit_group+0x40/0x40
[   37.433177][  T318]  x64_sys_call+0xd06/0xd10
[   37.433508][  T318]  do_syscall_64+0xc1/0x310
[   37.433842][  T318]  ? lockdep_hardirqs_on+0x8c/0x140
[   37.434205][  T318]  ? exc_page_fault+0x99/0xe0
[   37.434539][  T318]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.434958][  T318] RIP: 0033:0x7fa3f071a349
[   37.435276][  T318] Code: Unable to access opcode bytes at 0x7fa3f071a31f.
[   37.437107][  T318] RSP: 002b:00007ffd67104148 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   37.437696][  T318] RAX: ffffffffffffffda RBX: 00007fa3f08149e0 RCX: 00007fa3f071a349
[   37.438258][  T318] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   37.438823][  T318] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 00007ffd6710407f
[   37.439378][  T318] R10: 00007ffd67104000 R11: 0000000000000246 R12: 00007fa3f08149e0
[   37.439966][  T318] R13: 00007fa3f081a2e0 R14: 0000000000000001 R15: 00007fa3f081a2c8
[   37.440543][  T318]  </TASK>
[   37.440777][  T318] irq event stamp: 2972
[   37.441082][  T318] hardirqs last  enabled at (2971): [<ffffffff815a5b5e>] call_rcu+0x58e/0x7f0
[   37.441706][  T318] hardirqs last disabled at (2972): [<ffffffff83f9e8e6>] _raw_spin_lock_irqsave+0x36/0xd0
[   37.442398][  T318] softirqs last  enabled at (1852): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.443076][  T318] softirqs last disabled at (1850): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.445088][  T318] ---[ end trace 0000000000000000 ]---
[   37.445492][  T318] ------------[ cut here ]------------
[   37.445872][  T318] WARNING: CPU: 1 PID: 318 at kernel/sched/fair.c:5560 put_prev_task_fair+0xfc/0x160
[   37.446525][  T318] Modules linked in:
[   37.446807][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Tainted: G        W           6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
[   37.447934][  T318] Tainted: [W]=WARN
[   37.448211][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.448949][  T318] RIP: 0010:put_prev_task_fair+0xfc/0x160
[   37.449362][  T318] Code: 00 00 00 00 48 81 c3 98 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 0f 84 32 ff ff ff 48 89 df e8 39 7d 69 00 e9 25 ff ff ff <0f> 0b 43 80 3c 27 00 75 c2 eb c8 44 89 f9 80 e1 07 38 c1 0f 8c 52
[   37.450697][  T318] RSP: 0018:ffff8881197dfcc0 EFLAGS: 00010087
[   37.451139][  T318] RAX: 0000000000000000 RBX: ffff8881ab703c00 RCX: 0000000000000000
[   37.453043][  T318] RDX: 0000000000000000 RSI: ffff8881ab703b80 RDI: ffff8881ab703ca0
[   37.453595][  T318] RBP: ffff8881197dfd28 R08: 0000000000000000 R09: 0000000000000000
[   37.454183][  T318] R10: 0000000000000000 R11: ffffffff814bfdf0 R12: dffffc0000000000
[   37.454736][  T318] R13: 1ffff110356e078a R14: ffff8881a7e15858 R15: 1ffff11034fc2b0b
[   37.455291][  T318] FS:  0000000000000000(0000) GS:ffff88842823c000(0000) knlGS:0000000000000000
[   37.455906][  T318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.456362][  T318] CR2: 00007fa3f071a520 CR3: 0000000005274000 CR4: 00000000000406b0
[   37.456922][  T318] Call Trace:
[   37.457164][  T318]  <TASK>
[   37.457378][  T318]  sched_change_begin+0x2f7/0x4b0
[   37.457743][  T318]  sched_move_task+0x68/0x620
[   37.458121][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.458359][  T318]  do_exit+0x6be/0x1b30
[   37.458560][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.458809][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.459037][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.459284][  T318]  ? preempt_count_sub+0x9e/0x1b0
[   37.459528][  T318]  do_group_exit+0x1b2/0x280
[   37.459752][  T318]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.460043][  T318]  __x64_sys_exit_group+0x40/0x40
[   37.460285][  T318]  x64_sys_call+0xd06/0xd10
[   37.460504][  T318]  do_syscall_64+0xc1/0x310
[   37.460736][  T318]  ? lockdep_hardirqs_on+0x8c/0x140
[   37.460984][  T318]  ? exc_page_fault+0x99/0xe0
[   37.461207][  T318]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.461488][  T318] RIP: 0033:0x7fa3f071a349
[   37.461700][  T318] Code: Unable to access opcode bytes at 0x7fa3f071a31f.
[   37.462050][  T318] RSP: 002b:00007ffd67104148 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   37.462445][  T318] RAX: ffffffffffffffda RBX: 00007fa3f08149e0 RCX: 00007fa3f071a349
[   37.462815][  T318] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   37.463185][  T318] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 00007ffd6710407f
[   37.463555][  T318] R10: 00007ffd67104000 R11: 0000000000000246 R12: 00007fa3f08149e0
[   37.463924][  T318] R13: 00007fa3f081a2e0 R14: 0000000000000001 R15: 00007fa3f081a2c8
[   37.464297][  T318]  </TASK>
[   37.464444][  T318] irq event stamp: 2972
[   37.464640][  T318] hardirqs last  enabled at (2971): [<ffffffff815a5b5e>] call_rcu+0x58e/0x7f0
[   37.465059][  T318] hardirqs last disabled at (2972): [<ffffffff83f9e8e6>] _raw_spin_lock_irqsave+0x36/0xd0
[   37.465514][  T318] softirqs last  enabled at (1852): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.465954][  T318] softirqs last disabled at (1850): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.466405][  T318] ---[ end trace 0000000000000000 ]---
[   37.466797][  T318] ------------[ cut here ]------------
[   37.467057][  T318] WARNING: CPU: 1 PID: 318 at kernel/sched/fair.c:5560 pick_next_task_fair+0x9a7/0xf20
[   37.467500][  T318] Modules linked in:
[   37.467687][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Tainted: G        W           6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
[   37.468429][  T318] Tainted: [W]=WARN
[   37.468609][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.469097][  T318] RIP: 0010:pick_next_task_fair+0x9a7/0xf20
[   37.469375][  T318] Code: ff df 80 3c 08 00 74 08 4c 89 f7 e8 83 33 6a 00 4d 8b 36 4d 85 ed 0f 84 0b fe ff ff 4d 39 f5 0f 85 02 fe ff ff e9 8b 00 00 00 <0f> 0b 41 80 7c 2d 00 00 0f 85 ef fe ff ff e9 f2 fe ff ff 44 89 e9
[   37.470286][  T318] RSP: 0018:ffff8881197dfb28 EFLAGS: 00010007
[   37.470572][  T318] RAX: dffffc0000000000 RBX: ffff8881a910bc00 RCX: 0000000000000000
[   37.470945][  T318] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   37.471313][  T318] RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
[   37.471681][  T318] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[   37.472049][  T318] R13: 1ffff11034fc2b0b R14: ffff8881a7e15858 R15: ffff888153abbb80
[   37.472418][  T318] FS:  0000000000000000(0000) GS:ffff88842823c000(0000) knlGS:0000000000000000
[   37.472838][  T318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.473144][  T318] CR2: 00007fa3f071a520 CR3: 0000000005274000 CR4: 00000000000406b0
[   37.473514][  T318] Call Trace:
[   37.473673][  T318]  <TASK>
[   37.473816][  T318]  __pick_next_task+0xea/0x480
[   37.474060][  T318]  __schedule+0x618/0x40b0
[   37.474276][  T318]  ? do_task_dead+0x35/0xf0
[   37.474492][  T318]  ? do_task_dead+0xb6/0xf0
[   37.474708][  T318]  ? do_task_dead+0x40/0xf0
[   37.474923][  T318]  do_task_dead+0xe9/0xf0
[   37.475128][  T318]  do_exit+0xe75/0x1b30
[   37.475326][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.475552][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.475796][  T318]  ? preempt_count_sub+0x9e/0x1b0
[   37.476033][  T318]  do_group_exit+0x1b2/0x280
[   37.476252][  T318]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.476536][  T318]  __x64_sys_exit_group+0x40/0x40
[   37.476781][  T318]  x64_sys_call+0xd06/0xd10
[   37.476995][  T318]  do_syscall_64+0xc1/0x310
[   37.477210][  T318]  ? lockdep_hardirqs_on+0x8c/0x140
[   37.477455][  T318]  ? exc_page_fault+0x99/0xe0
[   37.477677][  T318]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.477966][  T318] RIP: 0033:0x7fa3f071a349
[   37.478177][  T318] Code: Unable to access opcode bytes at 0x7fa3f071a31f.
[   37.478502][  T318] RSP: 002b:00007ffd67104148 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   37.478892][  T318] RAX: ffffffffffffffda RBX: 00007fa3f08149e0 RCX: 00007fa3f071a349
[   37.479261][  T318] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   37.479630][  T318] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 00007ffd6710407f
[   37.480000][  T318] R10: 00007ffd67104000 R11: 0000000000000246 R12: 00007fa3f08149e0
[   37.480369][  T318] R13: 00007fa3f081a2e0 R14: 0000000000000001 R15: 00007fa3f081a2c8
[   37.480748][  T318]  </TASK>
[   37.480895][  T318] irq event stamp: 2972
[   37.481090][  T318] hardirqs last  enabled at (2971): [<ffffffff815a5b5e>] call_rcu+0x58e/0x7f0
[   37.481500][  T318] hardirqs last disabled at (2972): [<ffffffff83f9e8e6>] _raw_spin_lock_irqsave+0x36/0xd0
[   37.481966][  T318] softirqs last  enabled at (1852): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.482407][  T318] softirqs last disabled at (1850): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.482846][  T318] ---[ end trace 0000000000000000 ]---
[   37.483107][  T318] ------------[ cut here ]------------
[   37.483362][  T318] WARNING: CPU: 1 PID: 318 at kernel/sched/fair.c:5560 pick_next_task_fair+0xcc0/0xf20
[   37.483805][  T318] Modules linked in:
[   37.483991][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Tainted: G        W           6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
[   37.484738][  T318] Tainted: [W]=WARN
[   37.484918][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.485395][  T318] RIP: 0010:pick_next_task_fair+0xcc0/0xf20
[   37.485671][  T318] Code: 0f 0b e9 88 f8 ff ff 0f 0b e9 b3 f5 ff ff 0f 0b e9 a4 f6 ff ff 0f 0b e9 86 f7 ff ff 0f 0b e9 ba f4 ff ff 0f 0b e9 8d f4 ff ff <0f> 0b e9 f0 fd ff ff 0f 0b eb a9 89 f9 80 e1 07 80 c1 03 38 c1 0f
[   37.486577][  T318] RSP: 0018:ffff8881197dfb28 EFLAGS: 00010087
[   37.486861][  T318] RAX: 0000000000000000 RBX: 1ffff11075dfea7b RCX: 0000000000000000
[   37.487230][  T318] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   37.487598][  T318] RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
[   37.487968][  T318] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881ac49ae00
[   37.488335][  T318] R13: ffff8883aeff5380 R14: ffff8883aeff53d8 R15: ffff888153abbb80
[   37.488710][  T318] FS:  0000000000000000(0000) GS:ffff88842823c000(0000) knlGS:0000000000000000
[   37.489122][  T318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.489428][  T318] CR2: 00007fa3f071a520 CR3: 0000000005274000 CR4: 00000000000406b0
[   37.489797][  T318] Call Trace:
[   37.489965][  T318]  <TASK>
[   37.490107][  T318]  __pick_next_task+0xea/0x480
[   37.490335][  T318]  __schedule+0x618/0x40b0
[   37.490549][  T318]  ? do_task_dead+0x35/0xf0
[   37.490764][  T318]  ? do_task_dead+0xb6/0xf0
[   37.490980][  T318]  ? do_task_dead+0x40/0xf0
[   37.491194][  T318]  do_task_dead+0xe9/0xf0
[   37.491400][  T318]  do_exit+0xe75/0x1b30
[   37.491597][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.491823][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.492067][  T318]  ? preempt_count_sub+0x9e/0x1b0
[   37.492305][  T318]  do_group_exit+0x1b2/0x280
[   37.492522][  T318]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.492811][  T318]  __x64_sys_exit_group+0x40/0x40
[   37.493048][  T318]  x64_sys_call+0xd06/0xd10
[   37.493260][  T318]  do_syscall_64+0xc1/0x310
[   37.493474][  T318]  ? lockdep_hardirqs_on+0x8c/0x140
[   37.493718][  T318]  ? exc_page_fault+0x99/0xe0
[   37.493949][  T318]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.494226][  T318] RIP: 0033:0x7fa3f071a349
[   37.494435][  T318] Code: Unable to access opcode bytes at 0x7fa3f071a31f.
[   37.494759][  T318] RSP: 002b:00007ffd67104148 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   37.495148][  T318] RAX: ffffffffffffffda RBX: 00007fa3f08149e0 RCX: 00007fa3f071a349
[   37.495516][  T318] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   37.495884][  T318] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 00007ffd6710407f
[   37.496252][  T318] R10: 00007ffd67104000 R11: 0000000000000246 R12: 00007fa3f08149e0
[   37.496620][  T318] R13: 00007fa3f081a2e0 R14: 0000000000000001 R15: 00007fa3f081a2c8
[   37.497041][  T318]  </TASK>
[   37.497187][  T318] irq event stamp: 2972
[   37.497382][  T318] hardirqs last  enabled at (2971): [<ffffffff815a5b5e>] call_rcu+0x58e/0x7f0
[   37.497791][  T318] hardirqs last disabled at (2972): [<ffffffff83f9e8e6>] _raw_spin_lock_irqsave+0x36/0xd0
[   37.498257][  T318] softirqs last  enabled at (1852): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.498698][  T318] softirqs last disabled at (1850): [<ffffffff81328b7f>] fpu_flush_thread+0x27f/0x450
[   37.499137][  T318] ---[ end trace 0000000000000000 ]---
[   37.499401][  T318] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
[   37.499932][  T318] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   37.500320][  T318] CPU: 1 UID: 0 PID: 318 Comm: v4l_id Tainted: G        W           6.17.0-rc4-00010-gb55442cb4ec1 #1 PREEMPT(voluntary)  f9b7745e0f49cb37d78d99070980d0f206cf36b5
[   37.501071][  T318] Tainted: [W]=WARN
[   37.501249][  T318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.501721][  T318] RIP: 0010:__rb_erase_color+0xe2/0xb40
[   37.501988][  T318] Code: df 41 80 3c 07 00 74 0a 48 8b 7c 24 08 e8 36 0e c2 fd 4c 89 65 08 49 89 2e 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 e7 e8 10 0e c2 fd 48 8d 45 01 49 89 04 24
[   37.502870][  T318] RSP: 0018:ffff8881197df9c8 EFLAGS: 00010046
[   37.503151][  T318] RAX: 0000000000000000 RBX: 1ffff110358935c2 RCX: dffffc0000000000
[   37.503515][  T318] RDX: ffffffff814caa20 RSI: 1ffff11075dfea79 RDI: ffff888108a45a10
[   37.503879][  T318] RBP: ffff888108a45a10 R08: 0000000000000000 R09: 0000000000000000
[   37.504243][  T318] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   37.504606][  T318] R13: ffff8881ac49ae10 R14: ffff8881ac49ae20 R15: 1ffff11021148b43
[   37.504981][  T318] FS:  0000000000000000(0000) GS:ffff88842823c000(0000) knlGS:0000000000000000
[   37.505387][  T318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.505689][  T318] CR2: 00007fa3f071a520 CR3: 0000000005274000 CR4: 00000000000406b0
[   37.506066][  T318] Call Trace:
[   37.506224][  T318]  <TASK>
[   37.506362][  T318]  ? __cfi_min_vruntime_cb_rotate+0x10/0x10
[   37.506637][  T318]  __dequeue_entity+0x882/0xc70
[   37.506867][  T318]  set_next_entity+0xfe/0x520
[   37.507087][  T318]  pick_next_task_fair+0xadc/0xf20
[   37.507325][  T318]  __pick_next_task+0xea/0x480
[   37.507550][  T318]  __schedule+0x618/0x40b0
[   37.507761][  T318]  ? do_task_dead+0x35/0xf0
[   37.507974][  T318]  ? do_task_dead+0xb6/0xf0
[   37.508187][  T318]  ? do_task_dead+0x40/0xf0
[   37.508399][  T318]  do_task_dead+0xe9/0xf0
[   37.508609][  T318]  do_exit+0xe75/0x1b30
[   37.508807][  T318]  ? rcu_is_watching+0x11/0xb0
[   37.509030][  T318]  ? _raw_spin_unlock_irq+0x2f/0x50
[   37.509272][  T318]  ? preempt_count_sub+0x9e/0x1b0
[   37.509507][  T318]  do_group_exit+0x1b2/0x280
[   37.509724][  T318]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.510015][  T318]  __x64_sys_exit_group+0x40/0x40
[   37.510249][  T318]  x64_sys_call+0xd06/0xd10
[   37.510460][  T318]  do_syscall_64+0xc1/0x310
[   37.510671][  T318]  ? lockdep_hardirqs_on+0x8c/0x140
[   37.510913][  T318]  ? exc_page_fault+0x99/0xe0
[   37.511132][  T318]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.511405][  T318] RIP: 0033:0x7fa3f071a349
[   37.511612][  T318] Code: Unable to access opcode bytes at 0x7fa3f071a31f.
[   37.511931][  T318] RSP: 002b:00007ffd67104148 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   37.512315][  T318] RAX: ffffffffffffffda RBX: 00007fa3f08149e0 RCX: 00007fa3f071a349
[   37.512683][  T318] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   37.513046][  T318] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 00007ffd6710407f
[   37.513408][  T318] R10: 00007ffd67104000 R11: 0000000000000246 R12: 00007fa3f08149e0
[   37.513771][  T318] R13: 00007fa3f081a2e0 R14: 0000000000000001 R15: 00007fa3f081a2c8
[   37.514148][  T318]  </TASK>
[   37.514293][  T318] Modules linked in:
[   37.514477][  T318] ---[ end trace 0000000000000000 ]---
[   37.514728][  T318] RIP: 0010:__rb_erase_color+0xe2/0xb40
[   37.514985][  T318] Code: df 41 80 3c 07 00 74 0a 48 8b 7c 24 08 e8 36 0e c2 fd 4c 89 65 08 49 89 2e 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 e7 e8 10 0e c2 fd 48 8d 45 01 49 89 04 24
[   37.515867][  T318] RSP: 0018:ffff8881197df9c8 EFLAGS: 00010046
[   37.516148][  T318] RAX: 0000000000000000 RBX: 1ffff110358935c2 RCX: dffffc0000000000
[   37.516513][  T318] RDX: ffffffff814caa20 RSI: 1ffff11075dfea79 RDI: ffff888108a45a10
[   37.516882][  T318] RBP: ffff888108a45a10 R08: 0000000000000000 R09: 0000000000000000
[   37.517246][  T318] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   37.517610][  T318] R13: ffff8881ac49ae10 R14: ffff8881ac49ae20 R15: 1ffff11021148b43
[   37.517986][  T318] FS:  0000000000000000(0000) GS:ffff88842823c000(0000) knlGS:0000000000000000
[   37.518394][  T318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.518696][  T318] CR2: 00007fa3f071a520 CR3: 0000000005274000 CR4: 00000000000406b0
[   37.519061][  T318] Kernel panic - not syncing: Fatal exception
