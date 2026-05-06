Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20633FB7DC
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062099; cv=none; b=pMxDnrnZJ3g65CP6pqbAODBGV/zyk+TRQe46Oja34w/PWCbH0WXssQxGbAvyQLfjeLKLS60DO7zZ9yOv0AtsKIK+NC16hTslzr6HoiiOZuGvvZ0tqHTZrKLHNd6Iu/Se86tUz2jjUqUzyuLxbo6wp4OINwA8VXJi2UkA3sSvHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062099; c=relaxed/simple;
	bh=lFI0eEchEMKu+R+nQV/UrArqCJuqSPW0BMW9JCNvBM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gK0XXqt/LgS5+p2FVxQ0e18YF/Sf70ahVlkso+H4J1VuCo/JtL3rv/NzaIZtPY6hURbfheab9p2gUZ1DTokq4tT4tSPEfVuzFiXai29HWURKqWuvLN9o3lkpTcWZAOMi/G+HCtRJPhO2gWg/7569kHX+GFFQ6CWSAzT9EokBPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+/60XOj; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+/60XOj"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-44d83e45febso580044f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778062093; x=1778666893; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBdwZqyRfUDrsE2OrGdf1oWmy0NN8ehz49AX2kgPkug=;
        b=d+/60XOjdfrfl4Ve1FjKagzn9ve6lq0JeQ6iDxXRD4JorbGlRHaG3ZdklV3rYGRB9O
         sKofZ1v9jspMw0gzZFs0PWqkIUEGYP5o5VzygaK19fvd5H4tFGniIM5rMEteVPYnguzC
         igqZIuO+3WWBRtwqVM2t+mbo/SreWj3Fdm4TfqKClE8X09/3hnla6UrFVOl6FVWxzC8S
         MXTJEMknNtUpiqh3ajCv7ht1AZx6gKGaIvKzEMQiy8v4BnZzTXDgESRleZFJGIkNQrCJ
         Rs7eP58WI78KDsP4gipYnEBPFf4kOkHUQP40AqWLX2rlQCgasl25J+k7ixc7GzpajFuy
         zGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062093; x=1778666893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBdwZqyRfUDrsE2OrGdf1oWmy0NN8ehz49AX2kgPkug=;
        b=OIq4v0R3TcLROF60i9qOEkc/piB0EBYBqkTiJdqIIrYIkPwY18UINu90mMsUg+8EuK
         k2lx/UznQXCqiG1nkyGLsSR3ik9OmMcQU4XhBqz+6tVVwYfMU+MdZ5p6VSgrybjSv7nJ
         uKyLe2tArKWoQobIWhfeI1dzP/2UH2UzcR7v/8HwA2Yc8ifcJevP3H6gaWt8PjDQ7XOp
         gbJsHFVJ8CMljzSUfp0ZwamS4DLV/93fLRcZBG3v6g7vg/Mv3+3tlFFZHA2Znn8UAofZ
         Zq8lCxiBbr6816lPZiFQR9U+SqICJwaMjDLh8pa89YtyvIQV39PWCdcmlGWcUw5T8sSX
         lIZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LtFdxyty4DfZpxXvtvZa5ZP1S55j0V6vDPe3CwdF/6ynaIsdYzanCg26pxJf3J0eRyBuU0GLxR7Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YwX23yxzDuaRsCvnvA2T4OiRi+EWMvdHPMRlu6odm9m+FV9dfak
	EPnoex9AbLyLqM5pTCuFB6E3d/z2Su3SKrexaMFF7lZu7jcqli/+qEH+bJ3bBj0wmvUue7psIv5
	PmLRMu+9gHOyVyQ==
X-Received: from wrbfu4.prod.google.com ([2002:a05:6000:25e4:b0:43d:75c2:d351])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d0b:0:b0:43d:7606:5a47 with SMTP id ffacd0b85a97d-4516247bc66mr4602113f8f.2.1778062092395;
 Wed, 06 May 2026 03:08:12 -0700 (PDT)
Date: Wed, 06 May 2026 10:08:11 +0000
In-Reply-To: <20260506075925.371138-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260506075925.371138-1-yphbchou0911@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DIBHYUZEPZC8.2X00QWHIOZP8R@google.com>
Subject: Re: [PATCH] sched_ext: Add cookie API for early qseq capture
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, <sched-ext@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cheng-Yang,

On Wed May 6, 2026 at 7:59 AM UTC, Cheng-Yang Chou wrote:
> @@ -8505,13 +8507,67 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
>  	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>  }
>  
> +/**
> + * scx_bpf_task_get_cookie - Get an opaque dispatch cookie for a task
> + * @p: task_struct to read cookie from
> + *
> + * Returns an opaque u64 cookie encoding @p's current qseq. Call this
> + * before pre-dispatch validity checks and pass the result to
> + * scx_bpf_dsq_insert_with_cookie() to extend the qseq protection window.

This is just my opinion, but I thought the point of introducing cookies is to
not have to expose qseq as a concept to the BPF schedulers (or people writing
them). This includes comments documenting the kfuncs.

Wouldn't it be better if we just focus on describing the semantics without
mentioning qseq? Perhaps something like:

  Returns an opaque u64 dispatch cookie. Pass the cookie to
  scx_bpf_dsq_insert_with_cookie() to extend the time window during which
  sched_ext will detect racing dequeues/enqueues of the task being dispatched.
  The extended time window begins with the call to scx_bpf_task_get_cookie()
  and ends at the same point as for dispatches without cookies, i.e. at the
  point where sched_ext attempts to finish the dispatch.

> + *
> + * For schedulers that do not implement properly synchronized dequeue only.

"only" seems quite strong here. How about "This API is intended for schedulers
that do not implement properly synchronized dequeue"?

> + */
> +__bpf_kfunc u64 scx_bpf_task_get_cookie(struct task_struct *p)
> +{
> +	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
> +}
> +
> +/**
> + * scx_bpf_dsq_insert_with_cookie - Insert a task using an early-captured cookie
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @enq_flags: SCX_ENQ_*
> + * @cookie: cookie from scx_bpf_task_get_cookie()
> + * @aux: implicit BPF argument
> + *
> + * Like scx_bpf_dsq_insert() with slice=0, but uses @cookie's qseq instead
> + * of re-reading ops_state at insert time. A stale cookie causes
> + * finish_dispatch() to silently discard the dispatch. Use
> + * scx_bpf_task_set_slice() to set a non-default slice.
> + *
> + * Returns %true on success, %false on failure.
> + */
> +__bpf_kfunc bool scx_bpf_dsq_insert_with_cookie(struct task_struct *p,
> +						 u64 dsq_id, u64 enq_flags,
> +						 u64 cookie,
> +						 const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
> +		return false;
> +
> +	p->scx.slice = p->scx.slice ?: 1;
> +
> +	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags, (unsigned long)cookie);
> +
> +	return true;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_with_cookie, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
> @@ -10181,6 +10237,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)

Thank you for the patch!

Could you add a simple selftest for the two new kfuncs?

Thanks,
Kuba
