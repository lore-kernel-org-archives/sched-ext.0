Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6137F8C0;
	Mon, 31 Aug 2026 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215822; cv=none; b=dE/fuXOK/lJM5yYo7Lt3X1wbhsttqoQ/e0TMEaQV472WJ+zjpk5wjzE7514aaiRN/2ROdu3xRDHBhAUnmIZirf4bt31OwHC4NmN5gDSnHmmpu65jQcWhTJWyObu9U7ere9yg1T5/uGIR2fxnH1WewlUxLop9u8yh/6NCLCj/ghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215822; c=relaxed/simple;
	bh=3l45UewGTArFY7R0otFgqfdF/MH4fqTqo7JMz+paUgc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iJOQpM4TzKaymFSTIGiVt5rA2Q3mxoI5RzZy8sigAGuo8Y3M2evbrRqdihjk1wWOo/6aUtIJSqwzmhFy8b54st00XnEL+QVekrw/toyrdSsPmByzf2PxmX6XBbKBF75+tdDhoeWl+JePct7pxnn3gzVrK83Jy917DjuyD7w/EeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLthFoQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLthFoQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587491F000E9;
	Mon, 31 Aug 2026 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215821;
	bh=dVaXS8IcVxjbTGjuXabSn/O3W2NtZJAOhEqor1sSXvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NLthFoQbjbnT6rOb2qB1GItSCTgTVkunejfgO1DkjKiM+um51c/ku4GoRGWuyHW+E
	 VQAJUtItlroa7LKQG85raDETfl2wuk/o3GmPL2qo69Cw+5bEmxMiv3WLMgqx3yUYfM
	 btZIU6rIbn6Xch+q1xkTsXF0c/aDqdmTchhZGk/cn3RAlp8b6oN7ZdjtLFryh4dAOs
	 i3qjn7HU249Is7DrjNXPcbcwE7n+qE9cvI73OUUKLDaptN/OPmpYpvZF/vlhypSCPv
	 LlOcWLBjbFSQIe8dq+ZEflsvlHCM2uxI4qv9mUc0uTGC3rCw85bBPiwYNCadHA28zA
	 lZSjrrr0lhqbw==
Date: Mon, 31 Aug 2026 12:37:00 -1000
Message-ID: <16ad7666875543a33b88609ea444fddc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tao Cui <cui.tao@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Serialize cgroup knob updates
In-Reply-To: <20260825092153.2602809-1-arighi@nvidia.com>
References: <20260825092153.2602809-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Aug 25, 2026 at 11:21:53AM +0200, Andrea Righi wrote:
> Concurrent cgroup knob writes update the core scheduler under its
> internal locks and notify sched_ext only after those locks are released.

This is the same race Michal's patch fixes by lifting the fair locking
into the core write handlers so that both updates run under the same
lock:

  http://lkml.kernel.org/r/20260824074913.2468177-1-michalblk@google.com

I'm inclined to go with that one.

Thanks.

--
tejun
