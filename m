Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFE2D9EE4;
	Fri, 28 Nov 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328903; cv=none; b=e2EOVX6XV4Wg431DOHPCHoXkRQca922wR0oRbQebFQ/3TmQow6cUNKEQ7kexN4dTjMW6kAz0STBGZaDjAse4h6lhjvr6sEqCmw/6H/8DqQ+v6IxuhANo7XqtUtQw6CYLnwyGECfffRaDUbf/pbC7kWdzGiSnrGa3wArCB01Skpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328903; c=relaxed/simple;
	bh=Pe/w5fIkomXLlYUxdwIWB9N8gjqlm+UGqdblR7i9s4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUdc8lhEnz9rIG8q7t4jQ6cTv+S/frYsvA399pgM3AHbT7KkLK0BMf4hkPORc4fWK9W6kTgYRWxgJdmS4gMca+y7HsuSfZ9YUo/j9m6Z3m/L2Q62mw0e5upNXCLLsxL0Dl7QNAv/hDWhbrarHuitBmHQhtlkkUEEC6mCv6RdmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxgDqAOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxgDqAOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCACC4CEF1;
	Fri, 28 Nov 2025 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764328902;
	bh=Pe/w5fIkomXLlYUxdwIWB9N8gjqlm+UGqdblR7i9s4w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OxgDqAOeMANftGiCy06tRIYOEBWzv1ljMEvi4X4E4c9yz99h100syKV+1kEsqw/Nx
	 pidrbJsUv2yC5hbhhQuENs8s+x5z/P+x7mBwvLeGfxxeb3D5RmzWNrCSnr69RksK/d
	 4G0bVlv67qi0fM2OnweAN2EVujp+DoLTh+raBjVpPezYjvjCSRM5pBftukYeCUEdys
	 M0am+1FY6KGbgT1pdZ+4D7A0MF252h/DWwIEEmUn7/vmElXbnpgubaoNHHFXxpKUdN
	 e8742RBj45VSKH81Hum/RTz4+JMdUDijMGwZJ+CA248wO76z5RaRjuF/Nds/mM5F+Y
	 2dQcxFLKzO3rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAE11CE0BA5; Fri, 28 Nov 2025 03:21:41 -0800 (PST)
Date: Fri, 28 Nov 2025 03:21:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/5] sched: Change rcu_dereference_check_sched_domain()
 to rcu-sched
Message-ID: <87d98b6e-b534-408a-bd27-0610de0e81f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251127153943.696191429@infradead.org>
 <20251127154725.647502625@infradead.org>
 <20251128105723.GZ4067720@noisy.programming.kicks-ass.net>
 <20251128110416.GR4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128110416.GR4068168@noisy.programming.kicks-ass.net>

On Fri, Nov 28, 2025 at 12:04:16PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 28, 2025 at 11:57:23AM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 27, 2025 at 04:39:46PM +0100, Peter Zijlstra wrote:
> > > By changing rcu_dereference_check_sched_domain() to use
> > > rcu_dereference_sched_check() it also considers preempt_disable() to
> > > be equivalent to rcu_read_lock().
> > > 
> > > Since rcu fully implies rcu_sched this has absolutely no change in
> > > behaviour, but it does allow removing a bunch of otherwise redundant
> > > rcu_read_lock() noise.
> > 
> > This goes sideways with NUMABALANCING=y, it needs a little more. I'll
> > have a poke.
> 
> Bah, so I overlooked that rcu_dereference_sched() checks
> rcu_sched_lock_map while rcu_dereference() checks rcu_lock_map.
> 
> Paul, with RCU being unified, how much sense does it make that the rcu
> validation stuff is still fully separated?
> 
> Case at hand, I'm trying to remove a bunch of
> rcu_read_lock()/rcu_read_unlock() noise from deep inside the scheduler
> where I know IRQs are disabled.
> 
> But the rcu checking thing is still living in the separated universe and
> giving me pain.

Would rcu_dereference_all_check() do what you need?  It is happy with an
online CPU that RCU is watching as long as either preemption is disabled
(which includes IRQs being disabled) or any/all of rcu_read_lock(),
rcu_read_lock_bh(), and rcu_read_lock_sched().

							Thanx, Paul
