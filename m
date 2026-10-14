Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104E47884D
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972318; cv=none; b=r4n0ywcjKMsz9hn39er8MIijbXXsKczNKuBqpaNA/YwR8rt7rqJW/nVqeyLWuZViObqSivA5wYpPEJVS3AAEHdSeMrtFc4DkINR/HM0XDG3l2c1PseVkidQy+rMVNva3Cu7Jj/mOtVNG5FDmEt/35emmmF3WbX5LB1+9QIA5c8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972318; c=relaxed/simple;
	bh=RdgFkO0vK3WrSvtX01n2ZWWqGAoVqNuCElQNCACxwkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGxrTkUWvazk6XQkqwvpE9OUUFQNm3V+KC3HWoqSXdDr9H7GksJ0Mxkzxz+8AxtTW4EfEtYxetPXG9gldeG72UpAt0j9cJCJlM8aDbiAHzPS7dJE037yZQQI66PZ8VOuyt+PvEUojuWpuFRs2v4ikcwSWCwbp0ycl3SJ89WVn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=efN+X+a9; arc=none smtp.client-ip=91.218.175.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="efN+X+a9"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=RdgFkO0vK3WrSvtX01n2ZWWqGAoVqNuCElQNCACxwkY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791972313; v=1; x=1792577113;
 b=efN+X+a9ySBD4YXxg1tSIQKpBDFlq0mW7kdL/mReuZGN571heabEdsjVh2hb2h0wNlQq7FxT
 Rx5G+Ku5GgXNl99qf/DgWWCKCjQpwfMsKriJo2SI8FCy8WIFQcs7E1BtE9r8zawtWz5c2pkJeyO
 nauHDuTRjMwwKkatTIv3M12s=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 80773e8497cfc15c;
	Wed, 14 Oct 2026 10:05:11 +0000
X-Mizu-Trace-ID: 80773e8497cfc15c
X-Migadu-Flow: FLOW_OUT
Message-ID: <875283f4-ecaf-46ba-b56b-cc5ddb5b1e7b@linux.dev>
Date: Wed, 14 Oct 2026 18:05:07 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sched_ext: selftest infrastructure fixes
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 Tao Cui <cuitao@kylinos.cn>
References: <20261009134104.296891-1-cui.tao@linux.dev>
 <2e8098a4970602406e335edb4df09a0c@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <2e8098a4970602406e335edb4df09a0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/10/13 7:56, Tejun Heo 写道:
> Hello, Tao.
> 
> The following is a Claude-generated review.
> 
> On Fri, Oct 09, 2026 at 09:40:59PM +0800, Tao Cui wrote:
>>   1. selftests/sched_ext: Fix reload_loop error-path use-after-free
> 
> Looks good. Inside the if (err) block, SCX_FAIL() reads better than
> SCX_FAIL_IF(err, ...).
Done (v2 patch 1).
> 
>>   2. sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
> 
> Can you name the commit in the description? It's ebeca1f930ea ("sched_ext:
> Introduce cgroup sub-sched support").
Done (v2 patch 2), which also fixes the wrong attribution in the v1
description - I had guessed "lifetime notification support".
> 
>>   3. selftests/sched_ext: Fail loudly when EXIT_KIND is missing from
>>      BTF. EXIT_KIND() resolves scx_exit_kind values through
>>      __COMPAT_ENUM_OR_ZERO(), which maps a missing enum to 0 (==
>>      SCX_EXIT_NONE), so on kernels whose BTF lacks the enum every
>>      EXIT_KIND() comparison is meaningless.
> 
> struct scx_exit_info carries enum scx_exit_kind, so any BTF that loads the
> skeleton has the enum. What can be missing is an enumerator, and the four
> the tests use today exist on every sched_ext kernel. On a kernel missing
> one, the comparisons against SCX_EXIT_NONE get the right value from the
> fallback, the SCX_EQ()s against UNREG/UNREG_BPF/ERROR fail with a confusing
> message, and the only vacuous pass is the error poll in kick.c.
> 
Conceded - v1's premise was wrong, thanks for the correction.

> The new EXIT_KIND() is also SCX_KIND_VAL() with a different message. If
> you want to keep the patch, maybe define one in terms of the other?
> 
> With a return hidden in the macro, the remaining
> kind != EXIT_KIND(SCX_EXIT_NONE) sites (allowed_cpus, cgroup_nr_cpus,
> cyclic_kick_wait, enq_blocked) jump over their goto cleanup on a miss, and
> invalid_one() resolves error_kind after the gated worker is spawned.
> Converting those sites to UEI_EXITED() like the polling helpers and
> hoisting the lookup above the spawn would close that.
> 
> The <unistd.h> include is unused in this patch, and compat.h already pulls
> it in.
> 
Kept, but reshaped along exactly these lines (v2 patch 3): EXIT_KIND()
is now an alias of SCX_KIND_VAL() so there is a single implementation,
the four `kind != EXIT_KIND(SCX_EXIT_NONE)` sites are converted to
UEI_EXITED(), invalid_one() resolves error_kind before spawning the
gated worker, and cyclic_kick_wait no longer calls EXIT_KIND() at all.
The unused <unistd.h> include is dropped.

>>   4. selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it.
> 
> Looks good. Can SCX_ASSERT_ALIVE() print uei.msg too? That's where the
> actual error text ends up. UEI_REPORT() already does that.
> 
Done (v2 patch 4) - the failure now prints kind, exit code and uei.msg.

>>   5. selftests/sched_ext: Bound exit waits and report reload_loop
>>      failures.
> 
> On timeout, exit.c returns with the link and the skel still open. The
> scheduler that didn't exit stays attached for the rest of the runner
> process, so every later test fails to attach with EBUSY and the real
> failure is buried. prog_run and hotplug destroy the link on their timeout
> paths. Can exit.c do the same, plus exit__destroy()?
> 
Done (v2 patch 5) - the timeout path now destroys the link and the
skeleton before failing.

> In reload_loop, SCX_FAIL_IF(unexpected_errno, ...) returns before the
> printf(), so the ", unexpected errno" arm is dead, and the EBUSY count then
> prints on every run. 2048 of 2048 failing is also a weak bar; "at least one
> success per thread" would say the same thing more sharply. Would you split
> the timed wait and the reload_loop accounting into two patches?
> 
Split (v2 patches 5/6). The dead arm and the always-on printf are gone;
failures are reported by the fail conditions themselves. The bar is now
per-thread: the test fails if either thread failed every attach, and
the failure message carries the EBUSY count.

> Nits: two stray blank lines after setup(), and the two #defines could be an
> enum.
> 
> Can you note the base and how the series was tested in the cover?
> 
Done - the v2 cover states the base commit and the testing.

The two issues sashiko flagged on 5/5 (exit.c leak on timeout, dead
reload_loop arm) and the one on 3/5 (EXIT_KIND hidden return in
invalid_one) are all covered by the above.

Testing: same setup as v1 - QEMU x86_64 VM on top of the series base;
full sched_ext selftest run plus the A/B checks for each behavioral
change (synthetic BTF without the enumerator for patch 3, injected
scheduler death for patch 4, a scheduler stuck in ops.init for the
bounded waits, reload stress with in-flight teardown for patch 6).
Results are in the v2 cover letter.

Thanks,
Tao

> Thanks.
> 

