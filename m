Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F9EEC0;
	Wed,  3 Sep 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936158; cv=none; b=QMe0NMsBJTpm5LTlMjkTJJ9Mi8SnvBS1O4ATw5IFBiNZEzLeFYnbqMtdFewOXUW9CgUqegaB8/Gy6c6pR8fQJ6HC2uDQrXCtathYOw9tlfM+fFfs4sA0PnQ3C9HSy7NTyN7INiR3+HuDIfWymofFC2r7h0b8wNJTD7OJaOMspmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936158; c=relaxed/simple;
	bh=6VfzY2+4HUpKgBaTRWzWc5N0wydqIEyHeC8AdzLrFk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKWgSpm7y5zVnja9bRwWlykNzPJJOFbR6DXJUigFj8h0iZPx2i3AAJhGuT1sStI8KekTTe951EipD/FAys1krustgrKpiNjUdEyAkzOsYl1j+qdXgwKc7cC0AB3c43ylqy8iQijY8A2Wr99DqUebP1ZguECRTTqN9EzTFx6zzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyx4HTN5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyx4HTN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F22CC4CEE7;
	Wed,  3 Sep 2025 21:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936156;
	bh=6VfzY2+4HUpKgBaTRWzWc5N0wydqIEyHeC8AdzLrFk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyx4HTN5B0KuZovgTz9jxao4cwlwBM63PFxtuNokkr/d5qjEQO6NGE6CLW//Uk/0u
	 Q4k3G3x1ibwKcfiGPVUPxxgwBLrbjAMOvi3dmL1LrpLHIo3lBnvbXfRh1JUJKY3qk4
	 L6JSwQ7bkneS7zpq/UK50P/E3U/S+iVZe8S9A5mDtsX69ebX/+X4s4MKF91HWIvXN2
	 bo7Ytq01XJ2O+hx+t/aIUzdtnw8kmCtSMjEmcHGkqbWYWTSsihb8CaEmN1lW6abq9h
	 ecKkygu4mQwMbwc81WRXQg+UR85BLwkVy8QfmZs2Mk3/UJvwAc/ajBJssZGKTDbd8p
	 A8r1UjkLywOnA==
Date: Wed, 3 Sep 2025 11:49:15 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <aLi32yr7rh1MbyLj@slm.duckdns.org>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLeANmpO03QiPgSX@slm.duckdns.org>

On Tue, Sep 02, 2025 at 01:39:34PM -1000, Tejun Heo wrote:
> SCX hooks into CPU cgroup controller operations and read-locks
> scx_cgroup_rwsem to exclude them while enabling and disable schedulers.
> While this works, it's unnecessarily complicated given that
> cgroup_[un]lock() are available and thus the cgroup operations can be locked
> out that way.
> 
> Drop scx_cgroup_rwsem locking from the tg on/offline and cgroup [can_]attach
> operations. Instead, grab cgroup_lock() from scx_cgroup_lock(). Drop
> scx_cgroup_finish_attach() which is no longer necessary. Drop the now
> unnecessary rcu locking and css ref bumping in scx_cgroup_init() and
> scx_cgroup_exit().
> 
> As scx_cgroup_set_weight/bandwidth() paths aren't protected by
> cgroup_lock(), rename scx_cgroup_rwsem to scx_cgroup_ops_rwsem and retain
> the locking there.
> 
> This is overall simpler and will also allow enable/disable paths to
> synchronize against cgroup changes independent of the CPU controller.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun
