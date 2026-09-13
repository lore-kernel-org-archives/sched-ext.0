Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4838E8DC
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789301302; cv=none; b=nAIHezB11FnCUkdV75tmwIkQGby17Y3JCTEH9d2LjAphsgvjQx4Jre/vPdxYsL9MvVtZs7btpPKkhGOdj1tMnbbvar6JnsxnU7Uf+j0Cvrz2g2SBlbEk/Vzph8e9VyI3S0CqqHitdTXw/gq2AVwgMXZTV0NAbB5OHCO07rRUvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789301302; c=relaxed/simple;
	bh=apY0A4WizTCP59J26TYeXZVRIhy+naRUEHiKeRCe060=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkCBvRktG0c/912kV+FcqSjqcL3p1Wu5eHBt9NmihReUlUYVWLSHAs8tdCrG93YL+FPgGs3Df8rVAcq27oSMwpZtoTZqueQMHamvFwRekjOz/fM2bbX7TXmrKb8DYyCFaCixzsQEEbfZ/S4aN/V9Orgx28oNtzOYkyrpRXMZW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsSWaSDg; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsSWaSDg"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b30c94so150336f8f.1
        for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789301299; x=1789906099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I4hlMRL7jp+sEyBR2jYI/uI6MHf0Koed1W9yy+k+mg=;
        b=EsSWaSDg1ANjv/1VbWM6yUnU714vR2v6q8Tija/OV3bqhOMoIyZk5LrKwZtwzJy9Gp
         scs8JjuZuBYOvLMDokXbV1sTbPVeZ2tWnJzEmxhKTCFoe/M+uI/FuVhqFxFnzzocDbB0
         qvqGpBR5PbqSz9PM9iHQ9KPCZrK2rBOteCWPmbXkweGpBR6jgs8bDNA+M23aoHmpUQVk
         Q5qnWmC6HtxWclvBrLyNYzVuopxKmhXCyl7quR5MkG7KPdb2TMr3yamGRlDIldfCqp6n
         w4Y68JCez8VGSx3IofhWDIHy0nmgr8fxIHOOGfUQvpynwNAfZi8EruH2ZqtqKB3uC/1o
         I1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789301299; x=1789906099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I4hlMRL7jp+sEyBR2jYI/uI6MHf0Koed1W9yy+k+mg=;
        b=ZvGEhUZ5/MpvFElT3JK6B4NGEfgvjaUyRK51iquZoeSN7oYDv/PT4WT9yKUJiQPGWu
         G10I9bVsApPmhXMV+fTAh3Ev2noYWYwKdqGmW9Du+gwF2LdTeH20O0Sj4oI1Jrz+8ByJ
         urMeJ8xZnhSQiqy++CwFkq4C1Fqo8w6DqOEwAWgKkh03/HyF6c/9hYJFwvI/34C6otMb
         oRdBAX3DrORHQ+2SPpZYMZNFBl634JkI3pbh4idMYQUUkiWgfRU68JZS3EkwNFqZVaFy
         HsjS4W9uwwWJqLmowwJRWjZD0ctyXSciv5aG5pLq36o9c281dS7xRdCscE9gt5YNHbwB
         sM1w==
X-Forwarded-Encrypted: i=1; AKwUvByk5tmjzFAX2pA7GJ8EJygwKaa/0yECNN6nt+B2mB4i+/9UeF23mfo/UO8YneJkXeDCh+pdmfpDtB0=@lists.linux.dev
X-Gm-Message-State: AFuF++mSgJZXAy/c5LD1oGYSKP7J/+PFZCxDvXesxQahm0SPneeBs57h
	0hcI7peb9Rxu9FGR5g8cmREHHluFMrEaRtpMnbI+RIxZnjm4JfZRBfLR
