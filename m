Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED274CCDCA
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342697; cv=none; b=HRKmtdZKBe3AADxZgOxzfOIck9Ip6bOtG+ejjt2LdR3SgrIwGLkdOEsKk16V9QlOwr9PGBzr37mAg768e4wEie084se5WrVWld+2S0ktIXXoqk1rKuHSgV2OjtLV1oL6W4KyNS0LK+Ns2A5dZiTFFD/z1IP/ZQ5bDCNGukDSwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342697; c=relaxed/simple;
	bh=tHUbkvGU90Gj/vtyugettawxvt5waQLWfs1TdxmeSGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRPh1+wTuLPXlYkxipeyrL17p0zCeAniaOHhRmK3dvtxhUYV7MsNwtAEehJAiSdgmD6JE5NIttct+9k5QLXdlCbCJLXwfW2CDbGjONv0kcNr786v3gqBT4Wi0mQaHLj2q2PXXThpVZC6jyCRV30GZlaQD/FAEynK+JtkYFOBUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnqEWJHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnqEWJHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1A01F00A3A;
	Wed,  2 Sep 2026 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342695;
	bh=xMsvkZqdg1W8FRlc660J+1Ft4F2dMhEX2EaLelMwNOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnqEWJHdD4gHxiaDkebpudEN0iVMjuEZtuex+POdKDpBmeQx5TPlBrJKvPYHKooVG
	 7G/1PldA9PzdInED+rEp1owgkFd0u0t0478ZWoc1vB08ZRgfI9eKzLf3bD9u7oY4tc
	 h4ckReirOpwiop6gujsAYwQnJTm3KIWS0LBwIjqsiCPU3TkAq66kMVQystV+SiEpDW
	 X91935f45xedH3RhxspDyAAc+pkCp2De+bZdZZXAOWCrjzXQB0pgsyYDruR73/1aRw
	 gbCXj0M4J10uW7KanI7MyifnTUvqeEeNhITsW+Gzq3hLVV8ZnQhnrFoYPC55bTfYWI
	 WRSmh8Nkskuqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] sched_ext: Reject NMI calls to lock-taking kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260902093611.52651-1-liwanwu@kylinos.cn>
References: <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
 <20260902093611.52651-1-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:51:35 +0000
Message-Id: <20260902095135.AE1A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] scx_bpf_task_set_slice() incorrectly assumes exclusive access base=
d on scx_locked_rq(), causing data corruption in NMI context.
--

commit 2ad0cc408fc1de5da96ae5cb10c0e31d7633a82a
Author: Wanwu Li <liwanwu@kylinos.cn>

    sched_ext: Reject NMI calls to lock-taking kfuncs

This commit introduces the scx_kf_allowed_ctx() helper to reject NMI calls =
to
lock-taking kfuncs in sched_ext. It applies this check to several kfuncs th=
at
take raw spinlocks to prevent CPU hard-lockups when a tracing program runs =
in an
NMI context.

Link: https://lore.kernel.org/r/20260901095652.1009104-1-liwanwu@kylinos.cn

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 27bbf5e04d900..ca8ebb11f03ca 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2091,6 +2091,22 @@ extern struct scx_sched *scx_enabling_sub_sched;
>  #define scx_error(sch, fmt, args...)						\
>  	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> =20
> +/*
> + * Tracing progs can call kfuncs from NMI. Kfuncs that take scheduler lo=
cks or
> + * touch the kick lists, which are only protected by irq masking, can't =
run
> + * there, so abort the scheduler instead. scx_error() is NMI-safe.
> + */
> +#define scx_kf_allowed_ctx(sch)						\
> +({										\
> +	bool __allowed =3D true;							\
> +										\
> +	if (unlikely(in_nmi())) {						\
> +		scx_error((sch), "%s called from NMI", __func__);		\
> +		__allowed =3D false;						\
> +	}									\
> +	__allowed;								\
> +})
> +

[Severity: High]
This is a pre-existing issue, but I noticed an NMI-safety gap in
scx_bpf_task_set_slice() that seems to have been missed in this patch's
auditing of kfuncs exposed to BPF_PROG_TYPE_TRACING.

When a BPF tracing program executes in an NMI context (e.g., via a perf eve=
nt)
and calls scx_bpf_task_set_slice(), if the NMI interrupted a context that
already holds the target task's runqueue lock (such as update_curr_scx()):

kernel/sched/ext/ext.c:scx_bpf_task_set_slice() {
    ...
	locked_rq =3D scx_locked_rq();
	if (!locked_rq ||
	    (READ_ONCE(p->scx.runnable_cpu) !=3D cpu_of(locked_rq) &&
	     !task_current(locked_rq, p))) {
		set_task_slice_oob(sch, p, slice);
		return true;
	}
    ...
}

Will scx_locked_rq() incorrectly return the interrupted context's locked ru=
nqueue
rather than indicating the lock is not held by the NMI itself?

If so, won't this cause the NMI to bypass the NMI-safe out-of-band request =
path
(set_task_slice_oob()) and directly write to p->scx.slice?

Could this write race with the interrupted context, which may simultaneously
perform a non-atomic read-modify-write on the same variable, causing data
corruption or a lost update?=20

Should scx_bpf_task_set_slice() also use scx_kf_allowed_ctx() to reject NMI
calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902093611.5265=
1-1-liwanwu@kylinos.cn?part=3D1
