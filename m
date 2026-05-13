Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1138D3F1
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690494; cv=none; b=EUdR3ISc7TOPqjwKz5hcoC3vOV/10+iQ9mWKZ9f6vXcG/6BiTiLU8sSxZ9SsqFafoyJZK5d9JCVdlpCbsNLeHHfibKtkC7eU12XkJklQF0LZmMdl2WarX2Szf2u1OCWHZuT8qzeM3OC0pik4+RxS/wGgtzVeRc9A2UAWbUaD38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690494; c=relaxed/simple;
	bh=DCnuSAz/EjNjLF/76fwyudmjz6nsDzmXtw7tOkzBsHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfrvo+sVvskpvAHI9zjsKWwmnFayEjcBbIgQjHFkVez/7e2zg/8b4QHZNmcNRngXNcvuJd/CmhR3EWlhEdk4PTK+wBq3JvDa+n7YmYnqO36mIe2MwcCLhFH96IzuOkTA3zCPEi8K3NGSSGQO8hVnbb7jx899hrsXmrnTtFK0fKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Md19kg0F; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Md19kg0F"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 215F626B06;
	Wed, 13 May 2026 18:41:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qFwBlyxIhmNd; Wed, 13 May 2026 18:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778690488; bh=DCnuSAz/EjNjLF/76fwyudmjz6nsDzmXtw7tOkzBsHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Md19kg0FCuDhG3BJvN/9XypBsZYuHDCuuG9dqqjBecLDjAoYME7OjuzPAMm8KiHOg
	 /3zBogiwgkiLsRyk/J4UexortQd5Nwg+p2UuPR6PuiMs+zD9Lv1ShjWgfqORiKrymn
	 W/KsrgKZeZ1vZvUwSVM+xQxmWSYCVa8Hz+n+eRbWN207Vd+zB5Cx7vUuZ0KH0/Jrbz
	 NQFmJPvTz1ACdV/2XOxYnoadU6mK2ClRCBbSlI2MjGixg9tnBX0s4CRFZyakx5RNx7
	 kKtdcJk5gNd0nuDrNx5T/ny9jKJ0Hsz7scI36pMApjcnj3aO3aWQWHzbDx/RekkIfH
	 JuxB0uwcN7rDg==
Date: Wed, 13 May 2026 18:41:26 +0200
From: Samuele Mariotti <smariotti@disroot.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agSpf9QRx4zqhZxx@cachyos>
References: <20260513095329.4029345-1-smariotti@disroot.org>
 <agSKJbtmpRPLgYJW@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSKJbtmpRPLgYJW@gpd4>


Hi Andrea,

