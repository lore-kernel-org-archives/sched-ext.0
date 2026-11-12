Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466916;
	b=sWw8pyP0vb3jncT6robBgMa/lJKwBTx1U7/V46L2+W/2QB1EY4+sFnRE2x3U4uqNdQ2s
	 d3URVX23Nqn4CzRO1npBiTIJh+Szk1lUfHl+FSLHICKLDNnBlYpGEe/HiBVZZv5A6dclo
	 iV6T1a3d/gcjoiywEDqFfH3TTLTH3fmjtW/4uAnOIRjMkMieQrdqE0h+lPFldROdDW0Xh
	 amfvwPC9Uq+lrHGfB+Ux7ObrI4ox6RECHRnDvpoO6EfswErpXNRAvVvUZZmjs3HhhDrkW
	 IIp2KCVt/iUPnMXP2DQgqX00ee6DXI4/LkAZ45KuBK0I5E67u9TapRVkT7HU9Jz93Vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
	b=UeudOr74zpAP7xN5OCPrrKjeb4iwF1g7EyZo/qtpf6EHYgxnRdWGtTb+mvUE0vaAWRoa
	 HHBpj7n9nBnOz/TE8t9Ka8z6aUktPhpoI0HNn85EYDYZPaJRIDgYUVnn+kYxqP7xO8s88
	 22brvQ2I+328tKYZsn8whabJOk8i5Cwk4FwFQh4Yohcgkg7stih3BmV3rGa6Bde0YCoed
	 GD22+k/WvOyMRdvWTPXYvHfWmy/yE5Mm9ea1gUBpENtBuPvfDxmdEaFyIlTemSZ7UuzwB
	 Bz1ywzThVj40QQlgrcXoyk1rDzlVVrTPMIwgCgEadCdfkWadO8Iyy8tNjW8uSOugAew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h+Y6J3yX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9E606A32A
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 07:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A9E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h+Y6J3yX
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so6033310a12.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794466915; cv=none;
        d=google.com; s=arc-20260327;
        b=LuGzcXlArKC17VDxT9ULAJfiJs12aYZKC3MjS1dfZMNNm5n2cLyoVkAAOhDdLFQfgi
         UEVAjnslLHnWpNiZzWxEhDHs36aL4s7GmzG15RSpmp+rjcth2n1vmriIQQsv+Myl8xYG
         IrTQqAvIzXztQVnVohJMobHcYfc9I51HgIW2T3BTvSKJz7Bf9KaAuhxHIaT6kUKmPZll
         5OckGLMUxDoNy3S+KwLc73aaZ5rh9wE+8ulDRXXPoZfKezxLWWXLiUdLDIr8YEtOuseu
         uuC0s1GLaFR/dUKMBNKBhZwClxm8HNeTrK7TqlohPM4Yv4Qm9AAfikGYJJom/qA34jSV
         1ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
        fh=/Edl5qNJezBi9zf+addAiQK+3vhLOwOsBHdcPwuOBjw=;
        b=WDYBPE/MFfJCGFui/9y45s6mo9Z8b+Pu/yafL6/diEvc180ieSsGiWfqSK2wJdI3Wg
         +qwPf2ot4np95vfvjrJLoNO/Q0GBYAWgyfheBO8Bk+3q7pnsZISRCvF5cG22SsH/wXwX
         j4VkgXQRLSVDdObQvXbe/8LuD/Iqhljo3XBvm5pi5U07pA3YXac0NjZjDeEFmQ65sNMB
         InGU3TID5yiAUbKxA+4ZVQBx6O4fusvpF61i/2SNFkkl90pzF1OMMY2Zhwb4zFDyJs3Q
         t2VBjG+P/Lve8JcexM9Cn9KQPiimIDJLpdLyDxi6GxXT/wvuikjTrfFr9S84TFHgQSN0
         6UwQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794466915; x=1795071715; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
        b=h+Y6J3yXTvX1IG9v2l1LhO03x2g5NqIqqFK+Ni8ABeQHhdsJfG1mxUoT8ZPxke75lf
         dtoOR9ECT6kg5ZixWvIlG1LO6/jBV7eu9bO6QuUwB5cILFSpd8J8rTmvb0ZAjed+keNU
         GnVixjl4aRTOzziV+8u5PWnQxA4Imfz3Yc0vADTHV1ntstifbRdCh8z2XNiZ7tXpPIsZ
         fkgfZk5BaPcU65dObyUZnxowlMAvgt7N0M8WPXbq6C3sPM5lqMRUVHTSbHVF3hG4K+W8
         4isdza2EQ1Y03Xewg5vxWj3Hs2XWDnabgk/Ej5FPBk02sB68KJaqGDjDfQk7xHfwUnmN
         33NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466915; x=1795071715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
        b=qjiVfUoxt64/dMBeNZiRKBw3WCs5uTCFRBuKTTvb7P9ye8KXq5un0WLb/2tIu5Zx9c
         Ke3I7NkrfRSjS9k7j+IIRaKdMU/nGmTdiUnXDQgg7FnrsNnkvQc+G9PTdJkbsTx98i7s
         4I7kMZaDmnVAUdM+uDQnDHZVM0Q/Yqf0EcrugxtZrNAVXCuYE2mBLrjVP6pLRSHhh3iV
         L2tE30jPVIOCtCaQVw4CY3fFpZvDzBL6OFg+7cpq9RdzPcIO0wiPCBeKWj0alNfTfL8+
         Ls2/TaPxYm9VhYOz89wRoH18GhEJHWgDsejOBwS6OMPwcpBAGIFy4xQeu/EffXO+jPWc
         wV1g==
