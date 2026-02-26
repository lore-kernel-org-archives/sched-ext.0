Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F633554B;
	Thu, 26 Feb 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128468; cv=none; b=PWHqNtbyNToRVK0IuF2OoX+2ed9TeseebAeCZsN4fKvF9yYfYlrtoYgsOkxcgDHwL8IG4TddRkJgMLPL+BqlhgXIBHb7DUf939k2OUhjIEv/YwD+U7MKaxPCKitnQLijz/F6499Tkzz/xXVKAi6Jw/Yzct6YQ6kakTdOeH47bSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128468; c=relaxed/simple;
	bh=RceQ/ALaz1E1WeOj70jbOhcMObivrn8Ikc0jryvWRps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJPE4YXtJTeMJaUpkuQQTlRLo0Mlj/rEpZYBlunpqK1cEanlwUeLzZp2nJRkJnMopcUPAGr8GdcbPQ/e2dTfJFBnNKRx0K8rT8jPGuB1Vr3wQLo/r+r3pinEuojipglWQeORCriMaLNnFiikN5bCb9JWgkByMHFzbpe2KBWlOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMKK8bOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMKK8bOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D3DC116C6;
	Thu, 26 Feb 2026 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772128468;
	bh=RceQ/ALaz1E1WeOj70jbOhcMObivrn8Ikc0jryvWRps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMKK8bOQjyggsaK12q0dqayFbQsQGnJNjKXmko0sWwetLX5N/hw/LoneXT60sW7Hc
	 nL3tTw+zD4QikiGl7ZeClLLoMLUFPaS4lRTdyilwK1bHTeHh94adjz1sLOS9qkzPJO
	 +iWX/SisKskHRUmKSluB8AmBmBbFX5eGgKHfOXApSJofvJYmyL8CXHMTTLeWxJJrWV
	 j/DLudy6JQT2pL1R/T+wP3/0Sz+g+v/Zrf1mo8LeZSUklt9+4th1ZDYJ1a/0XC9rmR
	 cXHZFIfMcR5cLk5BtDuG5X+aVcKYOtpzPKd6F7rSgpyLtjHB4oqhLvjRo65stFoaKy
	 snnrL36R1KL2w==
Date: Thu, 26 Feb 2026 07:54:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Message-ID: <aaCI08IDGXTLvwT8@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-15-gmonaco@redhat.com>
 <aZ8snSHWw-U0lVz2@slm.duckdns.org>
 <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>
 <aaBlJT9Mac9KQpKL@slm.duckdns.org>
 <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com>
 <aaBrMr5O4455oU31@slm.duckdns.org>
 <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com>

Hello,

On Thu, Feb 26, 2026 at 04:25:59PM +0000, Gabriele Monaco wrote:
> 2026-02-26T15:48:11Z Tejun Heo <tj@kernel.org>:
> 
> > On Thu, Feb 26, 2026 at 04:42:34PM +0100, Gabriele Monaco wrote:
> >> scx_enabled() might as well be exported (together with its static key), but I'm
> >> not sure exporting the sched_class is the right thing, since all those scheduler
> >> things are quite private.
> >
> > Don't you just need the sched_class pointer? Can't you get that from
> > kallsyms?
> 
> Yes that pointer would do. Do you mean getting it in a task_on_scx() reimplementation I would just use in RV?
> I could do that but I was looking for a more standard solution.
> While very likely the pointer to the class and the class field are here to stay, having a function like task_on_scx() directly available in include/linux/sched/ext.h is less error prone and future observability tools might need it too.
> 
> But let's rewind it a bit, if it is a big issue not to have it inlined (which probably isn't), we could just go on with something like _task_on_scx() (inlined, for the scheduler code) and task_on_scx() for other users. Wouldn't that be acceptable?

So, I don't know how rv works (searched a bit just now) but from kernel's
POV, it seems to look mostly like an additional tracing framework, and
testing p->sched_class against exported pointer value seems like a good fit
for the use case, no? It's not like task_on_scx() or state testing is going
to give you a "better" result anyway and it's actually rather confusing to
use them outside scheduler proper as these are expected to be used while the
task's rq lock is held. I don't think rv wants to (or even can) synchronize
against scheduler internals. Using external observability mechanism seems
like the better fit here.

Thanks.

-- 
tejun
