Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F952FDC30
	for <sched-ext@lists.linux.dev>; Tue, 23 Jun 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229760; cv=none; b=uL7Ne570Zt8RurM3HT+m/5LdwNJzulpoZ2j/KS0nBjYH8NW/lBIJSvWNiXT9TzVks9Ub55b5Yys/Py8YMZ0OKSA5O1/xl5Mpp7lalfgO+tX4oWdtKfj1c+k8nKIB1JO3qvpLKt5+tyVGOWGu+V0jaKN5Doz2I8XROoc1wZEKnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229760; c=relaxed/simple;
	bh=g9OjuwiWr9vNABcvV89aTygb82dl7YZP7O2hr7eKPA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrV4cYxXURU+SnpGgRm6Jk29Znh95lK1uYrOXDWO5z5uslzpdIzmCjr+6kCHiNk753U/TiX5Cae6Ro2dAJ2jH7W0616a2sUyRdfXxN/sOrWRtagZ4PwT755xEg4PUj4bo3etUbL4ObFJEvw35v3sEQ1CQZuzUZVl55h/pwLObqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JBt5P9Tr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JBt5P9Tr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso15523f8f.2
        for <sched-ext@lists.linux.dev>; Tue, 23 Jun 2026 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782229757; x=1782834557; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEBncOkZvwmf0mpGBSEvmRcxysNfgxHVM0De27/H3fk=;
        b=JBt5P9TrD39UlKfW6LvZFjdziKKPtHBxIUuDrCZ31nJ6xSf47LYmttpQRx339JaLUu
         KH065te8JLnvK8xDFzZhzd8DblAaLudTDOvmj6vumHhxZUTzFnVWK84xRjwcMFDbKKDu
         GCM0Y4z0R7VSU6szSx/a3uUj3beJxQyYeFSmeiIGPsKN5mHO1Cu4Q8G+nqdaEMjd6XUl
         Bwp0OFh364Cp6zF5AHUIN+50+md3nC3T5YfqmwNMDUHyx3r+YF0wsTUg/kxN/w5IyMro
         pyKL/EyTScT+xH659wURfgsQY59nr3zS02gau2KcNXLxZJxY5rCcM7nr14rEIwKJLA6C
         FCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229757; x=1782834557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEBncOkZvwmf0mpGBSEvmRcxysNfgxHVM0De27/H3fk=;
        b=CItsYfsLoG49F5KpR4NY2WKj8uUVNjwq8t8dl7G+/b37CfdUCQ1UaheUiFfg4NXn+9
         pHocQM28IdSF57UFHS0XCCFKSWUqFrn19XpRisIdv/5unO0IX+agfqGoITO5a2Vk+g4s
         wQZOc6Xp3vDIwYdhxJkMlrbC9sOAfLa4Zu/0hR1+pOHwF4VspOw9gqiv3i6v0eACVGnR
         Dv5gqQrql4BszrPonB0CCy5bb3PkBP+eJ9udrEsGvdW/uK6b7Wi+L5/zVLcCR3X3F6xp
         Vkis3YOQfUUnBva54/H5/iuv9f450UpGFcamFjqzlrx66CuftyOE95HC7qmg4Tbu4KNH
         frUg==
X-Forwarded-Encrypted: i=1; AFNElJ+YmSiMd11V2888QcLT9EYdwf9x8oT7E1THnPPBLbtYmFyctTjSluCU2OcIQmej2kYYOVthPUoNS1U=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9v/+knncgO+2HJ5Ld73+1H0DJvPMxEWWdqH6sS+MMOhhOA07s
	dR1UoCTw2je0Sw1+t/p0jf15N3BBJ4oErkncJP0L3MtE+G38PiyTN8QiT5uCo9Ie6cY=
X-Gm-Gg: AfdE7cn2WdnAycqKSVVBiMsRFnF8GRG3/73YFoYb4Cc1QtgX0V5xa7mCnXKxA5wfliA
	arE8W9WH7w8Me2eZ4PYcl33YT98UyJyaqfU+T+zl4WkoyPbC8gmilOvq1Dw9mKRv7AATwp/1pif
	dPTYK+XdqLGSNoowbLTQVWnqVwFES6J0bTk+7hIx8K5fb7jpL6nMf1ddC8++yM+1KFRadHi5lyI
	2tR3NB2xN1cyCVvZkWTq7MbJMOGcAkj/kxU3miAMOxjf3WlhPvQLLPwbNyyWub7V2A+zmutfBKn
	VRZZ5lsvBzOMaUdhFd6PSttrZQyHN80SHuWjTXMPIFi1tzF5yJjNwaSJQ4PT2R1Ri/xTiQcAkNC
	IEf1w9DVkx8JttbEzpuC1RF7lElonMLR5PAcYlVyVN0SsxWA4y+REZzqAbg4YsH19Kp5Dp3sMK/
	skixQdORcI3Y5F2FmORofNOIIfMg==
X-Received: by 2002:a05:600c:3495:b0:490:e196:e8df with SMTP id 5b1f17b1804b1-4925b3aa15bmr52076835e9.23.1782229757310;
        Tue, 23 Jun 2026 08:49:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923914fsm313673405e9.6.2026.06.23.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:16 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:49:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Ben Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <ajqq-ihAiU2VEaOp@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>

On Tue 2026-06-23 08:12:58, Andrew Morton wrote:
> On Tue, 23 Jun 2026 16:26:49 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Provide a deferred version of the WARN_ON() macro. It will delay
> > flushing the console until a later context. It is needed in a context
> > where the caller holds locks which can lead to a deadlock content is
> > flushed to the console driver.
> > An example would from a warning from within the scheduler resulting in a
> > wake-up of a task.
> > 
> > Deferring the output works by using printk_deferred_enter/ exit() around
> > the printing output. This must be used in a context where the task can't
> > migrate to another CPU. This should be the case usually, since the
> > scheduler would acquire the rq lock whith disabled interrupts, but to be
> > safe preemption is disabled to guarantee this.
> > 
> > In order not to bloat the code on architectures which provide an
> > optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
> > __report_bug() and does not increase the code size.
> > 
> > Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
> > macros. Extend __report_bug() to handle the deferred case.
> > 
> > ...
> >
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
> >  		 */
> >  		bug->flags |= BUGFLAG_DONE;
> >  	}
> > -
> > +	if (deferred) {
> > +		preempt_disable_notrace();
> > +		printk_deferred_enter();
> > +	}
> 
> For some reason the comment over printk_deferred_enter() says
> "Interrupts must be disabled for the deferred duration".  Is that the
> case for all the printk_deferred_enter() calls which this patch adds?

Strictly speaking, "only" CPU migration must be disabled around
printk_deferred_enter()/exit() call because the state is stored
in a per-CPU variable.

It means that preempt_disable() would work.

I do not recall whether we mentioned interrupts by mistake or
on purpose. It is possible that we suggested to disable interrupts
because we did not want to deffer messages from unrelated (interrupt)
context.

Best Regards,
Petr
