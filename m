Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27739345CD8;
	Wed, 13 May 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675257; cv=none; b=oWwSGMV2e4nOmou0e+zdf6ac+9Pz7vLFYiMwpvJICMzei/fUrhbtxG4+ZN4EgnOSYIuhiQWBJKwo42GNhpevEURbSXb45UW7l140YacatxLlljg1k6o3bZZLnYXmHRqMHjjKC3/GGp7CBclWaF66Hn0/kIcvKbS95UTn/Ln6EiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675257; c=relaxed/simple;
	bh=nyZXI2mfFkWRpmXLtt4xx8ao5I3Mzjh0g9Rg8fP4WpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbQcds/A52LimmaLgUBKGnPwtcX7rLdPABlAwqnHQZPT5Z8iWSPSMtzUhiJZ63OccFkex0MiMXBQtbt/QxH9N6H1jqA7ml3sWssaHploFfReAQe9KB2f0GTQHmO7XCJW6QlKL9wJszQ0p43zXdc+tI5rHm5b/Uz0fRkSEr4ZREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5zUUKzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5zUUKzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F474C2BCB7;
	Wed, 13 May 2026 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778675256;
	bh=nyZXI2mfFkWRpmXLtt4xx8ao5I3Mzjh0g9Rg8fP4WpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5zUUKzBrBX6/0yQN2rebAVh/Y98b2En4ZwbG8m4kcz5atGu3YjRCkbjRJXyqMLMy
	 fAHsQDu1qM7ndrzjermHL1dKAsFyS29dBcxDnVxk4kp51ZiopawwqFxXG8YKIwUUfD
	 S0+ye/NrBcW53w2Sar0h6chir9EJ7HTkwpfb/p+UhXu7ONx+Q4MMVRVHzgYM8rClIA
	 WOog+lQdKt7h88RqQdLxTFIYE60bFcuP/G79nk+VFdNUp29yefXqWmsgvcoFq9LP5P
	 T37gX5DM/fLAdY5sD4GluqvV9pCrVWS2GMU9c/K9StsXmKqj6bz2cAnaOv79B+wit1
	 kawNN6/p7ufSQ==
Date: Wed, 13 May 2026 14:27:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Juri Lelli <juri.lelli@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Use
 HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation
Message-ID: <agRuNoin972BZ9Ok@localhost.localdomain>
References: <20260513112438.642055-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513112438.642055-1-arighi@nvidia.com>

Le Wed, May 13, 2026 at 01:24:38PM +0200, Andrea Righi a écrit :
> scx_enable() refuses to attach a BPF scheduler when isolcpus=domain is
> in effect by comparing housekeeping_cpumask(HK_TYPE_DOMAIN) against
> cpu_possible_mask.
> 
> Since commit 27c3a5967f05 ("sched/isolation: Convert housekeeping
> cpumasks to rcu pointers"), HK_TYPE_DOMAIN's cpumask is RCU protected
> and dereferencing it requires either RCU read lock, the cpu_hotplug
> write lock, or the cpuset lock; scx_enable() holds none of these, so
> booting with isolcpus=domain and attaching any BPF scheduler triggers
> the following lockdep splat:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   -----------------------------
>   kernel/sched/isolation.c:60 suspicious rcu_dereference_check() usage!
> 
>   1 lock held by scx_flash/281:
>    #0: ffffffff8379fce0 (update_mutex){+.+.}-{4:4}, at:
>        bpf_struct_ops_link_create+0x134/0x1c0
> 
>   Call Trace:
>    dump_stack_lvl+0x6f/0xb0
>    lockdep_rcu_suspicious.cold+0x37/0x70
>    housekeeping_cpumask+0xcd/0xe0
>    scx_enable.isra.0+0x17/0x120
>    bpf_scx_reg+0x5e/0x80
>    bpf_struct_ops_link_create+0x151/0x1c0
>    __sys_bpf+0x1e4b/0x33c0
>    __x64_sys_bpf+0x21/0x30
>    do_syscall_64+0x117/0xf80
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> In addition, commit 03ff73510169 ("cpuset: Update HK_TYPE_DOMAIN cpumask
> from cpuset") made HK_TYPE_DOMAIN include cpuset isolated partitions as
> well, which means the current check also rejects BPF schedulers when a
> cpuset partition is active. That contradicts the original intent of
> commit 9f391f94a173 ("sched_ext: Disallow loading BPF scheduler if
> isolcpus= domain isolation is in effect"), which explicitly noted that
> cpuset partitions are honored through per-task cpumasks and should not
> be rejected.
> 
> Switch to housekeeping_enabled(HK_TYPE_DOMAIN_BOOT), which reads only
> the housekeeping flag bit (no RCU dereference) and reflects exactly the
> boot-time isolcpus= configuration that the error message refers to.
> 
> Fixes: 27c3a5967f05 ("sched/isolation: Convert housekeeping cpumasks to rcu pointers")

Ok reading the changelog of the above Fixes: head, I now understand why isolcpus
is excluded and not cpuset.

> Cc: stable@vger.kernel.org # v7.0+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
