Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AD3BCD28;
	Thu, 24 Sep 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266678; cv=none; b=goGSAbkuq1L1gPUzVn2oS4JLBK1HDMdLEd2L0NCkf6VZJy+yq0XzXiAXRpQQezbXRt5Fcs2QZBXvXwj1QclQIdufWWwzHEbsS8rdS+Xj1BO+yett4bNqR5cO5JBiATKaShEe5MxeKCROEZgtmZ5IujB9tKYD7GySu4Zgn9gZS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266678; c=relaxed/simple;
	bh=cbzDchNdWQM9hVa5y6UYRuOhOBDnr3hYLi9J7JOKN+I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=oF5VlNfI9U0H+UEhenVGRx7udRXKAni6reoUgJlnrhjQHzJSXFNrjn3PQNdYxZEttyS4a6OAiSUarOzt5slbz6alUZqhxKDV4W0jrYDOgQxnzRrNTIBiLBTUiVd6BNHm7cnsfh8pMss5Z1DBUtb6F41gzITHvfU3SHDguGw02Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ9lK/qC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ9lK/qC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F931F000FF;
	Thu, 24 Sep 2026 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266677;
	bh=qYz1xOYVF9fEwCqg5xyOFO8RDNqr7m8sVlWc/qKZS8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RZ9lK/qC8Ng0Br6hGQwxVoQufNdchyJa7t32RjduNTBYweSrar19Edg5j5LsvDTZd
	 cCKUWsG95FHPtIMw9n2cr6yeEYSoYIVwMTCyaavluOSwbcRWMfEsCCvyabRAd8ilNk
	 Arx5YIVuUGG1BRliP3h6v4OWbkMkcgBytG8enrGa2WfxtJCAjDjGpNdcwspsXrJVQ8
	 zjOS7LGx8wBVMZPXN0zMJ4qwTJsLufKZjoXaMSNM+HA4DSo/MMNT4TUxt8+u7hq184
	 qPy/XvQe3DM8ZhWQyQIaNS0iLwAfvwJZCEX8kOECdFSbvtcEVRembasxZiFbp4CedO
	 kMWMZ0qUbAUeQ==
Date: Thu, 24 Sep 2026 06:17:55 -1000
Message-ID: <9c8dd70b66bba55c87376f227d986945@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/sched_ext: Fix three example scheduler bugs
In-Reply-To: <20260924143659.268595-1-liwanwu@kylinos.cn>
References: <20260924143659.268595-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Wanwu.

On Thu, Sep 24, 2026 at 10:36:56PM +0800, Wanwu Li wrote:
>  - try_dispatch() trusts a pid popped from a cgroup's FIFO.  If the
>    task migrated to another cgroup between enqueue and dispatch, it is
>    dispatched under the old cgroup's context, violating the core
>    "paired CPUs only run tasks from the same cgroup" invariant.

3/3 calls scx_bpf_task_cgroup() on a task from bpf_task_from_pid(). The
kfunc only accepts the tasks passed to the current op, so the scheduler
is disabled on its first dispatch:

  sched_ext: BPF scheduler "pair" enabled
  sched_ext: BPF scheduler "pair" disabled (runtime error)
  sched_ext: pair: called on a task not being operated on
     scx_bpf_task_cgroup+0x15b/0x160
     bpf__sched_ext_ops_dispatch+0x47/0xa3

This means the patches were posted without being run at all. That's not
acceptable. Please reproduce each bug and verify that the fix resolves it
before posting.

Thanks.

-- 
tejun
