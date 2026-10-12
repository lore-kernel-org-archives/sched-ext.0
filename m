Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA03793A5
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849373; cv=none; b=rtO5rgerjP2doBZ9fJzKX8xrk6PlT7x6U4DAK+nd2hPyISBiK5EuEyA9Rq02nFTBeK8edRfUua2GO5DLm7eboIZz+J1QL24Ef5sjIxTiZr1JF5oesL7ECazjKtPLfkFtQ+SGojYFzoZuyclzL3M9Gi6A4hIaU+VeucVDB0fxMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849373; c=relaxed/simple;
	bh=WVAMV6f/CeUKFZ4ooBDbxXMCS+ig7UfmwMRreKgavKY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=T26mi4pwPstpFlnIRYKhjWEUl1a2RQPvk8ee4lj2QqjhaP5DggwNnKE6SVlSrtFTOJwdh/p9gZP6g8g88CgQf0tAqUTbOdY4nzGW/3ek4YCXmYxN5kMWsfvVnfyL/jAa3mARL2x/mxpsxl5N2AsTSDwzrgMEM+nOd+sMz65M+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU45mRqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU45mRqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652441F0089B;
	Mon, 12 Oct 2026 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849372;
	bh=tfa1MJOoD5iif44ZYQL9sKREjFwgXfmRj1wSF/CIKVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GU45mRqUBXAh4RsDnx9wc16sZJjUyTXC1CVEEpeJ9o22V4/sGSnLOYx/OXu7hCszE
	 ivkwD8a9sKZ4IAHZZO3bnbsk/g2+Je5SjSxcCN9PRrhxO1eimyojnMGVKmNBXNxzaJ
	 9RkDcYwnKfmKPLWl2dbwaROc3wvciuMTsoiMuYxc5e17c2JUpf5vZgqN7gsJx7VP02
	 BTn4YPDHwyhc4PRX2sfWcinMre12tICzMx/E7tgEpCEM+UmL42DynMisF+6lVoFD2f
	 lrEXeN0Bo/aPTURvIK+31hMTbUwb7/U6WYPYbzMQWnYK0u6Xy6MQg1Url7V7cDvsOv
	 pj0PrhEEXG09Q==
Date: Mon, 12 Oct 2026 13:56:11 -1000
Message-ID: <2e8098a4970602406e335edb4df09a0c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/5] sched_ext: selftest infrastructure fixes
In-Reply-To: <20261009134104.296891-1-cui.tao@linux.dev>
References: <20261009134104.296891-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Tao.

The following is a Claude-generated review.

On Fri, Oct 09, 2026 at 09:40:59PM +0800, Tao Cui wrote:
>   1. selftests/sched_ext: Fix reload_loop error-path use-after-free

Looks good. Inside the if (err) block, SCX_FAIL() reads better than
SCX_FAIL_IF(err, ...).

>   2. sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h

Can you name the commit in the description? It's ebeca1f930ea ("sched_ext:
Introduce cgroup sub-sched support").

>   3. selftests/sched_ext: Fail loudly when EXIT_KIND is missing from
>      BTF. EXIT_KIND() resolves scx_exit_kind values through
>      __COMPAT_ENUM_OR_ZERO(), which maps a missing enum to 0 (==
>      SCX_EXIT_NONE), so on kernels whose BTF lacks the enum every
>      EXIT_KIND() comparison is meaningless.

struct scx_exit_info carries enum scx_exit_kind, so any BTF that loads the
skeleton has the enum. What can be missing is an enumerator, and the four
the tests use today exist on every sched_ext kernel. On a kernel missing
one, the comparisons against SCX_EXIT_NONE get the right value from the
fallback, the SCX_EQ()s against UNREG/UNREG_BPF/ERROR fail with a confusing
message, and the only vacuous pass is the error poll in kick.c.

The new EXIT_KIND() is also SCX_KIND_VAL() with a different message. If
you want to keep the patch, maybe define one in terms of the other?

With a return hidden in the macro, the remaining
kind != EXIT_KIND(SCX_EXIT_NONE) sites (allowed_cpus, cgroup_nr_cpus,
cyclic_kick_wait, enq_blocked) jump over their goto cleanup on a miss, and
invalid_one() resolves error_kind after the gated worker is spawned.
Converting those sites to UEI_EXITED() like the polling helpers and
hoisting the lookup above the spawn would close that.

The <unistd.h> include is unused in this patch, and compat.h already pulls
it in.

>   4. selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it.

Looks good. Can SCX_ASSERT_ALIVE() print uei.msg too? That's where the
actual error text ends up. UEI_REPORT() already does that.

>   5. selftests/sched_ext: Bound exit waits and report reload_loop
>      failures.

On timeout, exit.c returns with the link and the skel still open. The
scheduler that didn't exit stays attached for the rest of the runner
process, so every later test fails to attach with EBUSY and the real
failure is buried. prog_run and hotplug destroy the link on their timeout
paths. Can exit.c do the same, plus exit__destroy()?

In reload_loop, SCX_FAIL_IF(unexpected_errno, ...) returns before the
printf(), so the ", unexpected errno" arm is dead, and the EBUSY count then
prints on every run. 2048 of 2048 failing is also a weak bar; "at least one
success per thread" would say the same thing more sharply. Would you split
the timed wait and the reload_loop accounting into two patches?

Nits: two stray blank lines after setup(), and the two #defines could be an
enum.

Can you note the base and how the series was tested in the cover?

Thanks.

-- 
tejun
