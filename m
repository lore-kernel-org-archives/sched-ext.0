Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EF184;
	Sat,  9 May 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288461; cv=none; b=pJ3n84ccWweMF4ytOpR8MpRfWLb1adujmyR2TSMpLzGM5yajAeRv68MEgsxEIvN+DpNyTSdmmiV754OwwqYiw1dy1xUn9DW8uFqFnrYsmGYavHGZAD4ZQEc48YKBryO1ueELbKiLvU1EEEZc4vW7rjJoK9sp0IqnNFfq+4ZZXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288461; c=relaxed/simple;
	bh=rpdTKe8+sH7M5vSrO/7KezKcg9DKmbgvxRaH6ajx6yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjl/PQTLBI231VRi5CB80Ejy7+oZd1H0Tat0wcQ04OQQRKjJMn9e1tToi5ZPlaDUIk0q8Lv4UNsHeB9SWV78s2j7p5RAeUpJceo5lJilSw6DMOHWDJHJAYAXT1kDHBH5838quMlyZSLLayrZGYo8PYqCepHtiJjKYNX93bQ1FH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJXETm9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJXETm9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BD1C2BCB0;
	Sat,  9 May 2026 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288460;
	bh=rpdTKe8+sH7M5vSrO/7KezKcg9DKmbgvxRaH6ajx6yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJXETm9tlzixz/GLr2haZzZTUVIHq67VME3HXh0iRFXHnWBhBp5rapsfo0/MUvUYx
	 Fp5/qMT6fcQWKaWg8WrB0bTiHYk8AgwtBy60qkC4mqIlKxmynYqasaWQZohnCyNXdK
	 KaAb1XJhuNRk+fcWgftOn2YP3DPkTBgp72uhZozUEydMOZvhIaOQvajMLdPC/ZTe6/
	 bQe4/1jjD2IR/5eHufKovjtyC4B10695R38xhOxxzqAqXJ6LwCHXvJRgJyuEOVP7K6
	 1/iGrj/4fnbRVuPLhL4SJQYudzC2WKISULBlpbMzear7GpiOLl+XxsG88tgHp0R72d
	 usqumglhsBwww==
From: Tejun Heo <tj@kernel.org>
To: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	jstultz@google.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	christian.loehle@arm.com,
	kobak@nvidia.com,
	joelagnelf@nvidia.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH sched_ext/for-7.2 0/10] sched: Make proxy execution compatible with sched_ext
Date: Fri,  8 May 2026 15:00:59 -1000
Message-ID: <20260509010059.345908-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm a bit worried this is more invasive than what it buys. Even with
the full series, the cross-CPU gap Prateek raised stays open -
find_proxy_task() doesn't go through put_prev_set_next_task(), so owner
runs without ops.running(owner). Closing that seems to need yet another
protocol on top, either synthetic running/stopping events or scx core
taking over dispatch_dequeue for substitutions. The BPF scheduler ends
up dispatching tasks it didn't pick and observing callbacks for tasks
it didn't enqueue, which feels too magical and error-prone.

Maybe worth considering an alternative where, when scx is loaded, we
just turn proxy-exec off entirely and expose blocked_on to the BPF
scheduler. Schedulers that want PI can implement it themselves on top
of the relationship; ones that don't pay nothing.

scx_enable could flip the proxy_exec static branch off, after which the
existing gates in __schedule keep blocked tasks off the runqueue and
skip find_proxy_task on their own. The remaining concern is in-flight
donors at the moment of the flip - the existing scx_bypass walk already
visits every rq's runnable list during enable, and could force-block
any task it sees with blocked_on set. Mutex unlock would re-wake them
through wake_q normally after that. blocked_on itself is set and
cleared in mutex.c regardless of proxy_exec, so the signal we'd want
to surface is already there.

For the BPF side, the natural shape seems to be tagging the existing
ops.quiescent and ops.runnable callbacks with a bit indicating "this
sleep/wake was a mutex transition," plus a small kfunc that returns
the owner of the mutex p is blocked on. A scheduler that wants PI then
records the owner in its own task storage on the quiescent side, boosts
it via the existing vtime / slice / dsq_move / kick primitives, and
drops the boost when the runnable side fires. No new dispatch protocol,
the BPF scheduler stays in charge of who runs.

Does that direction seem reasonable, or am I missing something that
makes it not work?

Thanks.
--
tejun
