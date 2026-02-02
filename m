Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095A29ACD7;
	Mon,  2 Feb 2026 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065526; cv=none; b=ejUS62/6XkVsooGqBa7LPoWMOUbT3+wexB1INDkl0pCr+upY9k5obdrrhquHccn1m9t14CHwf3qhDFyNzgLsEIS99DVVkU75phMRn+UHsHfmmd9Yng/KRptVDqRUC3IaB82SoweMu14ZH3F2Nl1SGR+w2GotmpIp7+T+Z4fWfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065526; c=relaxed/simple;
	bh=wXOg+4ihgNL/9NpKAMXr/PltcGOGNpvxiB9Q/Mdoh1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYqtBSBXE2DzlhOrHkbYHwIvzuZCphQsf8VZH0d/ahe3mfT71UAABih4ps8rv7e6NeIex27Zit0SxS/vquP+deLSpck0zgqiE54GwUpJ6VMJX93faECeEgrMq6AYN24h6rwkL4EMcBceTzTuWNiqGPFmohzvf8Ao/exmbseXb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go9XjDQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go9XjDQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC731C116C6;
	Mon,  2 Feb 2026 20:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065525;
	bh=wXOg+4ihgNL/9NpKAMXr/PltcGOGNpvxiB9Q/Mdoh1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=go9XjDQVHnPL/vUhaelVVXthObvrqrcW3Fg+p1wzbp5wxGww3WGO66bpKqx8SCvEa
	 ia1xZcD5779tF1Jy/CHKztYLcp5NDfwVuVgQHAuPeiJJ8vPMmEzagEA/6dn0MUKZVJ
	 Z+lE86Q5HTASwDSSW1CnnMqmPXSmu21Sa7hIr7bW1claTDONt8DdVC/Ro6D3Nl18Ow
	 mJsS4pRiOs1QUAFl4My2TjnT/egX6QL5eIWAFBH7enDCSs5us9NiUqCRSuzJ9KSiil
	 fauhoGmSU3vVw6yENgpFKdWD0QWI212jt5VeUPS7r07sAhCuVtLbBtIUahGHe2aEhg
	 zc/gKyee3eSig==
Date: Mon, 2 Feb 2026 10:52:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL pointer deref and warnings during
 scx teardown
Message-ID: <aYEOdPEkgA2eUcTE@slm.duckdns.org>
References: <20260202151341.796959-1-arighi@nvidia.com>
 <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
 <aYDy-tCqsH990lW9@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDy-tCqsH990lW9@gpd4>

On Mon, Feb 02, 2026 at 07:54:50PM +0100, Andrea Righi wrote:
> I'm able to reproduce the NULL pointer dereference in set_cpu_allowed_scx()
> quite easily running `stress-ng --race-sched 0` with an scx scheduler that
> is intentionally starving tasks, triggering a stall => disable.
> 
> I think this is what's happening:
> 
>  CPU0                                      CPU1
>  ----                                      ----
>  __sched_setscheduler()
>    task_rq_lock(p)
> 
>    next_class = __setscheduler_class()
>      // next_class is ext_sched_class
>                                            scx_disable_workfn()
>                                              scx_set_enable_state(SCX_DISABLING)
> 
>                                              scx_task_iter_start()
>                                              while ((p = next())) {
> 					       ...
>                                                p->sched_class = fair_sched_class
> 					       ...
>                                              }
>                                              scx_task_iter_stop()
> 
>                                              synchronize_rcu()
>                                              RCU_INIT_POINTER(scx_root, NULL)
> 
>    scoped_guard(sched_change, ...) {
>      p->sched_class = next_class;
>        // next_class is still ext_sched_class,
>        // overwriting fair_sched_class!
>    }
>    // Guard ends, calls sched_change_end()
>    //   switching_to_scx() called
>    //   scx_root == NULL => returns early
> 
>    task_rq_unlock(p)
> 
>    sched_setaffinity(p)
>      set_cpus_allowed_scx()
>        sch = scx_root; // scx_root == NULL => BUG!

Does the following patch fix the issue?

Thanks.

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 136b01950a62..1fc2b358a175 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4234,7 +4234,13 @@ static void scx_disable_workfn(struct kthread_work *work)
 	 * Here, every runnable task is guaranteed to make forward progress and
 	 * we can safely use blocking synchronization constructs. Actually
 	 * disable ops.
+	 *
+	 * Wait for all CPUs to observe %SCX_DISABLING. Otherwise,
+	 * task_should_scx() can see %SCX_ENABLED and __sched_setscheduler() put
+	 * a task into sched_ext while we're migrating tasks out below.
 	 */
+	synchronize_rcu();
+
 	mutex_lock(&scx_enable_mutex);
 
 	static_branch_disable(&__scx_switched_all);
