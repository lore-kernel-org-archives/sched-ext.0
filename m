Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304C42B302;
	Wed, 22 Jul 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763360; cv=none; b=H39bY6/phvUwLpHoORO1xGSWaIS1KBVy6Z6glxef9jdFxizHTERMeKi5VKcnoMg73+h91FSQHHN3L2Z981ZCzji9J/jqbFiPB4t2SbUxcPNMtwTCKutGQPzvbgBd9Pz7XMVaa8+vyDVt6xhf1q2NoWDkOlYNQibKoqdBGotatHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763360; c=relaxed/simple;
	bh=YlarVevAo+uWrY/ZOnlRyoKvqcrNBn1X+y9g2785qVE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=Pdm1Eb3gOh5L8SVApxEIITLUKoFHRA42TThKNJFf18w3YURZc+M/EaaS2fm9Wvqfo3B/EF2QYP2LRFQ/XHYgIdrJ37It1gvUtpL8TRH9V6/GF+v17Q2GhKLsg2n/ehipwQtq2DZzUfUKcncubq2ywFxs9XaAE/aGvU2Z3toWd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtZrYpLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtZrYpLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE8B1F00A3A;
	Wed, 22 Jul 2026 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763356;
	bh=MPLK4QVzhzk0+2Tc08rF8A2In3EQ/450JlquzuL219Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtZrYpLaYNfiUbc9jrPN8fV5IxE/BnHR5HzIPUs7v5XQ9ZY2yEw6Z9oE8RpSc9OdW
	 m4VhVHjJqIjQGY/21Cd+WQFibmoQ3UOdaNykZkBDG+Oy/eE4wNQKM8tS/6smtQ/STM
	 OkbMJCLGOKYkRv5l3rTa1C97OvlgM3SMgdD+j2FzT4cD4Njd517LYqVS95V4Btpfch
	 Trrb/1B+GjwFN1yxdwY3yuWEBhJIzkRGdIzwISSV15dTmPvH4Ysm/GkagN7UgRfsWO
	 CpugG6VaPDWorRfH6LwaR//XRV9+arg/MD/XH7PQkvj+hFQyA2ghQXRXEWDxISQWbs
	 DuFRijqxMb7lg==
Message-ID: <636d9a310fb5869765f59abed982befc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Wed, 22 Jul 2026 13:26:03 -1000
In-Reply-To: <20260721063242.552774-6-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 21, 2026 at 08:31:26AM +0200, Andrea Righi wrote:
>  	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
>  	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
>
> +	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
> +
>  	/*
>  	 * Bits 8 to 10 are used to carry task state:

Please drop the blank line above the new entry.

> +	if (task_current(rq, p) &&
> +	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {

The condition fits on one line, ditto the one in put_prev_task_scx().

Thanks.

-- 
tejun
