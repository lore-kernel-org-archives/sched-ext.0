Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18B3AE1BD
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099661; cv=none; b=FNXsyEb8R9a42pqLk3BFHj8bjyo4jKzboY3CCp0mo0JBvAooXh8H2Fanht1nmwTa2iyGW9eM8fv+lLzwboTkLHo8aalB5KuiSuhXpeIJbRcmqv0j6x3DNNFilTpqUhHy+CG8VumYIJB/DwPB1rCPr402BsRr3OhXQGokO5V/FYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099661; c=relaxed/simple;
	bh=CxtdgSbRm2YMD/AJ2Dgsy98PKXNLGHxztqeQDefF/X8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=drj6NYkBvJw/ivzrJhUF1ZDenjwPcyo7LD+sjiVnspQsqPH3OKL1EgwM3xBRidb/ujbKA9heL6CHv/WGr4LmuwACNWP8BwbNSBRudVh9uWApw3+DMaoMLr4BHXRITFHTg8EBIL88LTg3XoAhKpeEVmxG6MKCFyCzQPgZnqWTpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNbe6eoH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNbe6eoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225C7C2BCB0;
	Wed,  6 May 2026 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778099661;
	bh=CxtdgSbRm2YMD/AJ2Dgsy98PKXNLGHxztqeQDefF/X8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JNbe6eoHp+W+RqnH2iRbUjgOu9xnfMjM4Ul9b6Md+sjgMBmmgMeO/Tb6OQs+Cgm+s
	 nDKHnl1TVtEJyXzaMGcCYSIWYaFrCvCBPKHI6CWUwsr4YAeb7JvUczPq6phN/C33BF
	 wogQiJal91Xte7s3KgsHT6bwlGoqPsnFwv+CeGXph/7F4Mo89IEGDDqHJTf1+ky6VC
	 SRn3b70LueHFEgZs0p5XuR3B6mFPoEurvhspXjNTZ/c0dBXCciEzGgy1ReuCLCDLfl
	 FnAqQyplYwVHPkyOPVxjZtHQBHXQGQMjzEaL7g4tS94bkV7wbV+t8sIT4+tjmxSse+
	 42Oa/BsA3OSow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] sched_ext: Add cookie API for early qseq capture
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260506160412.522199-2-yphbchou0911@gmail.com>
References: <20260506160412.522199-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:34:20 +0000
Message-Id: <20260506203421.225C7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] scx_bpf_task_get_cookie() reads the sequence counter (ops_state) w=
ithout acquire semantics, failing to prevent the BPF program's pre-dispatch=
 checks from being reordered before the cookie capture.
--

commit 4466cb81e5097999461b1978bdcc6623cb37dcf1
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>
sched_ext: Add cookie API for early qseq capture

This commit introduces a cookie API for early qseq capture, extending the
protection window for BPF-side pre-dispatch checks against concurrent
dequeue/re-enqueue races.

Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5600618dcef8e..f28baf7ce79cc 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> @@ -8505,13 +8507,71 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct =
task_struct *p, u64 dsq_id,
>  	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>  }
> =20
> +/**
> + * scx_bpf_task_get_cookie - Get an opaque dispatch cookie for a task
> + * @p: task_struct to read cookie from
> + *
> + * Returns an opaque u64 dispatch cookie. Pass the cookie to
> + * scx_bpf_dsq_insert_with_cookie() to extend the time window during
> + * which sched_ext will detect racing dequeues/enqueues of @p. The
> + * extended window begins with this call and ends at the same point as
> + * for dispatches without cookies, i.e. when sched_ext attempts to
> + * finish the dispatch.
> + *
> + * This API is intended for schedulers that do not implement properly
> + * synchronized dequeue.
> + */
> +__bpf_kfunc u64 scx_bpf_task_get_cookie(struct task_struct *p)
> +{
> +	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
> +}

Does this sequence counter read require acquire semantics?

Because this kfunc acts as the read-begin phase of a sequence lock for the
BPF program, using atomic_long_read() might allow the CPU to speculatively
reorder the BPF program's subsequent memory loads before the ops_state read
on weakly-ordered architectures.

If a concurrent task state update occurs between the reordered data read and
the ops_state read, could the CPU fetch stale task data but capture the new
ops_state as its cookie?

Could this missing ordering cause a regression where the dispatch is falsely
validated later, since the cookie would match the task's current ops_state?

Would it make sense to use atomic_long_read_acquire() here or include an
smp_rmb() to enforce the necessary load-load ordering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506160412.5221=
99-1-yphbchou0911@gmail.com?part=3D1
