Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB8541E54;
	Tue, 29 Sep 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701991; cv=none; b=Mafmi903v/A7z3z7jaQI/8eEQ3cIal4ioqOzM3B6VUAzJGbfhYAQXMHV1UqrJ+UTKSSKs+jwI0OE0Dtj6AxurzoswHcc3eqxruFZ+UR9iZoVofdVvp92hsecQXMsdUqSSgSzNlnI4vB6jzb3Rvt5uu4nPlb6IScXctWvrmO9Hgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701991; c=relaxed/simple;
	bh=xFDKMr5DK2h91h03vW071U4vTKM8zAHo7FKLlN1bdTk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReV4CcXjYeKL2VqtD4zJscVWEJoOkSFS0YyB31B1IRbQppHyiKSez6pIlAuqRG28KXiRCBrVVJO8bCVbMGQX4hkboJ+J0jqRDJ5ycRZsV7LJSUVQ0BG+ZBDAYccvGJ8VR/J/xsLWcyZyvsnf1g/87EKGpnCNfnamh1hvMlGog+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpeHi8yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpeHi8yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB95D1F0089A;
	Tue, 29 Sep 2026 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790701988;
	bh=UEnBatGOjskBy0G7AdUJQlLIW3YPCRCXytYyANMQefo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TpeHi8yo/xP+Cn2Om4uBEDmdt6JKR1zwVMYdQhAIKqk8cN9ceW/TICRrh/BRchLHC
	 kX5HFawcRPPSnyj+zR+aJr4GlckqKdRtTM2/Og2hNeZpSRfnmP7z9DvpoDTY07S16L
	 91jJs8bmfR3kZ+b99vEH+3z4jDsdteJHumkGSztktShZDWckT2KEUbyYoL/dIS3n9I
	 VsHp+aM5pezdwLmu+ZuN/SIwPDuZh5NQVxkrnnKZg7+k8/R6KIlJrtL7A1fFkEuZd0
	 kkvdRI2Je/l8P/CitTF8lr4+usM3QO0bqAD9JDc/+SEyymmMQs/oLNFseT8YbvaTrl
	 e6g3nCFQVmEDQ==
Date: Tue, 29 Sep 2026 07:13:07 -1000
Message-ID: <46f4b66249f016b675fa16446b2f2f99@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix missing
 ops.dequeue() on remote local DSQ moves
In-Reply-To: <20260929161730.185271-1-jpiecuch@google.com>
References: <20260929161730.185271-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

On Tue, Sep 29, 2026 at 04:17:23PM +0000, Kuba Piecuch wrote:
> Since ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics"), every task
> entering the BPF scheduler's custody gets exactly one ops.dequeue() when
> it leaves it. A dispatch to a terminal DSQ ends custody with a flag-less
> ops.dequeue() at insertion time.

The fix looks good to me. It effectively reverts the enqueue_task_scx()
half of b75aaea24c9f ("sched_ext: Properly mark SCX-internal migrations
via sticky_cpu"), which as far as I can see only ever suppressed this
ops.dequeue(). Andrea, can you confirm?

- dequeue_remote.c isn't built until 3/3, so 1/3 can't be built or run.
  Can you put the fix first, followed by the test with its Makefile entry?

- 2/3: 7.1.y also needs 18d62044cda7 ("sched_ext: Preserve rq tracking
  across local DSQ dispatch"). Without it, the nested ops.dequeue() trips
  lockdep when ops.dispatch() uses scx_bpf_dsq_move() to another CPU's
  local DSQ. It's tagged for stable too, but maybe note it as a
  prerequisite?

- 2/3: With sub-scheds, scx_resolve_local_dsq() can divert the task to the
  reject or rescue DSQ, so "inserted into the local DSQ" in the comments
  isn't always accurate. Maybe "destination DSQ"? The new comment in
  enqueue_task_scx() could be two lines, and the description could lead
  with the late SCX_DEQ_CORE_SCHED_EXEC and be a lot shorter.

- 1/3: A task can only be picked straight out of custody through
  sched_core_find(), which only returns tasks with a core cookie. Checking
  p->core_cookie on SCX_DEQ_CORE_SCHED_EXEC would be exact and would
  remove core_sched_in_use() and the skip.

- 1/3: _SC_NPROCESSORS_ONLN ignores affinity. With the runner confined to
  one CPU, the test fails instead of skipping. sched_getaffinity() and
  CPU_COUNT()?

- 1/3: Nits. If the /proc scan stays, PR_SCHED_CORE_GET writes a u64, so
  the cookie should be u64. ops.dispatch() pops one entry per call, so a
  stale one idles the CPU until the next kick. Maybe loop a few times?
  missed_dequeue_cnt and core_sched_exec_dequeue_cnt aren't printed
  per-scenario like the other counters.

- 1/3: The variants, error conditions and core-sched caveat are repeated
  across the cover, description, file header and comments. Can you say
  each once? Also, single-line comments are usually lowercase in
  sched_ext.

Thanks.

--
tejun
