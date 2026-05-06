Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1C280CF6
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071153; cv=none; b=sZFZQntS+ygbKKElXJmLLq4kmYqeRliIyFVtVYqpxXdlSYbu1A5vHLXalpbr2EbyJaTmdYz2/DhWzO0ClBg0MLj24na1Qu9kaOws1kdvWF9O61coLqVl3/MJytlTO0BeR82n50dpNoydq6Dqw5G0DU91UQdtCYrdmPVxLU1ZvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071153; c=relaxed/simple;
	bh=6aVf3hBd1njvafUNe8qoYigl8zYzXrLTECa5MrQ+02s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9L/Kqtr4PmBbMRiTWd9Ds1eYgv8i7Y9kBXenpgECUVKQe3qjqzSIJN8K9ZHmQ3gwRcf5cj3huUbfGSflthUFyJu/VFUMovo55uQeI7hejvHXU5JaeQg9VreVLPpXfeR9qSy+JLW6zrxP67p/howg53qTqqiD35Lf7t3uTcOl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0mnA5nx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0mnA5nx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b45cb89f7eso43421155ad.0
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071152; x=1778675952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0z2EuODL1URzPbsKA4yJkFlSnAyNZdCFJpUKyBKPt6U=;
        b=H0mnA5nx0Q02aZFgMyMguRUHSW+p/uCaLdVS3VUaSQ2C7Ja6cK1ENQ5ZnCJPOvc2T1
         kp/fAmqttQ3+av3VTkbzyW8PyUu/cIgqAhhUIVzozJGAcEptd+XWsHumhfls/d1PpLS+
         9eiShnJmztwNqQmnoni8e/ZWVNMcdAgjEFQfl/f8JO25ijgiiITseq3fRWy4HOLq7pb8
         Ik8a9MS+R80tM82g6FI/lg+LTUMZJuwQwcKR+Q+apQa4Axsy3lajbZ5FKygo7WdPV6IM
         doft9579WQRVW39UznKhVnCMuh70F6J3XYLDPwp+4+itXrlrLSThyGLm6ui59AWlErwv
         xLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071152; x=1778675952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z2EuODL1URzPbsKA4yJkFlSnAyNZdCFJpUKyBKPt6U=;
        b=WjuBo3rRLRdCQkaLcWJJiXpPbsKeMepr9QE6WFDZqBbXdvAGZs32A61jrJWir3Ruoh
         iJ71b1YaXM4JF4LGqLZeukYPdt7Qh0xLteWBkJkI94wGZGhTY6DacGv8dWHCBeyKGlVT
         5RCW6ehIkwwkc8m5TZsFVEwvsvokcs2Smfg2tyoGLDwrXFnJFCPmtk+9i8a70KgDBiIm
         SE4+aYpiNIO0c+0gYSRovQPW025xXYM3RIt/4mqHnarDKpHvX0POkxts+EX3nWnqdlKZ
         F8B3p0nncGPx92h/5f6mDAP2NKvMJqVgqk652MHuEOib9d4lt9EAKOa2d3IRf9nKlut0
         RKWw==
X-Gm-Message-State: AOJu0YwvMQTgUiGdNDX8EGp1PsX6Pf8ISNckIW4rhypfXHmXOdtNA8nN
	o4VtzJ6fhbkbZMlx/QUSMbsKNBNY1cVhjbuSzI+S0SRK1LzGmAcqLXg0pW6uBQ==
X-Gm-Gg: AeBDievW4gE93bYEGdX18F1zxqznBinZvnmLC33rzJrf4OufmOAOd0TN+a8e7PNAxZG
	Sk7SvQ8bOWzgbRYzBdtJpXLuPpK34dhz6yONrOiunemeliGYYh4FIWBfZLJMdvknsTVSS8S/TKo
	a7Py9y6jBmpE+AZwh8qUzCUlFWjEya7Q6Zex8Rbuk5OnSbnKA6lN1Y8ue8sC2a+hqqn0rxTR/Ye
	sxGHwG6YjuxeLIVQrESBGuwvyOFVjtMcoKLHh/SWNkIgepTJyT6QiqHbwT/VCOqsCcNMqSrlnUz
	cxbFn6E7yCGDKD4ODwhdiW23rigOhIKk0c47jIaHns8Ld6dADDD63H5+DDNp1ODuyPoTvUvI1HI
	V6hC6xapsljvorrCLsXvapYGlEIQgBpo21lgLEdfUSxQREAvE9rLtAXrFAUhQwEZ6A40NG6ZpgD
	4mEwfkPU8p8fmpInfjQvnU10rrdHIQj+3MAHa/cwKPgJM1Jon2cMAx9OyY2wDSBRAhhw59M6TJm
	gcq8NkoBR17Bvzr3ytCGaJEAjA=