X-Gm-Gg: AYBFou3RYDzQJIYctmy/TNVxTXzihCF4MhIbtozvTWztIuY1kI6Z1LpN0pEC/V56AHT
	bG+WmFLE8F1BFsE3wYTil7wqojrhFFf2gjxwU6RSc6r3QHzrTkNJjvbpX8utpyatTcQSkxV/CB0
	LpcUPlmFT6T5XM0Mfgk8Je4Ox/tcG+CqtjAv3GxHQ3KIUtHL5fpVW86dFOmP0KPqRPHv1dDqyOY
	UTXbyJeRRriT614/pAT9+5DRmd+ZQegHQR3cMbbOkYHjFSECmHbuuwVI1+T9qDECf5AI+rZ4lzq
	5bzKNa8HVenueuRTXT8Ddd0IsfW3Bi5vZGeS3vUM0qHFx8a77FkEx3zZ+Fui6RqykQQ21A1LsVo
	At+Rnc17El25THoMYLERQcrM2tb04dnn5/QYgrQr1nCX29HdMQEd0c3MdEQi8JXa8vtvCQW/eVI
	iwTnLOCogWpQN3fQ20IKwvDFIiVg4aOsrOsSA6qOQkk9kXKwG15IeioBrpZqU3UwkEFMrg82PSV
	TlPuIc0MzC/kmvfIuoC
X-Received: by 2002:a05:600c:4693:b0:49c:e363:c66e with SMTP id 5b1f17b1804b1-49e619abd64mr128256425e9.1.1789301298845;
        Sun, 13 Sep 2026 05:08:18 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e35sm304455095e9.2.2026.09.13.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:08:18 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: sh_def@163.com
Cc: arighi@nvidia.com,
	bsegall@google.com,
	connoro@google.com,
	dietmar.eggemann@arm.com,
	jstultz@google.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	soolaugust@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH v5 1/4] sched: Dispatch task ticks for donor and execution classes
Date: Sun, 13 Sep 2026 15:08:14 +0300
Message-ID: <20260913120814.1273086-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913064722.1534766-2-sh_def@163.com>
References: <20260913064722.1534766-2-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello All, :>

> Proxy execution can run a task from one scheduling class on behalf of a
> donor from another. Scheduler ticks therefore need to reach both the class
> which owns the scheduling context and the class which owns the execution
> context.

So, donor and curr's classes may be different and we should call both of their task_ticks.

> Calling the donor first preserves the existing runtime-accounting order for
> execution-context consumers. Keep the existing class-specific tick behavior
> donor-gated in this patch, so the change only introduces the new interface
> and dispatch mechanism.

Hm..

> +/*
> + * Run the scheduling-context class first so its runtime update precedes
> + * execution-context tick work. A different execution class runs second.
> + * Same-class proxy execution gets one callback; ownership-specific work
> + * can select rq->donor or rq->curr as appropriate.
> + */
> +static inline void task_tick(struct rq *rq, int queued)
> +{
> +	const struct sched_class *curr_class = rq->curr->sched_class;
> +	const struct sched_class *donor_class = rq->donor->sched_class;
> +
> +	donor_class->task_tick(rq, queued);
> +	if (sched_proxy_exec() && curr_class != donor_class)
> +		curr_class->task_tick(rq, queued);
> +}

>  #ifdef CONFIG_SCHED_HRTICK
>  /*
>   * Use HR-timers to deliver accurate preemption points.
> @@ -923,7 +939,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
>  
>  	rq_lock(rq, &rf);
>  	update_rq_clock(rq);
> -	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
> +	task_tick(rq, 1);
>  	rq_unlock(rq, &rf);

So. Let's assemble a senario.

rq->donor's class method will be DL, and rq->curr's will be fair. And the sched_proxy_exec() will be true.

ON THE OLD:
Only DL runs. That's all :>

ON THE NEW:
task_tick firstly runs donor's method. That's DL. Then we goto curr's class which is fair, and run that.
But because of the newly added checks, because of the donor's sched class not equals to the fair's the code just,
doesn't run. 

Wouldn't it be better to merge this patch and it's use case together?

The commit message is confusing too "Scheduler ticks therefore need to reach both the class
which owns the scheduling context and the class which owns the execution
context." But the patch doesn't do this on it's own. 

Thanks, 
Kayra






