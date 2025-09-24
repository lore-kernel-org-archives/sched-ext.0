Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F921D3C9;
	Wed, 24 Sep 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695887; cv=none; b=qA3QgBnEekRWLBRUtPk5mRiGuH8PCJiLxxx0ku7xxT0fhb6MRfNV0Tyt87bSYzYwFiPkVNhI8wpPj+IPoopf43vZqB0yO0Vef3OQhwcGPCTu214vocBkEs2X4s76qJ+hlpN8iaQx8dBGlhBj5bQJ7OQsTHQmlSkMtwyaFsJDuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695887; c=relaxed/simple;
	bh=0FWcUptjZXF2KcJSQk5WhzpvjI+nx7EN+MHiNt3QPVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moNp3AOhvySJc8tTnXjBCFzhtl16mi2/JDS9r1tOffRMtNhMEgkCFQ6XmioZf5XLxpdrQ5bvnD1LcFXHJ7k/znqwDeyXYxmO7uAygiZp86P/q0690O05gg7S285sYlZJqj8LcaYWD0m1wZqD7fUbPe9FzzAh7+sfcsmBpRVl95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvIcP+69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvIcP+69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C951C4CEE7;
	Wed, 24 Sep 2025 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758695886;
	bh=0FWcUptjZXF2KcJSQk5WhzpvjI+nx7EN+MHiNt3QPVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvIcP+69cctnyeSa8wmXQoOwoV66mlFGMrhdRLSo1mk9s/x/A9XVuYISm8ZiTWHar
	 JdytNZlOoXtDsAJO+akVi+BDH7Bmu9jPQK/aD1QE3aVpT51JlXUOyjYM8ORqEKG9Vt
	 7JFWqhovKhxtuMFWZf6HwC73CsDkH2dAdiCpTH/jVlHDoNxSJGFG+vSH3givFUYCzY
	 +0shsmUgeYMezZTNsQz5dXziIqUx5GsdqDaiatKPU33GJT5zysUxjzSWBQgnA7/Qjj
	 v1IofgcRx64iAy9ZSDYyoHGYEz+hy4edn21y2nb9V0bDdWx7/M9cDCsSh+nhTD5Uq7
	 JtlrLCJ09QO7A==
Date: Tue, 23 Sep 2025 20:38:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNORzVQ6OVkPHAjS@slm.duckdns.org>
References: <20250922013246.275031-1-tj@kernel.org>
 <aNOMK1gk9if3UTgQ@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNOMK1gk9if3UTgQ@gpd4>

Hello,

On Wed, Sep 24, 2025 at 08:14:03AM +0200, Andrea Righi wrote:
> Hi Tejun
> 
> On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> > The find_user_dsq() function is called from contexts that are already
> > under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> > rhashtable_lookup() to avoid redundant RCU locking.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> It looks like the ttwu_queue() path isn't RCU read lock protected.
> With this applied:
> 
> [    6.647598] =============================
> [    6.647603] WARNING: suspicious RCU usage
> [    6.647605] 6.17.0-rc7-virtme #1 Not tainted
> [    6.647608] -----------------------------
> [    6.647608] ./include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
> [    6.647610]
> [    6.647610] other info that might help us debug this:
> [    6.647610]
> [    6.647612]
> [    6.647612] rcu_scheduler_active = 2, debug_locks = 1
> [    6.647613] 1 lock held by swapper/10/0:
> [    6.647614]  #0: ffff8b14bbb3cc98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x20/0x90
> [    6.647630]
> [    6.647630] stack backtrace:
> [    6.647633] CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Not tainted 6.17.0-rc7-virtme #1 PREEMPT(full)
> [    6.647643] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [    6.647646] Sched_ext: beerland_1.0.2_g27d63fc3_x86_64_unknown_linux_gnu (enabled+all)
> [    6.647648] Call Trace:
> [    6.647652]  <IRQ>
> [    6.647655]  dump_stack_lvl+0x78/0xe0
> [    6.647665]  lockdep_rcu_suspicious+0x14a/0x1b0
> [    6.647672]  __rhashtable_lookup.constprop.0+0x1d5/0x250
> [    6.647680]  find_dsq_for_dispatch+0xbc/0x190
> [    6.647684]  do_enqueue_task+0x25b/0x550
> [    6.647689]  enqueue_task_scx+0x21d/0x360
> [    6.647692]  ? trace_lock_acquire+0x22/0xb0
> [    6.647695]  enqueue_task+0x2e/0xd0
> [    6.647698]  ttwu_do_activate+0xa2/0x290
> [    6.647703]  sched_ttwu_pending+0xfd/0x250
> [    6.647706]  __flush_smp_call_function_queue+0x1cd/0x610
> [    6.647714]  __sysvec_call_function_single+0x34/0x150
> [    6.647720]  sysvec_call_function_single+0x6e/0x80
> [    6.647726]  </IRQ>
> [    6.647726]  <TASK>
> [    6.647727]  asm_sysvec_call_function_single+0x1a/0x20
> 
> Should we revert this?

IRQ is disabled, so it is in RCU protected region but the lockdep annotation
isn't happy with it. :-( I'll revert the patch for now.

Thanks.

-- 
tejun
