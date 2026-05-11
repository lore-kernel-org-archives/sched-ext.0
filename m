Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42330DEA5;
	Mon, 11 May 2026 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468131; cv=none; b=V2lwkgkJY0bntri9QHWU4pcCedXij21FHGFl5J+jZTklrK8ZXXZPAJfSFsHACAnbBHoxu33lg5lWHpvB6WGmrj12RbIznjabYdmccEwN/vnmVQtagh9JtY8BbFiivSc4GfLNiH/c58Jfk5E+dWIMhIeZFcGHf3FfnaQ2N845pAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468131; c=relaxed/simple;
	bh=DTC+wqQAI912ztCRp2j2OrnD+8IHbV7hFEPRqvcweHk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nQ66HoBcDTH8mouItRXyrUFyW/Xev5v/ru/Ab6eqAtfpJwvX9QFSJxdB+AbbQxqMwENRLztNstWmGNKEIJ3IqVp23bg1AVpDLDH39XmIBx6cd25NEbHRCeXeKvzjoKOTRHWcu+TR6u0H/4cbdxIb3qof017RA+5kvlpyU3gVNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORv+9HC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORv+9HC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1A1C2BCB8;
	Mon, 11 May 2026 02:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778468131;
	bh=DTC+wqQAI912ztCRp2j2OrnD+8IHbV7hFEPRqvcweHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORv+9HC5VTzjYZHmMdG+JrASKQBuT8ZAfbkrctubWJWdHZAABS5Jydx6e1PgBHCst
	 qikoKmRmrDx/eq5+k8vDmsn+5vefdgPF5KqUlUr2oZh8L/Zdyci/hNmu+fJ4x2xwC0
	 A39A3NubRLfzuCaTv17vjvn6FVrATjSqfufrZJrDTy+D7RiTllyQyY5UJ7Sl7GPdIR
	 H2z+wT/7IxxbFPgRWvn/NGUD4PbJYTPM8Te4CYqZ6xWfG5kvIFREGTywuO80GYrDQt
	 JZbE53M/m/08aS8MvuK+49aBV5fJiZt7vw0MZnTzZaeRuOG0ozSTyKJX2MU9AT9nTU
	 KMvHiPnDejiEQ==
Date: Sun, 10 May 2026 16:55:30 -1000
Message-ID: <a9e31398c4fc7b6ad21f4d9817eead12@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv NULL pointer deref in bpf_scx_unreg()
In-Reply-To: <20260510224332.2011982-1-arighi@nvidia.com>
References: <20260510224332.2011982-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

I traced reload_loop with per-CPU ring probes around all @ops->priv
and scx_root assign/clear sites. The race is a stomp:

  T2 unreg(K)                       T1 reg(K)
  -----------                       ---------
  sch = ops->priv = sch_b800
  scx_disable; flush_disable_work
    [scx_root_disable: scx_root=NULL,
     mutex_unlock, state=DISABLED]
                                    mutex_lock; state ok
                                    scx_alloc_and_add_sched:
                                      ops->priv = sch_a800
                                    scx_root = sch_a800; init=0
                                    state=ENABLED; mutex_unlock
    [flush returns]
  RCU_INIT_POINTER(ops->priv, NULL) <-- clobbers sch_a800
  kobject_put(sch_b800)

Reachable because the unreg waits on sch->helper while the next reg
runs on the global scx_enable_helper, and scx_enable_mutex is released
inside scx_root_disable() well before bpf_scx_unreg() reaches its
RCU_INIT_POINTER. My trace caught 11us between PRIV_SET sch_a800 and
the clobber; nothing bounds it.

The posted patch suppresses the deref but leaves the stomp. Each
stomp leaks one sch (the "sch's base reference will be put by
bpf_scx_unreg()" contract assumes ops->priv still points at it), and
in the case I caught, sch_a800 is already SCX_ENABLED with scx_root
pointing at it - the bpf_link is gone but state stays ENABLED, so all
future attaches fail with -EBUSY permanently.

Suggestion: make @ops->priv the lifecycle binding. In
scx_root_enable_workfn() (and scx_sub_enable_workfn()), after the
existing state check and still under scx_enable_mutex, refuse with
-EBUSY if @ops->priv is non-NULL. Unreg side keeps its current
ordering.

One question: are there other paths that write or clear @ops->priv?
I only see the rcu_assign_pointer in scx_alloc_and_add_sched and the
RCU_INIT_POINTER(NULL) in bpf_scx_unreg().

Thanks.

--
tejun
