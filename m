Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990373;
	b=veJKc66GgHVfMUz+UTO+XQpJKdQhoES4veMHOBHlvDUWkAQdEQPPgx2eQl69mc0Won7J
	 YFn68tlp7ec2J/t+YLTpZGKitfRXtGJEjjsxns+OWLELLXqf8nqaw8rWUtY4tNMzy2rTM
	 Eyij3Vaqf1F8x+SSelvVeLYs5H5xSzaAj0QssWc7Tn4QYKGSLER6FlxjpIKChh9G5TBjO
	 F/CIWXPLdWIbFQQXC5ldecyt7b8nrqwJaTJB3usvn8JsngI+1Ficbs7hN/eSKgOZHJkH5
	 2v5Oj9oPjNJFq0KwGXFvhp/l88cCjy0SMhf1cx+HtLb6SgKh8RrjRqwae/geDEry0IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WIwS4OC7s3U8Z4r3z87plyGX8aJlDTv0Ul5Ftw3BSuw=;
	b=DYJiyItaNTXm+UOI5CBRPRlPoGIEtYoB+fEuL7FJu9M5Qe9kIy82uuOKS6dfFaz1DQNC
	 +a+3LkkD3Fh50qWL81TM2gRyssqUo9TZg8NTN2Fc+dGVyJQHNVsVh9g+JSFAcGJJonO6t
	 2qQJ9DbE17NmcHoAiWH/ALWEgOU6b47uniD/OGLqsrupYRw0AhIXuxNrkmoccN3nqIoBu
	 sel+t5k1wo9mlZX43or251sB7WDv+NkRG2P2pxTkiwRTP+MVnUp2eXeP1ZaZocriN3D9X
	 QWCowYOdfEgB+cfA+uNimT3Lz5OKssTINCyBr9csVkAtmyJpJdMfKcW2pAwdfJ6SFSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDNsjVlm;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E052606A329
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 18:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E052606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDNsjVlm
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a59ffacb51so1040465e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990371; x=1794595171; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WIwS4OC7s3U8Z4r3z87plyGX8aJlDTv0Ul5Ftw3BSuw=;
        b=VDNsjVlmK6crAdmRepBQe35HWnph5hsKI0JqB/DL1O7ci7YsuJglRBKLkKCmx7eMNm
         MU3uN6zWuO9zY3RoVqvGKh/b/5jPpYPwlQaqpR/FzVITMFO3Iw/w0Pfe94h4YlXexGTq
         K5pN24JyWP2PT9IEru2qel5yX4TNx+Uqsz3/UsHNb0JLP9Gw8CvSTmA97OKn2ouBYyHO
         oQ0YSy4BTJDkRWTzLHsRWJezuijKO/Y649pPFE06teXotz24KwukgHuFCJ7w1tZCHCr8
         DxnfF2I7Br8doYz70F91lXgSo848H3cqKgOo6g58AWQcVuFN6fjOIffUPO8e2KKBDPVK
         Fzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990371; x=1794595171;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIwS4OC7s3U8Z4r3z87plyGX8aJlDTv0Ul5Ftw3BSuw=;
        b=BAwEKyKWLFzxTKATXCsOq9AfvQm8gNvoUuyZbeg0h9SKOvA/RUusLhbwrWd0qm8TXJ
         K59NJvZHX/KYExcW7BUEYuRLiuSEj6g3ZdwFKPWfKmpe2iSQIIb078HwU/PAWbK5lC/T
         RgTTo85nePUj4G9PFpixdsDuzM6fhJAu7nPe3Ae/xDxdrS0QkDy7ncW4DOYeBuVoGQAD
         2Bv/9RwPYudq96tC6/Ma9E0xwUrRMGD9txu0dRrLlodLbAlh2k2KcE1m2hv9tPa3s2Ry
         t3q0VVMFJioT2gDWdWJp+uxN8hCkk9BdzttPqj565c/tDwE357eQvgySkKZaH01XbhyF
         8JpA==
