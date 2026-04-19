Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD92D5C8E
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619440; cv=none; b=hfJLUn85WipHdJu3AqGQFha5qzZfiil+bvVyitdIB/bucv+/Dzr5oIdEWBRxh0a/j2hVMHxEhbe/NJTF25EyGP6OqhtlLVWLza5sBOvwlSrAM0vk8RcUzvhTt0nLlzQ0FfVoEQ/h+Yo9ZytikNOtfx4Nhnmq1wevJ92l5D1r79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619440; c=relaxed/simple;
	bh=z8a6fP5v1JPcuI8Zmurk8eLUfTAbQeopvyp/FVlkx8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzFHAOmhzWX9Qi/ssMOHPYdydqJRPs/0L8sPckGrB+ttvS2MupNL4P1itstmH9ZcHT7iK+zibAZqN/hFG1t2UFMsRvyAj5Ewf/0J+Ou6KDh30LszHVXZ0hzVYWUkcITlvcjTo9uwQuq4uF/jeRPlTQEtW9aZaL6NghnLo22N+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra3vO669; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra3vO669"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso1471283b3a.2
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776619439; x=1777224239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfhG1XaYczDmtGOWQsv3r0xVybiKiPWM56MZ5/oAeIU=;
        b=Ra3vO6693clLQIEas1lLp6wKYR2wF0YFf4mCdxZi5hmYJWlxQ7FlbAzLLsAekPZo6T
         j4OQIam0aewVVPeqNnuFI4e7LQpvu4IrhV5DOfZ802dHUZftkT3mf7s1VnRcgZQPFc1c
         6Hxm+xcWpSizE7iFz5sikouBVSY9YehoDM1v5TcVGjFGNr9UiRuzrdbUviLpAKC6SSvi
         2aFWxojVNG05mH9ZduSUaOLQoe6XqOPHVEgxe/dcH/5xLpssNTkYlXTz4ZQsdIIs+MI3
         5l26BzmC5Nt45pzZ4+We+Xn0+tXmQ+kPD2rOD7Wu/SBbC4yA6PMTX59JgYRPWBa4BuLA
         a7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776619439; x=1777224239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfhG1XaYczDmtGOWQsv3r0xVybiKiPWM56MZ5/oAeIU=;
        b=BlM1+zql/Pa8uA/c/vLalaXfYIEcmW090Rr9vq8R/n+u7k1dlU1sP1CSjzBxB4vwu+
         mQ54eeBhq0YRp+XCOkCk33wZmqc6itEAXzprmvyaEHqv3SWN7+7xNkZy5NG7/oGwyZ1C
         gAXxmpuv9wR89XjzOVMhvrFSypzzuQP+oppdPjrDJMSC1/3fniGS8h4r3T6PHFKcMaiT
         QEwxKFlDv3qXLaDyoJYzc1tJSMVKLdZZh4TosFMvfwEAeK8nOF77LYpWAzamWgFRCDI5
         0latXS+e/8Piwkkis/Hihjgt0/GZZxdxX1Wg9ett5oVydTrf8o0+JHZHu9nqjYXn/XH3
         v6rA==
X-Forwarded-Encrypted: i=1; AFNElJ8RMhJfmCOlUOY0qxdDqZOf5z0sMQUeMP00SZNSHHBhj4kRx659eDQKan8YePPbW0Z8+ChqDLrCKHk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzuTjCowJk0nqbkaZ0/RhA5Y9KFIHhAEcriXi5W/i8Q4Tr+ovGA
	M5bjnM/R/SBfT/zvmmsvy0jt9vcl7UHgAyP/I6p0XGvKWIdWHc9S4K7+
X-Gm-Gg: AeBDievWrn0x96nCI9V7Xo2S3JaFD5nKNGXcue698oTmAKnx8nN62+n/4RebGF95WeQ
	DwCIpSw4ZtksmCE7mvpJ6Mr/QUqYNpu7X6kG55+ps3yM6CwoT6K0NI495BmUw1+NFgTzjk7dXGm
	yv/wx788Z55IBMbRsSe5pT5HcmNjFG6Z9E2AJ83LThrEr7ukuB+sNZhbdNB2rnqAC1dgl6Ziuh3
	h3j0A87ASbhjyrFZ4zPIlvSedKVPLHw4sahQVAsTnf6/7gh2CQNmmcmiTj8FVYU4ITIuY6FHoYV
	XtOm7IPVaYFR9n/XxNt+xYnNqCkXthH2TQ5z2uzb+GlbIbaXouv2WYslv6TB8uroi2Oqjn8mEsi
	WcRo9OJmv2broKIWQlmA0NPH5y0HpEO2Dgi05RhYrNIIY8jqIuwlVhFQsqjcq59CCHnyJug8or4
	TbKV32ZRdoMIEzm8zj2aVHY1RXJabCWQW2TM6v8KyJdoVQMYIuOObk61hAjsxzi83Jw24qHmAZk
	4DWd7GHYQl/YopQ
X-Received: by 2002:a05:6a00:340a:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-82f8c92cf98mr9744468b3a.34.1776619438748;
        Sun, 19 Apr 2026 10:23:58 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2f9asm8445396b3a.19.2026.04.19.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:23:58 -0700 (PDT)
Date: Mon, 20 Apr 2026 01:23:54 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <20260420011217.G0c0c@cchengyang.duckdns.org>
References: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>

Hi Tejun,

On Sun, Apr 19, 2026 at 06:18:46AM -1000, Tejun Heo wrote:
[snipped]
> + * scx_bpf_tid_to_task - Look up a task by its scx tid
> + * @tid: task ID previously read from p->scx.tid
> + *
> + * Returns the task with the given tid, or NULL if no such task exists. The
> + * returned pointer is valid until the end of the current RCU read section
> + * (KF_RCU_PROTECTED). Requires SCX_OPS_TID_TO_TASK to be set on the root
> + * scheduler; otherwise an error is raised and NULL returned.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
> +{
> +	struct sched_ext_entity *scx;
> +
> +	if (!scx_tid_to_task_enabled()) {

Should we need to add a NULL guard here?
Since scx_bpf_tid_to_task() is registered in scx_kfunc_ids_any.

> +		scx_error(scx_root,
> +			  "scx_bpf_tid_to_task() called without SCX_OPS_TID_TO_TASK");
> +		return NULL;
> +	}
> +
> +	scx = rhashtable_lookup(&scx_tid_hash, &tid, scx_tid_hash_params);
> +	if (!scx)
> +		return NULL;
> +
> +	return container_of(scx, struct task_struct, scx);
> +}
> +
> +/**
>   * scx_bpf_now - Returns a high-performance monotonically non-decreasing
>   * clock for the current CPU. The clock returned is in nanoseconds.
>   *
> @@ -9470,6 +9595,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> +BTF_ID_FLAGS(func, scx_bpf_tid_to_task, KF_RET_NULL | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, scx_bpf_now)

-- 
Cheers,
Cheng-Yang
