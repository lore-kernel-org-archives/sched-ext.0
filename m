Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33F377EAC
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709780; cv=pass; b=UIv+n6+R1qJrkebqENRSLPdeM5RgikEKqlwi4nAMzBz9J082RDFvUP+VyTvSzSq8okGX4nEYlvr/nE6INrPoIaD7mblytP7UJe12c8mR72tgn8Pw71rrpaPYrwMKt+8t7k/CmygExMximJ6J49U+VXLrM7VgsVnUd1oD0d2Y0XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709780; c=relaxed/simple;
	bh=kChwFwFR0L+SFkFqPralBldVBSypL7OilC3IyfFLxV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uavCv+rQk/lAhgx6E561VMM2A/Pon3HS+PhjhlodL7KDusq3M7XBF1SvVwpeEOjocnfCfQkvGf7K1miu904FMmBFYRz6t3yqujLVd4e6f9RF52F3O72oVOA4yRMiDugCC1LbTnVsIbr1xJFGb4cVXjzi00LwrExdRlUaOO+TZNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YK8dbGFj; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK8dbGFj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso718367a12.2
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 11:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783709778; cv=none;
        d=google.com; s=arc-20260327;
        b=Bn6LoqQUONyro4mmYcI0qrI3Q4xr//3bBm4Mw1KRODhIS55dsOttwHxFJupXrPp6bX
         eTVNLV6iE27m9iYN2MrUp1SSpc3e5XeKVlXb5kCCmK1PDHzBi0tTFHXKRZajFYgtICo/
         4Oduvf+K885s1cWDGT+rHCSAPdewdBYB1EAFVrzoEGH9NwSGgeIB2HgWJYC9qqCszf0z
         A3Bp8ph0JIrpXyEKoG609NVCcBKhQ6HtBMmQxwUY9eKFt+82larcbZkeOL3kUxsx12/4
         LmgNNtcQUdoJOZzIPCLSgXJvoSIopjTGeczXM4n4OZ4feVV6pqaznE+tJzQcP9C50dgz
         yAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kChwFwFR0L+SFkFqPralBldVBSypL7OilC3IyfFLxV0=;
        fh=WDVLIlsrA5CMG+tHmf/YkXaEV6U+xXB/qiuDYirv38o=;
        b=UWfwYj4Rsu+NjgUbPDvn8HnH9IZ69LtBzppmzlivLWk5O4ZPAqjbdymBTlvgTWk18v
         jKN/mfSZBszVzcNAYom5U9lyomRnIwu6NY9uxpLQ/7JNPPfyMR2SguGKxo1PoalgptLT
         KkfQUNvC+6dB4u6F2H+AhowpvMjflYZmwAuKRLvEY1S6YX/lNykpYAvcIkT74H+Anqp9
         d/ymv/u5QcnKjZqEpwi/jzXhXeL4rwkgGMjaQTfb7d3xlTDQSPeO4OnL9JuUjm6NPU/Z
         1gch8xVY7pW2zFEyCXcIeYjnALd6wgc38A+6Zr1gw4MaXNGRPLur5U0DHpRWk3xS3cL8
         FXRw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783709778; x=1784314578; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kChwFwFR0L+SFkFqPralBldVBSypL7OilC3IyfFLxV0=;
        b=YK8dbGFjyZP8MI2UKypwiSEjgvnjavtkFNL1JiAlCRE5+bRE4DL6YxyemT3nvTuJ0J
         msXSU0Eqai1zrDbAt3UxXycAFdFTmvOf3rIU6tN9w+llTN//e+vA9GAMsmrPgYiznJfh
         qpPoi3lgoEMJMSy4Kib58KEy/NFqGuS7c5Vy+55FmuUeBSE0QGsIwG4dlVxSHo/JhJYE
         EHY+GxHvAgwJrVVhx8C933pkS1yrn6l2iA6Uh7cXMQ6GFyqdW1ui7s9oEBsq+bAp3yBe
         eK+XBnvYoBnyYtuUSyfFKXT6m6CG0ghRJrN0Ichaty7eSXLSLk4OlMZRNCjqbMsYEP9t
         lwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709778; x=1784314578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kChwFwFR0L+SFkFqPralBldVBSypL7OilC3IyfFLxV0=;
        b=aHHi6vqYXov3+2rZVe8S40D38IK/IbBXW9ksWnOEqaviLU/l2YUj+jGcg+ZWvmxcCH
         zoO0H1PTPzoNpERqsQ06e1MdSRXsTCtHR63+HwcGEOXo3ovLZ/J5/IjJ2ireUSHh9EXc
         8RrCwDFTQTPt1if2ILIaTfMDMZsgbtFiaYiet0UHR1ujztAfAsQ109fURiZy3qdY85zA
         XDb51kb8hei5Sz8eJ1hiIVxyxN9IyEp3m0AvaKPbmS20bvOTr7Y0LmLhK7uve8/FZf90
         45cd2/O/xmuoUWwtJGtuoxD2d5CjQinsbQKiOdpYwOcOzlb/iOYIZHrsIqezh6qIs++A
         0k/A==
