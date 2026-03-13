Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515B30F523;
	Fri, 13 Mar 2026 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428704; cv=none; b=QsDvXKpnA7t10L78bq4dEWr8pEzLYVUhoXIwo6J2dp+9wD0D+kaQEy7TxVncPwpr52Huu2jrOaVnsa/GyLJCDMI2cmZLzA2su/mqCAnHnve6NO+zpUcCYXC6ljoucYDfWx79SA7IO7oMd6LOLIyZd/3eRgj24w5mhF9KxDImLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428704; c=relaxed/simple;
	bh=95ra38/pZo3miq6VbvsnZoXNLUSRHDmBAatrUGh/jAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4pWDERhQZrwohRQ/s/pinQrNUPpm8gRR0e9EeQkTXboUpOTI6OV3eYobd8xGgV2u9Fa5o5McxWAZeazFlckApxS7NlIi/RPVPZfu/Zxk2RZnv97qFrAfkKYt5tYxO42yIpKA1k7UILSQsIOUkTQUjyNkvMDdSW+L54SQ+8aBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZrQPKzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZrQPKzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F41C19421;
	Fri, 13 Mar 2026 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773428703;
	bh=95ra38/pZo3miq6VbvsnZoXNLUSRHDmBAatrUGh/jAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZrQPKzDRwQ3aBJSgy2FM6A0gWll6xScB7/GZJ7lIAUD/1NHipiyB+N4jqq7GU/3W
	 5TpxTL4t4iFVMwtKFrOKiLwm5sgnNouITntaxhO8V+OP8qwGMea4uzJbRiE7vGi7na
	 pHLqRzDA+Jo4SOFn/iP6otG4ePs+mxSN1vV3dgmDHOihnp9gX71k/menLCIbevtXUB
	 CozTe7G8FFf2RnMG216vCP7EPbL619CRlA+AZNahAZcf4+q9YCwqTS778oyWmFF4gi
	 A8u6kQVUd06Be0+qQFDXOFoiHY2FMhVMF4JQ35VHVI7HxnLEfcN4s0AKrd7EE6LfR6
	 4w48eFhspL+yA==
Date: Fri, 13 Mar 2026 09:05:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Drop rq lock before
 calling ops.exit_task()
Message-ID: <abRf3niouUyXQENT@slm.duckdns.org>
References: <20260311231441.276689-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311231441.276689-1-arighi@nvidia.com>

Hello,

On Thu, Mar 12, 2026 at 12:14:41AM +0100, Andrea Righi wrote:
> sched_ext_dead() calls scx_exit_task() while holding the rq lock, which
> invokes ops.exit_task(). If the BPF program calls helpers that acquire
> non-raw locks (e.g., bpf_task_storage_delete()), this can trigger the
> following BUG:
> 
>  =============================
>  [ BUG: Invalid wait context ]
>  7.0.0-rc1-virtme #1 Not tainted
>  -----------------------------
>  (udev-worker)/115 is trying to lock:
>  ffffffffa6970dd0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_ssp_contention+0x54/0x90
>  other info that might help us debug this:
>  context-{5:5}
>  3 locks held by (udev-worker)/115:
>   #0: ffff8e16c634ce58 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
>   #1: ffff8e16fbdbdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
>   #2: ffffffffa6971b60 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
>  stack backtrace:
>  ...
>  Sched_ext: cosmos_1.0.7_g780e898fc_dirty_x64_unknown_linux_gnu (enabled+all), task: runnable_at=-2ms
>  Call Trace:
>   <TASK>
>   __lock_acquire+0xf86/0x1de0
>   lock_acquire+0xcf/0x310
>   _raw_spin_lock_irqsave+0x39/0x60
>   spin_lock_irqsave_ssp_contention+0x54/0x90
>   srcu_gp_start_if_needed+0x2a7/0x490
>   bpf_selem_unlink+0x24b/0x590
>   bpf_task_storage_delete+0x3a/0x90
>   bpf_prog_3b623b4be76cfb86_scx_pmu_task_fini+0x26/0x2a
>   bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
>   bpf__sched_ext_ops_exit_task+0x4b/0xa7

I think the better way to handle this is making sure bpf operations that we
may need are safe while holding rq lock. After all, we need to be able to
use them while holding rq lock. It doens't make a lot of sense for exit to
disallow that.

Thanks.

-- 
tejun
