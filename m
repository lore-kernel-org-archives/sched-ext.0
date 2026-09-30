Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F8489FAA
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764567; cv=none; b=fFJKeiDpybw5ucxplnb8BK+uccu8sf8XwcbM8gNnkcN2vDANrkcUU+06UQ/85FPjLa4hBzzvHZL+/2u3j2RoYpEI4EZ1fB2xdcMfN+363Fuw0qXdkW6KIgs1MZZgE2C7QPI+l94h3B6aG24SqVA2WMwS9HWfsWibXe0HcZvuo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764567; c=relaxed/simple;
	bh=9dtCwYfWb6A8dW0X1unVuKbvFyLwjssYOzl1paeOWUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wsstf/xpr3yHdb4JyvQ8w1BcLa+k/PRLgNwZKN8/GIYnmjQhAKEVqUS8RHh9pzkrrkMTKCHOnbdViWuNTlI+/HRis8LPKGjpkZ+dHfs6pGc72UiUVfyry4OLZSgB/t2Zsm1YT7+e24ryYLl/UdoYnq+Xg0OGszaGSwjaDqmngQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBhWdOdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBhWdOdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9461F000FF;
	Wed, 30 Sep 2026 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764564;
	bh=mMOpQBIGcshS6CoqOc5Eho+euYvXdunwIfJZ0yJLyL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBhWdOdD3f5G1r8joEvRg7ee0BDf8QR3Hf0sWcsvohei3aBz/ZOZh444jW3p1AVCW
	 stZxXPSbjehVqN2LIXt6NYlhohQ4MkSw6pHp9b3Jfpoe7OolF1ui0Jz2uQ2dHqKjLR
	 bk+kDoBIAcv1AAkk/vkKjC4j5vSG9QL4UG8KhHx0Kep1F6y9kEmt9eBT9EDuAh856S
	 0+/aWdYB5wuvegYlvx9xDYsRGcPFRaW7N9asZHa2vuuIoxNQ3aUXqmyhlQTZefebLZ
	 ZkBUwJ8EQiaGYRwCmhC1K7qbJQCp6ZdTOR8c9Ztep+SoYNBEf+Be9eI/YbgnlRpnsb
	 lCPcj9Qec4rMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260930101722.2468434-1-sh_def@163.com>
References: <20260930101722.2468434-1-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:36:03 +0000
Message-Id: <20260930103603.DF9461F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sched_ext: invalid wait context calling kfree() under raw_spinlock=
_t
- [High] sched_ext: UAF due to missing memory barrier in deferred reenqueue
--

commit 32dd5c50544bf44b37d3cb4933b2658023766e35
Author: Hui Su <sh_def@163.com>

sched_ext: Hold DSQ refs for deferred reenqueues

This patch adds a reference count to DSQ to protect deferred reenqueues.
It takes a reference before detaching the node and drops it after the final=
=20
DSQ access, preventing the DSQ from being freed prematurely by the RCU
callback.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 6b037d27c99d3..88f229bd0c4d2 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -5075,6 +5075,7 @@ static void process_deferred_reenq_users(struct rq =
*rq)
>  			dsq_pcpu =3D container_of(dru, struct scx_dsq_pcpu,
>  						deferred_reenq_user);
>  			dsq =3D dsq_pcpu->dsq;
> +			refcount_inc(&dsq->deferred_reenq_refs);
>  			reenq_flags =3D dru->flags;
>  			WRITE_ONCE(dru->flags, 0);
>  			list_del_init(&dru->node);

[Severity: High]
Is a memory barrier needed here to ensure the refcount increment is
visible before the list deletion?

Because refcount_inc() uses relaxed atomics, it provides no memory
ordering guarantees. On weakly-ordered architectures, the CPU can commit
the list_del_init() to memory before the refcount_inc().

Concurrently, exit_dsq() performs a lockless read check:

kernel/sched/ext/ext.c:exit_dsq() {
    ...
    if (WARN_ON_ONCE(!list_empty(&dru->node))) {
        ...
    }
}

If exit_dsq() observes the reordered list deletion, it skips acquiring
the spinlock and proceeds to drop the base refcount. Since the refcount
increment hasn't reached global visibility yet, the base refcount drops
from 1 to 0 and dsq is prematurely freed, which can cause a
use-after-free when the deferred path continues.

Additionally, list_del_init() is not atomic and momentarily leaves
node->next pointing to the old element before pointing to itself. The
lockless check in exit_dsq() could evaluate to true during this window,
triggering a spurious warning.

[ ... ]
> @@ -5086,10 +5087,14 @@ static void process_deferred_reenq_users(struct r=
q *rq)
>  		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq=
 */
>  		dsq_id =3D READ_ONCE(dsq->id);
>  		if (unlikely(dsq_id =3D=3D SCX_DSQ_INVALID))
> -			continue;
> +			goto put_dsq;
> =20
>  		BUG_ON(dsq_id & SCX_DSQ_FLAG_BUILTIN);
>  		reenq_user(rq, dsq, reenq_flags);
> +
> +put_dsq:
> +		if (refcount_dec_and_test(&dsq->deferred_reenq_refs))
> +			kfree(dsq);

[Severity: High]
Does calling kfree() here violate lock nesting rules?

The process_deferred_reenq_users() function is executed with the
runqueue lock held, which is a raw_spinlock_t (never sleeps).

The slab allocator's kfree() slow path acquires internal spinlock_t or
local locks, which can sleep on PREEMPT_RT kernels. Acquiring a
sleepable lock while holding a true spinning lock triggers an "Invalid
wait context" splat and could potentially lead to deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930101722.2468=
434-1-sh_def@163.com?part=3D1
