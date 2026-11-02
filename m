Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642111;
	b=5mVupApvuwmpGJvDpMuXsHvAe68YEWFn+e+ZGyPbq5jUWzpRYprwFJQM8m7sg8VG1L3b
	 Z03Tu7tSc7oKqoxjQRS1vKMz6DGLBxchk81lXM4TwcQvEHZebxbkEIHdylxHvmWnRKE/b
	 KeOzXKIv9jspj+EJjHicKhj4SBmDB/JLAUOmm8YSck0rLaMHsgYh+ZptWBk3OzvxCSAsI
	 JgD2rTM6W+baTHdR66oPyUrBcRaXgPfG46FDjmQ6E9eVK5KN/BWR//KEKMtgb+8BRNu0P
	 UupSowvgROkKXItZNHV/O2V3582B5c4s5WN6nnH79ih8wlZXYf+MckPv8prZ7qplrwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642111;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I6gbravnOgRD2MRs/Kd+cTOIEtilIY3ejlnNzjQeb6U=;
	b=c1Bitj/3pVoddQo/swpQY7ry2fYx0FzLvlE0knw8Gt5GNEiFuyqCkFdtIu8OWItLvSWi
	 ESFOmzRFRo2vNkDprwM81CGRRiRC9Ca6M7isaINDQLSqq/HF5/a0x40k/sHJ6bCzZECmF
	 Px2RaIgrGhr87+yQDTfs2xngK5hiDi1F6IJQ4NUIzrA0uVd9ZsNCWx0lFiZj7V6FbYAf4
	 KSN/x56pmz9SLv3zc5gA2ui4SpipExmgC5jISFKNTioSBzNUS88JqnY4/OSTz6eLtzMT0
	 meVz0SOePwE+a/EXaMolF9MTw4v9CoYQ9e5FEtbDo0OK0vBIrH+ztHa2WYJJe5XPqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7YgSDPj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB953606BA5C;
	Mon,  2 Nov 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7YgSDPj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EAB1F00A1B;
	Mon,  2 Nov 2026 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642110;
	bh=I6gbravnOgRD2MRs/Kd+cTOIEtilIY3ejlnNzjQeb6U=;
	h=Date:From:To:Cc:Subject;
	b=l7YgSDPjZGVT/WCS+bEAcQpcSqG7NFFPYN9Vw+XAxF/m/1+zwVRCb8kQz1fO0uOLh
	 9qsB0BJBy6nE7RDr/lRN18XDMKVv7yNgS3futu/0Ld9KLPCHCzEfkufs2GBILI3YGe
	 Qc0aErRn3LOdLlemKvIl1YeLadhujkPmkY8C5sJtwLuV+NQDrFmVhV5k9XMkJ5X94j
	 aqfL1a041YABa9rofCYM/q5/YptePUTDvX33WlgeFvNtwampbzL3XF5JTIPkhoK/Mp
	 VtUJHsTJiQGaK+rcIsO6gq3kl9qXxWdpWw0Og586fKP15LXS4MOa7LKCATxGz/KqUh
	 nm1hVw9Xkje8g==
Date: Mon, 02 Nov 2026 07:55:09 -1000
Message-ID: <98e1914a51b7851253e93b2c6d756261@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: proxy_reset_donor() warning from sched_proxy_block_task() when p is curr
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

sched_proxy_block_task() calls proxy_reset_donor() whenever p is the
donor, without checking that p isn't also curr. proxy_reset_donor() then
triggers its WARN_ON_ONCE(rq->donor == rq->curr):

  WARNING: kernel/sched/core.c:3809 at proxy_reset_donor+0x129/0x140, CPU#3: flip/1539
  Call Trace:
   sched_proxy_block_task+0xa1/0x170
   scx_prepare_setscheduler+0xcf/0xe0
   __sched_setscheduler+0x6d6/0xb60
   do_sched_setscheduler+0x105/0x160
   __x64_sys_sched_setscheduler+0x18/0x30
   do_syscall_64+0xec/0x420
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

p is a sched_ext task under a scheduler with SCX_OPS_ENQ_BLOCKED. It
blocks on a mutex in __schedule() and stays queued as a retained donor,
still curr and donor until the pick finishes. The pick goes through
sched_ext dispatch, which drops the rq lock while ops.dispatch() moves a
task from another CPU.

In that window, sched_setscheduler(p, SCHED_EXT) from another CPU takes
p's pi_lock and rq lock and reaches sched_proxy_block_task() with p both
curr and donor. I also hit it, rarely, through scx_sub_enable_workfn()
-> scx_prepare_task_sched_change().

Nothing else went wrong in my runs. The pick sees p dequeued and carries
on.

It reproduces reliably within a minute in an 8-CPU VM on
sched_ext/for-7.4-fixes (2227a34ff7bf) with:

  scx_qmap -X -s 100
  stress-ng --cpu 4 --cpu-method loop
  modprobe locktorture torture_type=mutex_lock nested_locks=8 \
      long_hold=2 nwriters_stress=16

and a small program that flips the lock_torture_wr threads between
SCHED_EXT and SCHED_OTHER with sched_setscheduler() as fast as it can.

Thanks.

--
tejun