X-Forwarded-Encrypted: i=1; AHgh+RrY2z8hOiGFfSzVqm+9Bom4byRkIIfKH9OG6fFEM6L7LBfPoPPy0JRGJ/2P+8gZg/Gj1QzmvTcFvt0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw48odEHmo3729LvP2LGBhpDLtNGy0ywrCJZ1gxMyonWUdErf0L
	Wgj0Ncym1xxGShivcQrrKzRH12LkYcZWCpJghNJpj3JqBcQWMuL78557a4PlT/ZWrBYDjQ9soHQ
	5cWie8Wr37RwORmeIg0Cm88zwnreSIEETeJbFE5E=
X-Gm-Gg: AfdE7clvxvQuvP2MrlVd5SnKt6sMUaaKm42ojHmPpvsM/zP+xbx1EcIDqsF2A5J6qiD
	NAxTYLutjbSb+fBJydr+vWrMriN8yXEWc8HqI5DRdy7h419vBKeNT15xPDBzmTKO2xLBeaqb8cg
	RYGypQp0TsCqeaYKvXCXC+t4zCxKXhEQM98yAImuiCCp4eXaDZB8YI6MTMP5KJFmRwT0itW2NOa
	Yt/e1q58Aas9WLclowSPJqYV+/yMr6muSWcr5FSrtGyNkwXJHA+gmoLDGFindkbCzf6FL2Zm+8v
	/jTa20xxrkYr4fe0XYllWgDabtcM+66JZsct05Z2mUjlkbr1zYh7HAxs7rwsWbZX+ejTK1jXJB/
	10rwSXFXM+/WyAH2cpdtPBEk=
X-Received: by 2002:a05:6300:2288:b0:3bf:a941:8932 with SMTP id
 adf61e73a8af0-3c110776c46mr240438637.19.1783709777850; Fri, 10 Jul 2026
 11:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710083913.30573-1-arighi@nvidia.com> <20260710083913.30573-2-arighi@nvidia.com>
In-Reply-To: <20260710083913.30573-2-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 10 Jul 2026 11:56:04 -0700
X-Gm-Features: AVVi8Cf_lJAovApzKK4A2mFrLZ1pRicbinlzug92rbLp8zcr9LAs-Z4DLoqFVYQ
Message-ID: <CANDhNCrR+jiW2QEDE9yhbuFEp2nfnWh2Vf-_GT9NWhSP3oSE2Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] sched/core: Drop mutex locks before proxy rescheduling
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 1:39=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> find_proxy_task() can call proxy_resched_idle() while holding a mutex
> wait_lock and the blocked task lock. Guard cleanup does not run until
> after the return expression is evaluated.
>
> proxy_resched_idle() invokes scheduling-class callbacks through
> put_prev_set_next_task(). Calling those callbacks with the mutex locks
> held prevents them from safely inspecting the proxy chain, as doing so
> may require acquiring the same locks.
>
> This is a preparatory change to support proxy execution in sched_ext. It
> leaves the guard scope before calling proxy_resched_idle() so sched_ext
> callbacks can safely inspect the proxy chain.

Thanks again for sending these out!

So, I wanted to understand more the importance of the sched_ext logic
being able to inspect the proxy chain?

I sort of roughly understand the argument that some sched_ext
schedulers may not want to keep blocked tasks on the rq (effectively
what the "Delegate proxy donor admission to BPF schedulers" patch
does), but that doesn't require deep inspection.

This change seems to be needed for "Add proxy destination query
kfuncs", where the commit message sounds reasonable, but as I think
more on it, it doesn't look correct (I'll comment more on the patch),
and I'm still confused a bit as to the purpose.

So can you describe the premise and a bit more detail as to why this
is important?

thanks
-john
