Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DE4CF461;
	Sat, 17 Oct 2026 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792269381; cv=none; b=ojGbPOddYBPOgXkp5RPKOqszKBEMPeKtIMjW+hCYj/D935IUNE0btlvyUabxZlxulg1uIOQRawChXIHenenlESRvXdPNLunn/y0F6ce4vpCjT8oF6MJF5XDINP1lPPr0TEK2sEjnsv8+JH5S8C5TN3U6hHBMdj+dDQWzAg9Fc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792269381; c=relaxed/simple;
	bh=JTUSpkxPgZaeYJXMLaLtVi/ac7o6w8I9BhgrFfbtO5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hbg4y9WQ/HepG65q4Icv96C9700nuMbA7UuQHgU6eUAkjLdY5u8+6R7VQAfn8PzhiH+GuGkW6+6C53yoWDQpX4/9oFCV70vGEIPwYAXqzPq/5G6qG9G1S9nMWCIhaTtbTGCcZkuyYk/E4zNjM8TZ6sc/hEiy8rQtuour4ey6E9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Ov2Jnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Ov2Jnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D41F000C4;
	Sat, 17 Oct 2026 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792269380;
	bh=9KH4qgSKtovAEig+paoqKFYdUfApc0kP116Lhit2lwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f9Ov2JnxjVwVSvnWdQVKfMh4ly6bTAi4NVATWRF/6+LiTaLaHi1LwV9sZEtD5ZszE
	 jz0D23nPEQZConeUQUDXUFQVQNrKpdChqC3LntnAKcTNPR/ao3hC4QkcCpUdlmbDRK
	 hXeuGVCaVCocR/W891BclgYj1/LS96QfR0Q8LqHbwR8zMqK5eLz/AdxjoBbglljIFJ
	 03hY7WLJuavQa5MQuxXwMKCJBTnlRJocR2K6+HrUqXkt6qOd6E04bM1aYMwnYtpEtg
	 KzffxwTjkQdn7L4MS83egRJLY1m5O+r1S8McaX3Hfzq8bgMl89xZhTt258MsfaCtGw
	 Q2QQ6uVfwWPkA==
Date: Sat, 17 Oct 2026 10:36:19 -1000
Message-ID: <49d76a6ae49b2e0d5359edc831ffaf60@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't report a forced-idle CPU as open for IMMED tasks
In-Reply-To: <20261017124749.3608468-1-arighi@nvidia.com>
References: <20261017124749.3608468-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sat, Oct 17, 2026 at 02:47:49PM +0200, Andrea Righi wrote:
> +static bool higher_class_runnable(struct rq *rq)
> +{
> +	if (sched_stop_runnable(rq))
> +		return true;
> +
> +	/* The ext server selects SCX tasks ahead of RT and fair tasks. */
> +	if (sched_dl_runnable(rq))
> +		return rb_first_cached(&rq->dl.root) != &rq->ext_server.rb_node;
> +
> +	return sched_rt_runnable(rq) || sched_fair_runnable(rq);
> +}

This duplicates the core pick order in sched_ext, the dl_server ordering
included, which is brittle. It also misses the case where the IMMED
task's own cookie forces the CPU idle, e.g. a tagged IMMED task while
the sibling runs an untagged RT task, as nothing above ext is runnable
on the CPU itself.

Instead of predicting the pick, how about reacting to it? A CPU picking
idle with IMMED tasks on its local DSQ means that they didn't run
immediately, whatever the reason. scx_update_idle() is already called on
every idle pick, from set_next_task_idle() on a task to idle switch and
from pick_task_idle() on an idle to idle re-pick, so maybe something
like the following in __scx_update_idle()?

	if (idle && unlikely(rq->scx.nr_immed))
		scx_schedule_reenq_local(rq, SCX_REENQ_...);

Outside forced idle, nr_immed should be zero there as pick_task_scx()
would have taken the local DSQ head. The reenq would need a flag telling
reenq_local() to skip rq_is_open(), as next_class is idle and the rq
would look open, keeping the IMMED task at the head.

Thanks.

--
tejun
