Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2437C0F6
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303854; cv=none; b=jkcn5Dz8bMI8ghw3MKL3Gb0EAhbND3WJdbDZf1dj/OHRrZy6TLwhBfigUMWyl2ID4jemL+WtCH+f7b+HGVSzM84dmZizhlzRjhYk34m9d/gz+Yzdy/uGyC6pd6UGZ9C3Nzc66PZ8pIfI63c7jp33+sLkTrLnGTAWv4gUkCML/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303854; c=relaxed/simple;
	bh=T+BujroqlzpX9SwU1zl0H18AJWwLL6rif/I+fb5rcGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H2CV5w7visUTAl2UD9Vq8rYubhAhIcPa+HKTkutoulQzGNIikxwi9DJe/3XlS4+Hgj+/BOJOoX8X4COlyH1rr4Q4e9sPsNT/MHtcKlsrRhKAQNYx9xpmvWRT1BWvSaa6u6l8NQLC195uo2vIajiji+Qc32q+g69iasBc04xKnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPZXEvSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPZXEvSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C31F000E9;
	Mon,  6 Jul 2026 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303852;
	bh=QUywZM9yL21MRHaU06Jkv21qQQY7b7/Nbzfu/CdBAjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPZXEvSw1kZptFWkC8k/1V76IF2aom3jdThWU1JRX6qIPtcsu8D1vgwg8O7UaUzxC
	 hQlWUrC2BrM6LdqT7vdOzZ3b3MlLzND2mTtJRyxiwAL/F9WcofxrsI9psQIXghhuY1
	 Sou03p8qHqxngSEhqk8rpxOUZmv3fxVd+MyUJYWqpA6FVrrOtPHBa6Lp3NtGfYwwYM
	 lcbFVq43yMsI88HKJvNbh5r1sltmExy6dJB8nfGYWlHRQHY0i7kPurCmTdFdF6sSzv
	 kuuGn8j3WMf4zS6ycSWdkw/5JVP7vla/nBZu6pw/gPr9TtmOFjSezMmEIWGxkZ1w5J
	 UZrjUR3C4Z2eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 25/36] sched_ext: Add the
 SCX_CAP_ENQ_IMMED cap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-26-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-26-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:10:50 +0000
Message-Id: <20260706021051.531C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Migration-disabled tasks can stall indefinitely in a sub-scheduler=
 because scx_bpf_sub_dispatch() skips the sub-scheduler's ops.dispatch() wh=
en SCX_CAP_BASE is missing on the CPU.
--

commit 317bac7c35f71212ef04d00c194b7f0e57676589
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add the SCX_CAP_ENQ_IMMED cap

Replace the __SCX_CAP_DUMMY placeholder with SCX_CAP_ENQ_IMMED, which gates
inserting IMMED tasks onto a cid's local DSQ. An IMMED enqueue is guaranteed
to either get its task running on the cpu at once or hand it back to the
scheduler.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index e79d30aba0cc0..380e6e5ea72f9 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -1248,6 +1248,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_i=
d, const struct bpf_prog_aux *
>  		return false;
>  	}
> =20
> +	/*
> +	 * Skip a child that does not effectively hold the base cap on this cpu:
> +	 * its inserts would only be rejected. ecaps are synced at the top of
> +	 * balance_one() before dispatch, so this reflects the in-effect state.
> +	 */
> +	if (scx_missing_caps(child, cpu_of(this_rq), SCX_CAP_BASE))
> +		return false;

[Severity: High]
Will this optimization stall migration-disabled tasks indefinitely?

The commit message and comment assume that if SCX_CAP_BASE is missing, all
inserts will be rejected. However, looking at scx_local_or_reject_dsq(),
migration-disabled tasks are explicitly force-admitted even when caps are
missing:

kernel/sched/ext/sub.c:scx_local_or_reject_dsq() {
    ...
    /*
     * A migration-disabled task must run on this CPU. Let it run and count
     * the violation. Refuse preemptions.
     */
    if (unlikely(is_migration_disabled(p))) {
        __scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
        *enq_flags &=3D ~SCX_ENQ_PREEMPT;
        return &rq->scx.local_dsq;
    }
    ...
}

If a task pinned via migrate_disable is queued internally by a
sub-scheduler, and the sub-scheduler then loses SCX_CAP_BASE on that
CPU, skipping ops.dispatch prevents the task from being dispatched
to the local DSQ where it would have been successfully admitted.

Could this cause the task to be stranded in the sub-scheduler's
internal queues and trigger the stall watchdog?

> +
>  	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_pre=
v,
>  				  true);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D25
