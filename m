Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427225;
	b=WzfN9e0L+kILdDEgaeb2/yuxQdo02Oa33hL3JDNTo6kJwto+1NDmn0q2U5zU3tV7YlJR
	 ZBHi2DewgmjfhlYMIWkx0tFZZPetCylHb/abQe+RiJUqL4M5tmnwqsJxxEsc1KJaFk9Vn
	 sK1ZSy44Ut4TBVUh++undhsmsoiEYYtzjlidFDErI7QVQ3UQ3FAh9o7g0kbJsJBGEMUEn
	 nGh+EKxrncFVCpclO7fgGNVSlNQXeJ2Y/vcUalYT/7LChaJl/C3ZEYhh0cq5OioMcTUSD
	 tTs/O3p8PL6dlQqdf+JUpZs+Oh7cx4AV+0JPrPPh4AtgmnN+uhqu4lxQyZnaSp6Zudg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427225;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Go0wWTllLEIEJ6ZEgvkz1cSjEd8RgQ1WqTm09FEcOEs=;
	b=2gKVwYwF8/GQsp3osJyD5QkzhaEzrjuO/b1AB9cBhH1Kg6TMxADI+BagkUJsMxZCjIq8
	 AfrZNOwDoVWnZenn2YyX4nMl1RfFYziBPSynCI4T4CrQT/CrLtrl5XGvfEnKjWeJFR4rq
	 uEZ2C8tZxWsoiIUMn2pEWEfShnOsRktqFkrPbPlEmuTZb1kTO0SvNZHe+/jvXy+NJFMM+
	 S8BbFmzBSAl9QUZloW8w3ojdtBRpvevQJIf/3zQrPVCL1f40URxlu3iS+/2ZTZ4NYK/zg
	 sN1jaPDn67Sgu74Y5XlTfUlKgIZLyi1AxXRSC7aGqz2v57xstqUqkhqkiIWBh+zoavg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/aonMuS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65D606A31A;
	Mon, 23 Nov 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/aonMuS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB311F000C0;
	Mon, 23 Nov 2026 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795427225;
	bh=Go0wWTllLEIEJ6ZEgvkz1cSjEd8RgQ1WqTm09FEcOEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/aonMuShRKr6r2WVcyLdU7yBqe4biAoWbUh/ZFWMqTaYJek/GFjqLpcmrURqpyXC
	 /Tdd2mKmOH4H5JsMBF6rJqa/+m3XpBgSKu7U4yqHwDBEvDjiefD8K6iIsZzDNQdmiA
	 R/QBprAqLufGEMRoPhxoYRPrLyS74n9CZxzFvf5DabbYxF5oqUMMTF2zhT8ksGBK57
	 Xr5RPziInI1t4OU0zJ4Dj8CWr0Bl/j167uqJRfYZzzZd4eZ8fLKV3M9rdrAWUrNPoO
	 UqXF0GJzTo8hdxXBnOmPN+2NJkjAEwh3ws1hvOSjWy/WMCYiReyLu7jLkm50uN7jL/
	 OnmBuU+nBDheA==
Date: Sun, 22 Nov 2026 23:47:04 -1000
Message-ID: <06baa96f105bbe10e6283e908f1240cb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Huang <penghuang@google.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, haoluo@google.com, brho@google.com, joshdon@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Update other_load_avgs on set_next_task_scx and idle entry
In-Reply-To: <20261122062121.4172437-1-penghuang@google.com>
References: <20261122033316.2819845-1-penghuang@google.com> <20261122062121.4172437-1-penghuang@google.com>
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

Hello, Peng.

On Sat, Nov 21, 2026 at 10:21:21PM -0800, Peng Huang wrote:
> If SCX_RQ_CAN_STOP_TICK stays unchanged (e.g., remaining set across an
> idle or RT interval on tickless CPUs, or remaining clear on finite-slice
> switches before a tick fires), or when an SCX task goes idle after an
> RT/DL interval without an intervening tick, stale RT/DL PELT values
> can remain elevated when consumers such as effective_cpu_util() or
> update_idle_rq_clock_pelt() read them.

I think this overstates the staleness. While the tick is running,
scx_tick() updates them on every tick, so they're at most a tick old,
at idle entry too. That's already a lot more often than fair, which
updates them at load balancing intervals.

> Refresh update_other_load_avgs() once at the entry of set_next_task_scx()
> (before SNT_REPICK early return and before ops.running() for SNT_PICK /
> SNT_NORMAL), and in put_prev_task_scx() when transitioning to the idle
> class.

update_other_load_avgs() isn't necessarily cheap and I don't think we
want to call it from scheduling hot paths. If anything, sched_ext is
already updating them too often and we should pace it down.

The actual hole is CPUs with the tick stopped, where nothing updates
them, and this patch doesn't address that.

Also, how was this tested? Is this from reading the code, or was the
effect observed or tested in some way?

Thanks.

--
tejun