X-Forwarded-Encrypted: i=1; AKwUvByaFU169LRrMQ16eIkrf9hfSvbz42z8EFeszQAScGx/UjVV8/vPOnaL+3OTJ7p350/eqSVIfygWATM=@lists.linux.dev
X-Gm-Message-State: APuU4Z8AIa/W2SWG6z5PEQe5dpD6JP8M0UveVPC5vy1eKt4c3QY3f6fY
	4n73sY+1aoZGWl6qHJ0kdv2uSPwPb7GuZlZnIoTk58aQc67//rwVOd3M
X-Gm-Gg: AYBFou0SYneS1ZFuvcnlpMpd+lm5R4EMRWJaALVYlJGCaSsf2e26oKtQP9FgK1WZERp
	Fg3XkU6Vigva4gP1whFubsUUwX5kR4ucA54x6Oo8v8OewEQ+Tq3j3hKy6DE/Zh+V5du/Px6hWWV
	zuTPuGEtAy2y7Pr5AwDptIH7yV6Sr7qjvRH1PAKdialvwm/cwFfOCd23oyiWrYiqll4oik3BGB0
	zUO837d8m0JlhB05JhE0i4k7t0QBoEMBf20nYSc9wuNJdFi0PhVe2Yj7dNm2egH3UgAKPdNIdU1
	twr6BfYnU7tNwZarB5QtbZrrRQv+Wu7fjTtnxGaEhHINWCk29155i7SZ7F0gHs0iv7V1+XRSZhZ
	u+Bb16ajlZWKmj3W65fHkKS8kGxA2d4FjL0ZlCIvev1Q6ZJqvGVGz382+UPZ7SFJiRx58Wn93gv
	JJwxGPxW/HiPRTrjIqoJZNdBfMV3vhmdC4P3Li1jvyrygzDPY+t4oZ3fthnlrIRnVx8UTvCMZ7E
	Rqv+eD+HdZzrYubqFywYZZq/zFJUXrM9V+rHXKqQ0Vxm2t5Pz6i+DLFzFQJLlBWL76VW68oDq0a
	FDo+0lHu3MGocGMqiV6CkwLFVcGNbuemqfiC+asvEMXWfdsMT/NuuFs=
X-Received: by 2002:a05:600c:c111:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4b6dcf861ebmr44070765e9.1.1793990371217;
        Fri, 06 Nov 2026 10:39:31 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795038782sm4128115e9.3.2026.11.06.10.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:39:30 -0800 (PST)
Date: Fri, 6 Nov 2026 21:39:26 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 04/20 v3] sched/eevdf: Reset lag when waking up on idle
 cpu
Message-ID: <au4dOi6ASp5OnBWc@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-5-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-5-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:31PM +0100, Vincent Guittot wrote:
> When several tasks wake up simultaneously on an idle CPU but their prev
> CPUs were not idle, their final vlag will depend on the enqueue ordering
> as the first one will lose its lag but not the next ones.
> 
> Reset the lag during the enqueue if no fair task has already been picked
> and set as the running task.
> 
> As a typical example:
> - CPU0 is idle
> - TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.
> 
> Depending which task grabs the lock 1st, the behavior will be different:
>  - If TA is enqueued 1st, TB will be enqueued with a positive lag and will
> be picked 1st.
>  - If TB is enqueued 1st, it will lose its positive vlag and both TA and
> TB will have 0 vlag when eevdf picks next task.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945de0215abb..6ce4162a7703 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -967,6 +967,14 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>  	if (vlag <= 0)
>  		return;
>  
> +	rq = rq_of(cfs_rq);
> +
> +	/* You can't claim any lag when waking on idle CPU */
> +	if (rq->curr == rq->idle) {
> +		se->vlag = 0;
> +		return;
> +	}
> +
>  	/* No fast access to prev rq task clock */
>  	if (flags & ENQUEUE_MIGRATED)
>  		return;
> @@ -977,8 +985,6 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>  		return;
>  	}
>  
> -	rq = rq_of(cfs_rq);
> -
>  	/* Compute sleep time */
>  	delta_exec = rq_clock_task(rq) - se->exec_start;
>  	if (unlikely(delta_exec <= 0))
> -- 
> 2.53.0
> 


LGTM.

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>


Cheers,

Kayra
