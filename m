Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FB2459CF;
	Sat, 17 Oct 2026 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277086; cv=none; b=eiWrSJGcsNalaPaP8tJipWBJOauK6DRRZHWPqHiwJGT/YzaCM+xy3fO4+YooopeiP73vV3uoJjDiIchB9VAryseb3msk4kKzZt/sIrz+tL70DWJe4hucolE0mYDnSU4+4eb86E+4sSHIBUix9WR4fN6w3aXmz2QSbNLAEykPYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277086; c=relaxed/simple;
	bh=dD4b238PBn07YHaR3VCCp1FsnT68zTa7nqbQg5cgLOg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=f+KnOW5saQZUTzEQCgUPGUavYdhpqhSFp7vmErVkxJnBAD4J6f0y0w/V5nNiHRbBGFRNZ0e1ZCPWF213RQpV2C/jH2AIs5Cm6UfDazEQmjPCi9DJ9UsPR2q/LGts13Iy6TPix4mq5AsOiO6m//LsJnniSjS5OUo2NFWL6RImOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5bVqqbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5bVqqbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C443E1F000C4;
	Sat, 17 Oct 2026 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792277085;
	bh=llUeqWeAf2fTw3SYwI85VAm5RV/+BVG3bCskLQm+OuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U5bVqqbSDj+DkFYOunElaqbVna+dL1jbJyvhIgo6CJqcPObSV8oTo6kMlMeqeG8SE
	 u0DXJ9HncN/Lc/2bAnvLLREW/a0/blTAiAzH8kts3G17nBJ4QmG1lOKCVmnoIFA/Om
	 dn98FCammPcwUEuKQ/jXmyzGFXkC1pLQKJZNVDgPCbdP8YLvflGZD7ACI55uru2PI3
	 WRWZTPcPa4KvhB8QabXIUYRQ3MS4BfyilsFsjBmtW+kAnNsJydMQ/o/ytyPvDHBS/Q
	 +lYxuz4f7pkl4uAtqFTXkKMXXUHvamDWHMNhPq6+JAfcQKbcS+bOlqn/jfh2ufu6tG
	 zeM1yXZcMGGpQ==
Date: Sat, 17 Oct 2026 12:44:43 -1000
Message-ID: <feaffac58ebad408885c8adae931ab27@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Don't leave the kick_sync wait queued across a core-sched pick
In-Reply-To: <20261017202025.3834954-3-arighi@nvidia.com>
References: <20261017202025.3834954-1-arighi@nvidia.com>
 <20261017202025.3834954-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sat, Oct 17, 2026 at 10:05:15PM +0200, Andrea Righi wrote:
> +	kick_sync_queued = dequeue_balance_callback(this_rq, &this_rq->scx.kick_sync_bal_cb);

Instead of taking the callback off around each dispatch, can we queue it
from set_next_task_scx() on SNT_PICK and SNT_REPICK?
put_prev_set_next_task() calls it once the pick is final, after the
core-wide selection, so the rq lock can't be dropped with the callback
queued. If the CPU ends up running idle or a higher class task, no SCX task
runs there and there's nothing to wait for. kick_sync_pending stays set and
the next pick of an SCX task waits before running it.

SNT_REPICK came with c72945693b90 ("sched: Restart fair hrtick after
same-task repicks"), which is only in for-7.4, so let's do this there and
tag it as a stable dependency:

  Cc: stable@vger.kernel.org # v7.0+: c72945693b90: sched: Restart fair hrtick after same-task repicks
  Cc: stable@vger.kernel.org # v7.0+

Also, proxy exec on for-7.4 zaps balance callbacks and picks again when
find_proxy_task() fails, so kick_sync_pending should be cleared when the
callback runs rather than when it's queued.

Thanks.

--
tejun
