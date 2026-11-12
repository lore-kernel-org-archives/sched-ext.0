Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794468979;
	b=ZOOcMZEFJm5wAk4mjZfJC0LC/WLz0lqXARa2eUG6x7mOtBA/nDcfviyJDZFcIwrLNeAO
	 C2yihontOP8UmvcJzUPZx+vCIGvCFvLW9RDy9t1EITxiTVez7V3y/euabBpY5Ez8C2UrI
	 1BgU6t6feY3HLryFay/XAuImrsOpHK4DyLQ9QbvDwom7ttzDP/LRWglPlYZgOlhkeJj0m
	 7f8a29S+k7AVOIjoyHg9lMIKEc0NWHUBheDQPfaEV/ZOiUH94DDs3pZasBfd6Ki0IyY/S
	 4d/xAk8V6xXTfFU1XdWQ08v/cFOFth64lkvdYNsrTEVG5LKFf+DvlzejzdL94YT6qiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
	b=y5QfX0Ve+448bhn7TlqZccJR3TpZjkXEyb9svX37krqZuBdyyS6vz74DjqClrRP268H8
	 5+URrHMtqbm16SOsRB1hOZWSqxoWh5+v7gW/Q64Fh+THTaAprG3OGfQHUdTCx3reo/ojz
	 zX8DEviqJcOu4d6pDUaFLxaxaLdUyM7Uhk4twDj5AKR9gelAgQ53M6+P+LjPUy4sqY9pJ
	 yvY783MFvYEJi3Pzf5lv12j8c9iAzA599Yo/9btoqiVf7O321m9A8lJM7gJL6DOKDaCRA
	 eKD02zyz7zigpTuUmzE0+J5yazlveBAfkAHTkXGDs2pYiX9KiSt5TvQgal8/FxgvSWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S6bxz2Y0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5235606A31C
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 07:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5235606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S6bxz2Y0
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50715c2757so19683566b.3
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794468977; cv=none;
        d=google.com; s=arc-20260327;
        b=rbWu7Zm0Fbx2f+xlchOienHi9LNiua55h1HuFiN/x8KuSVGvPZsXJxI3aujLkPkWrn
         +YiDzB5/ml2zdtggZAvQ0lPZRJ5A5dGO+zb/s6ElNBLs5eoC6usAWmMeBONvuSKJ+YZg
         5I2EP8t9G1R62p3WU3FaVXPpTAN1FSkKd+Gl/2MzkvVCqPpx+OPUSwgAfdI+2qpa4kly
         mHSDYJck3+qa8bBnwK3nTOQ3AMKrU+C1OOKOeul+ADEz3Vz0Aa67olhT0GKaUelVoIYT
         eLpdEvX8ZhJ4GlxXGw7Q/ULa3VQT1eId41s6wgY/J9TvKtBW4lbCeOsyXP/ADTLTGdAv
         l7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
        fh=du3/rHBdPGHLw661EHjga17KoF+IrSB/Nfp7VulGF4k=;
        b=Tb/2+Nfu6onNOe3TTpwuvoBI/q9O8rNJOeCQ5oZq1PkNTRe+klDZFi6EJLvFdt1Fyp
         7+yBCjy/+Q5mO1HQRmdHhkVoGpkoUC1igv58A3tjJduUrt4kQp6RfflVZq/J0nXCer2A
         s2ZQaFmFC0/TD6e1DuIGdfTD4s+PLsFwy8cdrPiLBf1SCzC3+gpasdWtQ0V5bqaAhdVW
         khubu2wrIBLWZwEWQNyBJI/J4EiHAgHlLJONvO+Ivgz/Bh6lk1nu/Hz2dGK2KBY/kd4j
         EvRo9hM5mJWi1Qi3eLhz/YlhnlgSjpUclGmjoe0txLE3MgHYhtc2fcI8u6E6lrsoDUIZ
         nu6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794468977; x=1795073777; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
        b=S6bxz2Y0S+nouLOKdM7yllao9bckgvSlxz8yi4naLbtplqTac6vLDs96VKW4IcuObz
         yE1d3bjl+Zl5zkGzEx86enthcPeohHjn6FA5rKj/9958J9k8ZqrE9032B8Y/okppAaGo
         IFrajKjJsChCGwM5GnCsB3dvXbghct5/vNcD6d2cwZlSBPR6V2M9MEg+wLmBSbafrAv8
         hGedrVZsT4V5pDlz5GbIlZ8Zxg8LCo670/RwTGuwGF+RZ1YbmZ3XPnDnxmF1dF1RcTiP
         bTDFwZ0fnISZhn3eCCMVVzbnIIfqAGwlQ4GcvQPQY6VMENvlF1IexsAIuchGYgBfGxPS
         rKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468977; x=1795073777;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
        b=AEQCIDk8MRRnApveTMGpcj8rpQVFI088AL48WdE9KIgD4k/IcTc7qnSiRDYZJQhx1O
         5J4reYb4FWkd4EIWeLQPGuYwiq7UFHv7UeNeZJZ0GwYLLiMyHRcjU52u3qV50C5jPVSc
         a3qMOTC1sXgbIOEfNS90L+iSQgDcqYpRkFTd/WKSIrb4+/5R6iG/z2pOoMjzW/HDR9It
         eSvrTJHitPMSTHnRrSEvlV3nw/qqvBLeH6QVZlxa+1WV5xviFofNXthcr0o1khC+WQwk
         +LTRPz4dumiZpDUnf3V1yDiujRNwKSdC1qat3TGcAXKXh0KrbE6RvRJPS7g0R8TlJsrF
         Elnw==
