Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F194973A1;
	Thu, 17 Sep 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673248; cv=none; b=kH9YiHD/S/p119H6drd99U042G//orVdJH6/CWs6Nakz1184CoWfS4e/awkUEOzTjmgS5GlEK3ybil6t/k87kQD4Cn47Bja1OVllyVmF5Ct6flnlZeGROU92tMZo808O/6sGjgoWJQ9PAOe8Lwog/tvFCt/hQq3zNxilgrjcHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673248; c=relaxed/simple;
	bh=uWrpmNCRG5orOrulIwgqxIu755S+X3Hecv/1HJiU6v0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMOna2tWvPOE+9Y3Pw9xBWr8ohhWvd3+THYijuup9viHDFVmjZAATxxV3H6yWr0GPwuvtOI0Q2Uf7AjdfX1qV4x1DfVynS8mcADG1+vyTEZ4NHBN4+BLWZ3yPlgpS2yFG0YKY1J8X/75IgxmzNHdqrFwYSgQ7qhbK5wQo2SA4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/9HVY6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/9HVY6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3925B1F000FF;
	Thu, 17 Sep 2026 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673246;
	bh=ZU8vv+L469PVezKfBdNND8pt+lLWBl0jSPiy1UOkObA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/9HVY6AzomSzvPLakh7L9iV+vGU3aSruCanxcJSyHaBoXBRXgKwQy0uFUiDOE3VG
	 pqDoCiHiwuYv0AdWJ0x/f0YtMyAU3zVgWIvI29WxeycLgFbhB/0dZxyZCilCO0ulob
	 qZ9FESZfVoB4C2lCNb5TqNkm8wbbiK9iwt3nmqBa4fXLtPr6EFVDdyghxXz4RBmnby
	 AHTUFrQWpvvkWhtnAgi/fOXxPAsqwuE2rOYx1jloNVqvmTNqHAWsepkDNHZ7MeAul5
	 3f/hyFMoS46IdutZ7KKAViF8rntJCrWnCPnWrRCpU16h8RwmSEllUfsiYzuR/UK3ml
	 k8xwX7cfMQkxw==
Message-ID: <05995f56a36bf6285f738dafdcc63785@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Date: Thu, 17 Sep 2026 09:19:07 -1000
In-Reply-To: <20260917070751.3617935-2-arighi@nvidia.com>
References: <20260917070751.3617935-1-arighi@nvidia.com>
 <20260917070751.3617935-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Andrea.

Looks good overall. A few things:

On Thu, Sep 17, 2026 at 09:02:52AM +0200, Andrea Righi wrote:
> +		/*
> +		 * kick_one_cpu() clears the lazy bit of every cpu it visited
> +		 * above; visit the remaining requests which contain lazy
> +		 * preemption, see scx_kick_cpu().
> +		 */
> +		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
> +			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);

Can this fold into the loop above with for_each_cpu_or()? As is, a
lazy-only target keeps its cpus_to_kick_if_idle bit and gets locked a second
time by the idle loop.

> +__bpf_kfunc bool scx_bpf_task_set_slice_expiry(struct task_struct *p, bool lazy,
> +					       const struct bpf_prog_aux *aux)

The name reads a bit like it turns slice expiry on and off. Maybe something
like scx_bpf_task_set_lazy_resched(), with the ops flag and the task field
named to match?

> +	if (unlikely(flags & ~(SCX_KICK_IDLE | SCX_KICK_PREEMPT | SCX_KICK_WAIT |
> +			       SCX_KICK_PREEMPT_LAZY))) {
> +		scx_error(sch, "invalid kick flags 0x%llx", flags);
> +		return;
> +	}

Maybe add an enum with all the valid bits and test against that?

> +	if (unlikely((flags & SCX_KICK_IDLE) &&
> +		     (flags & (SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY | SCX_KICK_WAIT)))) {
> +		scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
> +		return;
> +	}

Does this need to move out of the IDLE branch? It's two tests on IDLE instead
of one, and as scx_error() aborts the scheduler anyway, the early return
doesn't buy much.

> +	 * ops.enable(), after which scx_bpf_task_set_slice_expiry() may override
> +	 * it per task.
> +	 * A task in user space still reschedules on the way back from the tick; a

Can you add a blank line between the paragraphs?

> + * compatibility wrapper is a no-op when the kfunc is unavailable. As with the
> + * setters above, discard the kfunc's authority result for consistency.
> + *
> + * Keep the wrapper until pre-v7.4 kernels fall out of the sched_ext scheduler
> + * support window.
> + */

Just noting the version it was added in is enough.

Thanks.

-- 
tejun
