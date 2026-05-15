Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8143CEEB
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837943; cv=none; b=PG2fKsQFqW8ztJ8Ac86X64vE7O0JEg9uBvJSGZ2WbhsFaS1RcJjZqnYn2yqnEuxAig0rIR5HevxGXuKQjNVSuEb6xHwXx16qdmb+tzScc7RcDdHIObKar1OFxEcQz+jPEnrUvRfFS5D67ZLk22zD5cbP+JZLsX4LmtK+m7Dn+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837943; c=relaxed/simple;
	bh=Ii5E4NDIbbFSIgFkGyUpNTq1MD2LkMKH3/ib99MhU9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iutlpVySb4QVo2hsDBAEmFcgU6QlwXpQuJVK4XRxHjJa2D3OaQG2QPFBDCxRz52ecZhANuyLBPKd27py/bAM5aaEgaLeWUVDpycr6VYm4cxZQHPBKXo5BQjz8OdjBv92WpyNHimfkSJHBia+G//+6H4XZ4W7aj7oXv2CIN0TuXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBtlBHBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBtlBHBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D9C2BCB8;
	Fri, 15 May 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778837942;
	bh=Ii5E4NDIbbFSIgFkGyUpNTq1MD2LkMKH3/ib99MhU9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nBtlBHBzB0ZYTgP1K5XHJVFV35ytREDeXXlA23eCgJ0IQpoPua4+ImftoM/8wTDzs
	 tyb1p8ELExEIgirviq6MBUWxe7QuvZjFwiBkh9HHYohMMcZ2fI+tYAX3YaYQz0reA2
	 9UdCdAweQEIQnfpylF6G8nBNLN413TWH7rxTxsoYb3yFQhcGJRdWaTmiLVrM9ATqEp
	 nj5UaZPzBpKwNtFXqD4Vn7X3UainrGSOQtAmY5mRjCe031rT/G97xmvAh6UUYz7i3d
	 sOkR9ABjgHIgn7NCRD8cWFKmO6428oOkmmlFYTWmA+GIQ3UWas5vG0xf8Pq9AkZcu3
	 dhPj2UlWnqWSw==
From: sashiko-bot@kernel.org
Subject: Re: Patch "sched_ext: Skip tasks with stale task_rq in
 bypass_lb_cpu()" has been added to the 7.0-stable tree
Reply-To: sashiko-reviews@lists.linux.dev
To: gregkh@linuxfoundation.org
Cc: sched-ext@lists.linux.dev
In-Reply-To: <2026051520-oak-marlin-d109@gregkh>
References: <2026051520-oak-marlin-d109@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 09:39:01 +0000
Message-Id: <20260515093902.D29D9C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded iteration with interrupts disabled in `bypass_lb_cpu()` =
due to skipping tasks without yielding.
--

commit a8567d453e072dcdd0102db7ef988700bdb7dc40
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()

This commit updates the bypass_lb_cpu() load balancer to skip tasks that
have a stale task_rq. This prevents moving tasks between per-CPU bypass
dispatch queues without having the correct runqueue lock held.

> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
[ ... ]
> @@ -4005,6 +4005,15 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, st=
ruct rq *rq,
>  		if (cpumask_empty(donee_mask))
>  			break;
> =20
> +		/*
> +		 * If an earlier pass placed @p on @donor_dsq from a different
> +		 * CPU and the donee hasn't consumed it yet, @p is still on the
> +		 * previous CPU and task_rq(@p) !=3D @rq. @p can't be moved
> +		 * without its rq locked. Skip.
> +		 */
> +		if (task_rq(p) !=3D rq)
> +			continue;

Does this regression lead to unbounded iteration with local interrupts
disabled?

Looking at bypass_lb_cpu(), it iterates over tasks in donor_dsq while holdi=
ng
rq->lock and donor_dsq->lock. The function includes a batching mechanism to
drop these locks and prevent CPU stalls:

    nr_balanced++;
    if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
        list_move_tail(&cursor.node, &n->scx.dsq_list.node);
        raw_spin_unlock(&donor_dsq->lock);
        raw_spin_rq_unlock_irq(rq);
        cpu_relax();
        ...

When tasks are skipped via the new continue statement, nr_balanced is not
incremented.

If the bypass dispatch queue contains a massive number of tasks that were
recently load-balanced but not yet consumed, they will all have a stale
task_rq.

Since they are all skipped, the loop might process an immense queue without
ever incrementing nr_balanced or triggering the lock yield.

Would it be safer to use a separate loop iteration counter rather than the
number of successfully balanced tasks to trigger the yield?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026051520-oak-marl=
in-d109@gregkh?part=3D1