X-Forwarded-Encrypted: i=1; AL+hErEMbaimMrSNBG3XFqqWgJE8jJBO+RdrkuLDNeu0p2YIIl0Z7t3FV63kPnbheAYVz6Yb6LeJGD6SUmc=@lists.linux.dev
X-Gm-Message-State: APuU4Z97t4BxL9KFzQ1M9cDSwOmOgRJlSLELFVcYN/Ak3YSfUgNVHVgU
	Xoxm68QCcJnLGx0NsKXv336ixixlE7UUFRnD/BXOuwOodEQbXXwwbclCTZSF3NWqK/d4rjVccmj
	67R/X5I4UBKN15MzPlVyiMmNSD5AQQhQC9lR/WxQSWQ==
X-Gm-Gg: AYBFou2pI+pS4zTWEo5lnYDtgPQ3ZmL1c2+JyeYPrP/V8sYBs7a5Z0VKPbC4jKxNjF6
	ri90tVG844QyeR/v0XyYTqVszbElwJ5LgRRYGs2K9wg5nc1/zCqbjSLvRuLUbNzcgTyuxvLxzx3
	8wgNmCbQFc5ci+4xxjZ7kQ8aKXw3UMFB1d9+oETHASUdU9VVy8gTW7IDw1oFcuqxtq9QzuvPiH3
	3eyNLolpyTXJE/EWB9k+FkChN/YJB8m8DsHPZ2TJniD05spJaHgOH1hzJqAeqA13QpPKKvdujbD
	n6x7MD2XVNTa8CG78QDSabqv17V8v6B+wXU7maRL3P3cTIbTIa1cSfyoOP3BwEza+3HFxePzfkP
	sikJakpUW/qfYtbe0KOlTYFdx+N7xv6eJL4hma0nEqBBdFDsELObGhLvmXK2mT98Pa8pfiA==
X-Received: by 2002:a17:906:c14f:b0:c2d:bd87:7fa7 with SMTP id
 a640c23a62f3a-c5066aeaa78mr354986666b.24.1794468977239; Wed, 11 Nov 2026
 23:36:17 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
 <20261111090155.GF2668564@noisy.programming.kicks-ass.net> <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
In-Reply-To: <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:36:05 +0100
X-Gm-Features: AclHuK9R2Yb38ySYLoMWNSvC_iqj6wysaQZeAeLf45aT6e-W3q4IhehrciXpto0
Message-ID: <CAKfTPtDfxesgZJ=ttSs3fqKwaWY8yt0CNnB31g2oS5j5zm5dKw@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 08:01, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 11 Nov 2026 at 10:02, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 09, 2026 at 05:14:39PM +0100, Vincent Guittot wrote:
> > > On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> > > > use that, rather than adding yet another list? I mean, its used for
> > > > migration, so excluding all pinned tasks actually makes sense.
> > >
> > > rq->cfs_tasks can be quite large (we even take a breath during LB)
> > > whereas this list should be 1 task most of the time (except during
> > > wakeup)
> >
> > Like in the other email; detach_one_task() is also just one task :-)
>
> but in some case I want to do more than one like the case described in patch 20
>
> >
> > > > Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> > > > MRU per set_next_task_fair() moving the current task to the front.
> > >
> > > The plist was only to reuse struct plist_node pushable_tasks; in
> > > struct task that is already there for RT
> >
> > So while plist makes sense for RT, it doesn't make sense for fair or DL.
> > Notably for DL we keep pushable tasks in a RB tree.

I wanted to add tasks srted by slice in a future step but i can add it
to the next version

>
> I can use a rb tree as well my gaol was only to reuse the
> pushable_tasks as those pushable list are exclusive
>
> >
> > > > So reserve iterating rq->cfs_tasks, skipping blocked and current and
> > > > such, should get you much the same over-all.
> > >
> > > Yes but I was afraid by the overhead of iterating this list which can
> > > be very long; We have already seen email about bug with thousands of
> > > tasks queued on the rq
> >
> > Right, so just take one of the tail and stop there.
>
> I don't want to take any random task from the rq but only one that is
> meaningful. Why do you think having a dedicated pushable list like rt
> and deadline isn't worthwhile?
