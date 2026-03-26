Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082482F5328;
	Thu, 26 Mar 2026 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488587; cv=none; b=rve0cXXLcAgtM9M/4PhNX3tgfaoASNE5VePjD8aMsxw8+eYinZV1HsbSZ9BpkSSAjvPkdKRIndUGpnZMXgsLFV/e0NnjteOum1pT8doZdjnVIoPMvBld4o50i/ACZGRPFADz1FqBx5MwxOfxhP8U0Kl34g4/Tvdww3nQhCehc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488587; c=relaxed/simple;
	bh=4KHqH/W8croVRbjhJZadTMDwLJmHZZ2gW+L2KT1u3iE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CQKbWqjAOyTjdZzl1P5pEZG8xbY00BTYuVk5VVs9EN1RMZ/Z8ofgsU5ENPZFe0nc7tkZu3qdXZoTfU/px8gVPqgzVoTPNe44vShDGG0raXnx/QqMPSKKMUtIe9VI9Q1KjwfMwoz8QAoRvXcWGFlzfVgVgSfuWQUac/wkcLSvRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSsXY3gm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSsXY3gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941B5C2BC9E;
	Thu, 26 Mar 2026 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774488586;
	bh=4KHqH/W8croVRbjhJZadTMDwLJmHZZ2gW+L2KT1u3iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cSsXY3gm07QVbkPzEpOej6Liel7vttMOghizzbQExzVIAi5RRQoZ+1qrfXEJQ+v6j
	 3IGoKzev90pRQORmsDPhQwemlb1WSptnPnYk3TfGPDMwY21ch7lpCxvUAkHZtXqgGu
	 t4MafGm7uCq8ZP4Bd1dNjAEXPHShlRBY1YVk4iiFxnjSH0fcs8qutld5yPDK0Tnf31
	 oozHgD8XR6ZZIgrlHoNe8nymtZ2f0zKZ5v3FSgkEk+69jYruBNrJwZ6/vG2hbwuMtw
	 fvt/htNjFfHCk2Vzcas7quuzj35LE0Pje4+PReNUuWwHLH+4gY1KGOXoyp4e/TkY4U
	 Ei1aCR2Xq8cjA==
Date: Thu, 26 Mar 2026 10:29:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, David Vernet
 <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min
 <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 "Yury Norov [NVIDIA]" <yury.norov@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, Roman Kisel
 <romank@linux.microsoft.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] kernel: Use trace_call__##name() at guarded
 tracepoint call sites
Message-Id: <20260326102942.7a986c0c0bba5b732ba15b3d@kernel.org>
In-Reply-To: <20260323160052.17528-3-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
	<20260323160052.17528-3-vineeth@bitbyteword.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 12:00:21 -0400
"Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:

> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> ---
>  kernel/irq_work.c  | 2 +-
>  kernel/sched/ext.c | 2 +-
>  kernel/smp.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 73f7e1fd4ab4d..120fd7365fbe2 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -79,7 +79,7 @@ void __weak arch_irq_work_raise(void)
>  static __always_inline void irq_work_raise(struct irq_work *work)
>  {
>  	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())
> -		trace_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
> +		trace_call__ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
>  
>  	arch_irq_work_raise();
>  }
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1594987d637b0..cfbac9cf62f84 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4494,7 +4494,7 @@ static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
>  		vscnprintf(line_buf, sizeof(line_buf), fmt, args);
>  		va_end(args);
>  
> -		trace_sched_ext_dump(line_buf);
> +		trace_call__sched_ext_dump(line_buf);
>  	}
>  #endif
>  	/* @s may be zero sized and seq_buf triggers WARN if so */
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f349960f79cad..537cf1f461d75 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -394,7 +394,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
>  		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
>  			sched_ttwu_pending : csd->func;
>  
> -		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> +		trace_call__csd_queue_cpu(cpu, _RET_IP_, func, csd);
>  	}
>  
>  	/*
> -- 
> 2.53.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