X-Forwarded-Encrypted: i=1; AL+hErFzQ+FtE2YyixdmZjOCCZYvam4juXxWeU8Tl1oIpTquisq4cqqD/50cKxRlvOUrT1jXSfiScySqBa8=@lists.linux.dev
X-Gm-Message-State: APuU4Z+V2jcpAsIGnqeGAy4a+je0m5zUodesyaOzqNUXIMkn6FBmGZ3c
	Nu4rkizglKto6Oy4msqFcc3p2tK3e6iZAjrnWkDd4Fk0/MeRRAhixe6h7SSMFYMmM4GXNYB2mye
	YtzeSAomBYn/Jq+Zf4spnhGr+xw+23mnkVqAQL99IOA==
X-Gm-Gg: AYBFou1Q6OPqkrM/3Uu4f52Qt9inNBGp6nqfmP2mGhCA7xQ/iat0zhHgl+dcEmcW8OQ
	cQ+ijMoAL7W8GoOxxQUOpAU01gF/Dg4RCAsnGmLu92JzH9agsYtfdOBpOZQ3c6mpQqk0svISpxN
	UvWtelNrLMEMNRe+jhJ//bx4hdnLuNaLTzrROE81MtxSLdHsGj+VZ5j/MqtntNqIor6CSCCs5Z4
	dih4EPLt2MmaBYWmGjEazwttmFYcUsLncH1ipf9nNndpM9RIFtnmM5WzDO1TlxZ7PkZHlJb/Uns
	Zbe8G56RlyQ6N78r+0BXbyz56KWT2508NRkTuaJR15pkjhmE8oT55z6TNVCsFyL47hiMCUn4dzc
	VHqV5M8LERw15e7Y56jHzbfi9Gf/EjP7qdIDfZd9QBqqX0XQZbb9PvMA75qR6WOuaymaTJA==
X-Received: by 2002:a05:6402:1f03:b0:6b5:767e:f030 with SMTP id
 4fb4d7f45d1cf-6b77733a4b5mr3291059a12.2.1794466914501; Wed, 11 Nov 2026
 23:01:54 -0800 (PST)
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
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtDcu6HS-G75bG7xp10t-n-XceneFtqxa_cAd+B96zCJiw@mail.gmail.com> <20261111085928.GE2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111085928.GE2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:01:42 +0100
X-Gm-Features: AclHuK-gkc4M-jSyE1nXnvG2bMRR6frusiPuC8UsfPnuglBYeu9svvaRxrdoStY
Message-ID: <CAKfTPtD054JHb38LdY-Dgdo4LTOVU1f80tL9hf9i629kEc6wkA@mail.gmail.com>
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

On Wed, 11 Nov 2026 at 09:59, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 05:07:31PM +0100, Vincent Guittot wrote:
> > On Mon, 9 Nov 2026 at 15:43, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
> > > > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > > > +{
> > > > +     struct task_struct *p;
> > > > +
> > > > +     if (!has_pushable_tasks(rq))
> > > > +             return NULL;
> > > > +
> > > > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > > > +                           struct task_struct, pushable_tasks);
> > > > +
> > > > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > > > +     WARN_ON_ONCE(task_current(rq, p));
> > > > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > > > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > > > +
> > > > +     /*
> > > > +      * Remove task from the pushable list as we try only once after that
> > > > +      * the task has been put back in enqueued list.
> > > > +      */
> > > > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > > > +
> > > > +     return p;
> > > > +}
> > >
> > > This means a task will only be pushed once? After which it needs to be
> > > re-enqueued on the runqueue?
> >
> > Yes, my goal is to keep the list small to avoid ending up with many
> > tasks to push. So I only check if prev could be pushed somewhere else
> >
> > >
> > > So if it was found during migrate_disable(), its thereafter stuck? --
> > > this seems a little weird.
> >
> > If a task is migrate disabled while we are about to look for a
> > possibly better CPU, it will have to wait until after the next time it
> > becomes current. This is a simple way to pace the number of tasks to
> > push in one callback
>
> There is still a worst case where a lot of tasks get woken, they all get
> enqueued and then they all get on this list and you need to iterate them
> all.

Yes but this case still limits the number of tasks added to the list
because of the case which involves short slice preemption and
simultaneous enqueue on an idle CPU

>
> If you want to bound this thing, you might as well do like
> detach_one_task(). Only ever consider the first task from the end that
> is suitable.
>