X-Received: by 2002:a17:903:4b04:b0:2b9:41ac:d07 with SMTP id d9443c01a7336-2ba78e40756mr29682785ad.14.1778071151543;
        Wed, 06 May 2026 05:39:11 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-99-238.dynamic-ip.hinet.net. [36.225.99.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca216a9sm25109335ad.70.2026.05.06.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:39:11 -0700 (PDT)
Date: Wed, 6 May 2026 20:39:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Add cookie API for early qseq capture
Message-ID: <20260506203254.Gee3b@cchengyang.duckdns.org>
References: <20260506075925.371138-1-yphbchou0911@gmail.com>
 <DIBHYUZEPZC8.2X00QWHIOZP8R@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIBHYUZEPZC8.2X00QWHIOZP8R@google.com>

Hi Kuba,

On Wed, May 06, 2026 at 10:08:11AM +0000, Kuba Piecuch wrote:
> On Wed May 6, 2026 at 7:59 AM UTC, Cheng-Yang Chou wrote:
> > @@ -8505,13 +8507,67 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
> >  	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
> >  }
> >  
> > +/**
> > + * scx_bpf_task_get_cookie - Get an opaque dispatch cookie for a task
> > + * @p: task_struct to read cookie from
> > + *
> > + * Returns an opaque u64 cookie encoding @p's current qseq. Call this
> > + * before pre-dispatch validity checks and pass the result to
> > + * scx_bpf_dsq_insert_with_cookie() to extend the qseq protection window.
> 
> This is just my opinion, but I thought the point of introducing cookies is to
> not have to expose qseq as a concept to the BPF schedulers (or people writing
> them). This includes comments documenting the kfuncs.
> 
> Wouldn't it be better if we just focus on describing the semantics without
> mentioning qseq? Perhaps something like:
> 
>   Returns an opaque u64 dispatch cookie. Pass the cookie to
>   scx_bpf_dsq_insert_with_cookie() to extend the time window during which
>   sched_ext will detect racing dequeues/enqueues of the task being dispatched.
>   The extended time window begins with the call to scx_bpf_task_get_cookie()
>   and ends at the same point as for dispatches without cookies, i.e. at the
>   point where sched_ext attempts to finish the dispatch.

Agreed, will update in v2 patch.

> 
> > + *
> > + * For schedulers that do not implement properly synchronized dequeue only.
> 
> "only" seems quite strong here. How about "This API is intended for schedulers
> that do not implement properly synchronized dequeue"?
> 

Ack.

> > + */
> > +__bpf_kfunc u64 scx_bpf_task_get_cookie(struct task_struct *p)
> > +{
> > +	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
> > +}
> > +
> > +/**
> > + * scx_bpf_dsq_insert_with_cookie - Insert a task using an early-captured cookie
> > + * @p: task_struct to insert
> > + * @dsq_id: DSQ to insert into
> > + * @enq_flags: SCX_ENQ_*
> > + * @cookie: cookie from scx_bpf_task_get_cookie()
> > + * @aux: implicit BPF argument
> > + *
> > + * Like scx_bpf_dsq_insert() with slice=0, but uses @cookie's qseq instead
> > + * of re-reading ops_state at insert time. A stale cookie causes
> > + * finish_dispatch() to silently discard the dispatch. Use
> > + * scx_bpf_task_set_slice() to set a non-default slice.
> > + *
> > + * Returns %true on success, %false on failure.
> > + */
> > +__bpf_kfunc bool scx_bpf_dsq_insert_with_cookie(struct task_struct *p,
> > +						 u64 dsq_id, u64 enq_flags,
> > +						 u64 cookie,
> > +						 const struct bpf_prog_aux *aux)
> > +{
> > +	struct scx_sched *sch;
> > +
> > +	guard(rcu)();
> > +	sch = scx_prog_sched(aux);
> > +	if (unlikely(!sch))
> > +		return false;
> > +
> > +	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
> > +		return false;
> > +
> > +	p->scx.slice = p->scx.slice ?: 1;
> > +
> > +	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags, (unsigned long)cookie);
> > +
> > +	return true;
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >  
> >  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
> >  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
> > +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_with_cookie, KF_IMPLICIT_ARGS | KF_RCU)
> >  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
> > +BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
> >  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
> >  
> >  static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
> > @@ -10181,6 +10237,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
> >  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> > +BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
> >  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> 
> Thank you for the patch!
> 
> Could you add a simple selftest for the two new kfuncs?

Sure, will add a selftest in v2, thanks! ^_^

-- 
Cheers,
Cheng-Yang