On 13/05/2026 16:26, Andrea Righi wrote:
>Hi Samuele,
>
>On Wed, May 13, 2026 at 11:53:29AM +0200, Samuele Mariotti wrote:
>> ops_dequeue() can race with finish_dispatch() and spuriously trigger the
>> "queued task must be in BPF scheduler's custody" warning.
>>
>> ops_dequeue() snapshots p->scx.ops_state via atomic_long_read_acquire()
>> and then, in the SCX_OPSS_QUEUED arm, asserts that SCX_TASK_IN_CUSTODY
>> is set. The two reads are not atomic w.r.t. a concurrent
>> finish_dispatch() running on another CPU:
>>
>> CPU 1                                    CPU 2
>> =====                                    =====
>>                                          dequeue_task_scx()
>>                                            ops_dequeue()
>>                                              opss = read_acquire(ops_state)
>>                                                   = SCX_OPSS_QUEUED
>> finish_dispatch()
>>   cmpxchg ops_state:
>>     SCX_OPSS_QUEUED -> SCX_OPSS_DISPATCHING  [succeeds]
>>   dispatch_enqueue(SCX_DSQ_GLOBAL,
>>                    SCX_ENQ_CLEAR_OPSS)
>>     call_task_dequeue()
>>       p->scx.flags &= ~SCX_TASK_IN_CUSTODY
>>                                              WARN_ON_ONCE(!(p->scx.flags &
>>                                                      SCX_TASK_IN_CUSTODY))
>>                                             /* opss is stale: QUEUED,
>>                                              * but task already claimed */
>>     set_release(ops_state, SCX_OPSS_NONE)
>>
>> The race has been observed via two distinct call chains: the most common
>> goes through sched_setaffinity(), a rarer variant through
>> sched_change_begin().
>>
>> For SCX_DSQ_GLOBAL / SCX_DSQ_BYPASS, dispatch_enqueue() clears
>> SCX_TASK_IN_CUSTODY before clearing ops_state to SCX_OPSS_NONE
>> (intentional, to avoid concurrent non-atomic RMW of p->scx.flags against
>> ops_dequeue()). The window between those two writes is exactly what
>> ops_dequeue() observes as "QUEUED without custody".
>>
>> The observed state is not actually inconsistent, it just means CPU 1 has
>> already claimed the task and the QUEUED value held by CPU 2 is stale.
>> Re-read ops_state in that case; the next read is guaranteed to return
>> SCX_OPSS_DISPATCHING or SCX_OPSS_NONE, both of which exit the switch
>> cleanly. The retry is bounded: once IN_CUSTODY is cleared, ops_state has
>> already advanced past QUEUED for this dispatch cycle, and a fresh QUEUED
>> would require re-enqueue under p's rq lock, which CPU 2 holds.
>>
>> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
>> Suggested-by: Andrea Righi <arighi@nvidia.com>
>> Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
>> Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
>> ---
>>  kernel/sched/ext.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 23f7b3f63b09..d285e37f2177 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -2078,6 +2078,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>>      /* dequeue is always temporary, don't reset runnable_at */
>>      clr_task_runnable(p, false);
>>
>> +retry:
>>      /* acquire ensures that we see the preceding updates on QUEUED */
>>      opss = atomic_long_read_acquire(&p->scx.ops_state);
>>
>> @@ -2092,7 +2093,9 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>>          BUG();
>>      case SCX_OPSS_QUEUED:
>>          /* A queued task must always be in BPF scheduler's custody */
>> -        WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
>> +        if (!(p->scx.flags & SCX_TASK_IN_CUSTODY))
>> +            goto retry;
>
>Can we add a cpu_relax() before the goto? A hot spin polling two cachelines from
>another CPU could be very unkind to SMT siblings and bus traffic.
>
>Moreover, we completely lose the original WARN_ON_ONCE(), so we don't catch the
>case where the invariant QUEUED -> IN_CUSTODY is violated by a realy bug. How
>about adding a max retries as well, i.e., something like this:
>
>    int retries = 0;
>
>    ...
>retry:
>    ...
>    if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) &&
>        !WARN_ON_ONCE(retries++ >= 128)) {
>        cpu_relax();
>        goto retry;
>    }
>
>> +
>>          if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>>                          SCX_OPSS_NONE))
>>              break;
>> --
>> 2.54.0
>>
>
>Thanks,
>-Andrea

Thanks for the suggestion. I agree with adding cpu_relax() and the
retry limit to preserve the original WARN_ON_ONCE() as a safety net
for real bugs.

Given the improvements to efficiency, I would also improve the non-atomic
read of p->scx.flags by using READ_ONCE(), preventing the compiler from
caching the value across retries and ensuring each iteration observes the
latest value written by the concurrent finish_dispatch(). I would also
lower the retry limit from 128 to 4, since the maximum number of retries
observed empirically is 1, so 4 gives a reasonable safety margin without
spinning unnecessarily long. 

Something like this: 

if (!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY) &&
     !WARN_ON_ONCE(retries++ >= 4)) {
         cpu_relax();
         goto retry;
}

Let me know if this looks good to you.

Thanks,
Samuele
