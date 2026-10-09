Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08B381AF;
	Fri,  9 Oct 2026 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589339; cv=none; b=SNFFV58p8AyWWUFaWhxxsN7zk14o5i6n8zJTaSf8zXL60M94vPFMd58Wdqq1kvjQnfEcsjDQKV2iCBALM1WOO1vB9Kv7xqVrUDECjZM43EOfu/0ma/S/3gkSEyE6mat7ycaZ0rvMY3lZG8uar11uwSrItuEjmq+nKFSY1XFhFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589339; c=relaxed/simple;
	bh=Cp3a3Bidu4qsyTN/2DQeZ39pY1x22b1U8VrkcQEKNB8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj2YYZAj3MeluoJdtt8a6LRYD7lC1bBUD33LNdXMBechqZza4Urh4FmmC6Vv7xnXgTXHWcJ7UGI5ONYaLLtWQOIr7wL1PCmjJ4O2L9kSmK2MqTHltPjnQMK5exoQrQD8ciPkETwZ/1GszDSgllVpRzKeqWb4pXVxGSHSKC1qBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAVUR8G4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAVUR8G4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9039C1F000FF;
	Fri,  9 Oct 2026 23:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791589337;
	bh=egVVJEiBsRrkQFZa22HwLAELj6LN9A3YhSgg3tJz14I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NAVUR8G4cIs6tTv74CXx4nLpsDZaZ9z8xCJFJNEOVsmlcNMgQACKRN7PCcn8A86W8
	 3+Na+3HXkykWbygD5GpMa8fN2OwJEPrvD6FTBMQe+AnY3qeH+LmaWJ05rrOPIMXam8
	 UDaW+4zh/F+gHebYGnBVYwqfLGaZ+2xVbMmxLQgJQmPL9R/ykBUSAyh0lxEhcDuPQ4
	 UvY17V6SUgnxvqrpAPxPSHtXQMuLDXpF4hzSUD7bnm9vCo2M1NJscO+ZtXNkVZ93+8
	 yGU0N2i8XlayfZrf4/bPhpi7qO8BdN+LhcJzC/k+oZr0N8Zaav3RcSEHw/dJgzSDG5
	 HvxD7FaVIqZvg==
Date: Fri, 09 Oct 2026 13:42:16 -1000
Message-ID: <14824587e8eb436b2621fef1bb681cce@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: David Vernet <void@manifault.com>, sched-ext@lists.linux.dev, Andrea Righi <arighi@nvidia.com>, linux-kernel@vger.kernel.org, Changwoo Min <changwoo@igalia.com>
Subject: Re: [REPORT] sched_ext: sub-scheduler tasks are severely under-scheduled vs root-owned tasks
In-Reply-To: <3e044142-8f2c-45a2-8d5f-75d301526023@linux.dev>
References: <163e2397-0e3e-4cc0-842b-0d36598d13d7@linux.dev> <68208eef89abff9423de730ef585327f@kernel.org> <3e044142-8f2c-45a2-8d5f-75d301526023@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Tao.

The following is a Claude-generated analysis.

On Fri, Oct 09, 2026 at 09:51:35AM +0800, Tao Cui wrote:
> The scheduler is a single binary (scx_k2) with parent/root and
> child/sub modes. The parent grants SCX_CAP_PERF | SCX_CAP_ENQ_IMMED
> to the child over a cgroup, while the child only writes cpuperf
> target 1 from ops.tick(). Both schedulers print their counters every
> 2s.

Reproduced on for-7.4 with your sources in a 4 cpu VM. The starvation
comes from the two schedulers, not the kernel.

The child's ops.enqueue() inserts every task into its own user DSQ. The
only consumer of that DSQ is the child's ops.dispatch(), and a child's
dispatch runs only when its parent calls scx_bpf_sub_dispatch() from its
own ops.dispatch(). scx_k2's parent never does. See the comment above
enum scx_cap_flags in kernel/sched/ext/internal.h and how scx_qmap
dispatches its children. The SysRq-D dump during the stall shows the
spinner in the child's DSQ 0 with a full slice while cpu0 runs root
tasks.

> In an A/B test, having the parent kick the task's CPU from
> ops.enqueue() with scx_bpf_kick_cid() and hand its dispatch turn to
> the child with scx_bpf_sub_dispatch() prevents the starvation.

scx_bpf_sub_dispatch() is only callable from ops.dispatch(). With the
parent calling it there, the child's dispatch does run, but every
scx_bpf_dsq_move_to_local() is rejected because the grant lacks
SCX_CAP_ENQ. SCX_CAP_ENQ_IMMED only covers IMMED inserts. The task goes
to the reject DSQ and is reenqueued, SCX_EV_REENQ_REPEAT climbs on the
child, and it still starves. With the sub dispatch call and SCX_CAP_ENQ
granted as well, the spinner runs at full duty under the child.

> Actual: the child claims the task, and its ops.tick() initially
> services it, but setcnt then stops increasing and the task receives
> little or no CPU time - 0-91 ticks per 6s window across our runs,
> most rounds 0.

The initial burst is the bypass DSQ drained during attach. In the
move-after-attach order the task keeps running through dispatch's
keep-last path until something else wakes on cpu0 and pushes it through
the child's ops.enqueue(), which is why some windows look healthy. The
stall watchdog catches it past your 6s window:

  sched_ext: BPF sub-scheduler "k2" disabled (runnable task stall)
  sched_ext: k2: sh[1401] failed to run for 30.696s

> One possibility is that, on a NO_HZ idle CPU, no balance is
> triggered for the child's DSQ, so the child's ops.dispatch() is
> never called.

The parent's dispatch on cid 0 ran several times a second throughout
the stall. It only consumed the parent's own DSQ.

Thanks.

-- 
tejun
