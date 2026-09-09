Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7551E448
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950650; cv=none; b=sEj0AemTZaplo1Jr2XEbpQP89ZKUvr5H0UTWwyJHS0IJahtWNkn6tFRr4eN5+paiTAFeCby2xvDZCVQUf4XM3maAZ4SmR0sIgC/Ac3Q4Ue2l4h2fckVq3AHlAYJA+TypOw9gNa6UoBmmU3gRaWfqX7YBZWprf0wY9EVILXtdWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950650; c=relaxed/simple;
	bh=9z/dXL45Sap2EQCGlLPR1tXKHotZpfSHIF6xtM8pA68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZlOVnKKF5CrhBaV1S+Z6BfEKEv9l9frXpxuxUvtOgelH3HChk8HX553SzUHYzQPaZKWbwI9B88gYKz/uVXHXCRQX580BtjpK1tPasj8Y+FjP0GxTmMzAbs7SJ4UnZ8Tbdm/xB9NkEubaj6a6iDQnZ1dquklzO79WgDkHk8OvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c+VL7Ajg; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c+VL7Ajg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cS
	hVqMclSDJnq0xWrDNghDgQjiZqExxEEaxs0dPNIxU=; b=c+VL7Ajg6BtssggmSY
	CBCMTVziSciXm1u0D8pBAd6zM+xo6hOdWXcDNO7m6+h1myOoGitpnzy0j51Lwf2d
	/PBRI5J92sjzI+t5N6H6C0za9O/LT45X+uO0f3LkZAGyyS7I2wrnb56E9IfVnURl
	93k2ICh6+eXc6ZSSyn1KtjPdQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnc94rOKFq4TXEBg--.61422S2;
	Wed, 09 Sep 2026 18:42:52 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: sh_def@163.com
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	connoro@google.com,
	dietmar.eggemann@arm.com,
	jstultz@google.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tim.c.chen@linux.intel.com,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yu.c.chen@intel.com
Subject: Re: [PATCH v4 1/5] sched: Dispatch task ticks for donor and execution classes
Date: Wed,  9 Sep 2026 19:42:51 +0900
Message-ID: <20260909104251.3131056-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909092901.2989564-2-sh_def@163.com>
References: <20260909092901.2989564-2-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnc94rOKFq4TXEBg--.61422S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UCFyfZr4fuF1Utr15CFg_yoW8tw4DpF
	ZI93WUZ3yktFWagr1Duw4kX3WfAr4fJF1UGrs8ArW8Cry5Xry8Krsavr1YyFyrZr1vkFnF
	vws093yfAw1DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR20PsUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6Q0ce2qhOC3+VQAA32

On Tue, Sep 09, 2026, Sashiko AI review wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> - ## [High] Infinite timeslice and preemption bypass during SCX proxy
>   execution due to a mismatch between slice decrement (execution context)
>   and slice checking (scheduling context).
>
> commit ff57ff4a11692a1b0d98a6cd57257eb58a1bd864
> Author: Hui Su <sh_def@163.com>
>
> Does this cause an infinite timeslice for SCX tasks during proxy execution?
>
> When an SCX task acts as a donor in proxy execution, task_tick_scx() sets
> curr to rq->donor. However, update_curr_scx() applies the slice decrement
> to the execution context (rq->curr):
>
> static void update_curr_scx(struct rq *rq)
> {
>         struct task_struct *curr = rq->curr;
>         ...
>         if (curr->scx.slice != SCX_SLICE_INF)
>                 curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
>         ...
> }
>
> Later in task_tick_scx(), the slice check is performed against the donor
> task which was never decremented:
>
>         if (!curr->scx.slice)
>                 resched_curr(rq);
>
> Since the donor's slice doesn't decrease, it will never hit zero, meaning
> resched_curr(rq) is bypassed indefinitely.
>
> Additionally, if the proxy task is SCX but the donor is not,
> task_tick_scx() returns early here because the donor is not an SCX task,
> skipping the SCX tick processing completely. Should the slice management
> be explicitly tied to the execution context rather than the donor?
>
> --
> Sashiko AI review

Thanks for the report.

This configuration is currently unreachable. CONFIG_SCHED_PROXY_EXEC
depends on !SCHED_CLASS_EXT, so sched_ext and proxy execution cannot be
enabled together.

When CONFIG_SCHED_CLASS_EXT=y, proxy execution is disabled and rq->donor
and rq->curr alias the same task. Therefore task_tick_scx() using
rq->donor and update_curr_scx() using rq->curr still operate on the same
task, and the slice decrement and check cannot diverge.

The sched_ext change in this patch only adapts it to the new task_tick()
interface for the currently supported configuration.

If sched_ext and proxy execution are made compatible in the future, the
SCX donor/execution-context ownership will need to be handled as part of
that integration.

Thanks,
Hui

