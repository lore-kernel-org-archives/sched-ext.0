Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77FB340A6B;
	Wed, 14 Oct 2026 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015846; cv=none; b=itzqGmktbd8l4h9MSCihnXT0dzHonn+I7eEqcWhZwji7u4weGysSXsh/c9JHWNdk4n8LUXSOoaqgVBrTs1Que6MC3siSeZY7vPzkJJwwUQJK0KIwoe6YD1G+aqacoQXD5Pxkmo1a/emy6JzeuGhVnUuDCreI4rLETmbtvLAihPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015846; c=relaxed/simple;
	bh=TjpnB4BEvnFfwD1bqKINrA2hbJwQBOIRlcx9OXy/IoM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=pekknfYHYnWk88ljXnsih2wfy/XVamkrHydjMeEMMj+e7GCFTGDZcYIQkTx4qrlSSq+XISwWJ+ZyfDavxWXtNWuP3PmmWL7OokPv13lh4rh/gRPnhnoYN9TKHdKWQNItAzgaaTDfYpKgrRjWImQPX2WKlIhTjMr1iQGSAWQHPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIBbO2NA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIBbO2NA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0481F000C4;
	Wed, 14 Oct 2026 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792015845;
	bh=W3Bq6C92sQO+WSkQqUkMDNh/Iky/lTJUZzHDO8UhxGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XIBbO2NA8fB94Xy57oUqarNXDjzpvppV6giyZr0lfedDgsk4gqJxZMQ7HjXI3OvVP
	 LufskcG6Ig3ddCqwdymEQFrzvkfWONkRN9FhGY+oVeGgOYKf7ikOetTpfiino+gJtL
	 5v7rkE0Q0lEALAsTfPQoCR1KwCXclaXNkFnIu7K/GAWqV9vndbrrHkLExv3LtZzLVe
	 BcVFdaYwPffAB5hLsULJDMqMPPsYf7xQWccdm+JgtwCPRDVZn4Xxj0NFMUixfp0TOa
	 jynBc5bRuyaI1YocfjJI9ms0N/XiBqVdhaHQs4Qx2WPOIjbVX7ag8GMMIpxsSjgYlS
	 5QUgG4DJnMPzw==
Date: Wed, 14 Oct 2026 12:10:44 -1000
Message-ID: <1548cc9309a6e0894e358262e0b3d4ee@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
In-Reply-To: <5b3d2c576222c62738b7006d85f96a23@kernel.org>
References: <20261010090621.184717-1-arighi@nvidia.com>
 <5b3d2c576222c62738b7006d85f96a23@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

The following is a Claude-generated review.

Two issues found while going through the patch. Both are from reading
the code and neither has been reproduced.

SCX_RQ_PROXY_PENDING can stay set into a core-sched forced idle:

1. A blocked donor is picked and set_next_task_scx() sets the flag.

2. find_proxy_task() returns NULL without putting the donor because
   blocked_on changed or the owner moved, and __schedule() goes to
   pick_again.

3. On the core-sched path, a fair or RT task wins pick_task() on this
   rq, so pick_task_scx() does not run and the flag is not cleared.

4. The cookie does not match and the CPU is forced idle.
   put_prev_set_next_task(rq, donor, idle) sees the flag and
   put_prev_task_scx() takes it as a bookkeeping put.

An IMMED donor then stays on the local DSQ through the forced idle, and
a donor without slice goes to ops.enqueue() without SCX_ENQ_LAST. Maybe
clear the flag when find_proxy_task() abandons the pick?

On an IMMED bookkeeping put, the local DSQ insert always queues a reenq
scan from dsq_inc_nr(). rq->next_class is still ext there, as
proxy_resched_idle() lowers it to idle only after the put, so
rq_is_open() is false. The scan is a no-op once the CPU is in idle.

However, if an SCX task wakes up on the CPU before the scan runs, the
wakeup raises rq->next_class back to ext and task_woken_scx() runs the
pending scan, which sees the rq closed and sends the donor back to BPF.
That is the ops.enqueue() round trip the patch is meant to remove. Can
you take a look?

Thanks.

-- 
tejun
