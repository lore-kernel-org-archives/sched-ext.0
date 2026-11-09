Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241691;
	b=cIVps7GVQnExjGJ6q5q4vQhDBr+TI218KqP+A0doynfrRB/3Jqh4kyhjntONAj2mfG7C
	 rIH0VAnLyzsvWLl5seMih0Jq/rphc7WR0eXt2Wzcaj3f3bpJ0ZaiIxx2lPj/VH/UC4W95
	 XFZ5ECMaDc2bjqTr9nHpgHu2KWl3/Kfn/fT2VGyeAvRlkYbLLztkSYvWdHjZInhKwka9z
	 mmm90n09+T656QsLNQgb0XhyAb41vWXBhUcSSbvl+b+RnSut5h9fAk0eKMEB6RwykXnM/
	 dV1PdS7C2N55EFf/V2qXRpFyLUMpR1sYDYVDb+xxqXK9qeCwA254AqAthZhI882c5wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
	b=x12q1bp50MsIYw+7ly5I9GRPkMt6h/GnIHybofqQ+TPwkKoRZ4H7+Urd/Uvcu2+8X6c9
	 5mJlVVT0wrouzyt1LVoBM4DrWSJPO8GpnPTOD408E5g43lKS4/y74NbXPTfG3fxbkUpjC
	 lPoqcKE97ztd2Ivh6TToVDHLrIsWRWWdmzhWqVC2DSAn3p0sPu0OLS/ldacfhAHaIf0Pa
	 JsjUnKhLg0sUM3G1qu+vmI7041l0uSl2ob7bK2SIrNzQbn7fPVIEYfp0McxIGCk+J4Vb8
	 TRwkLfdnLCrnBVLCqY5bV2EbLFUrYdNt7LKQwhE3jFOFKlNxJMdEPuBY4RPgWGfLxWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=srxWjLeP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A8606A325
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 16:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81A8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=srxWjLeP
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so6511a12.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 08:28:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241689; cv=none;
        d=google.com; s=arc-20260327;
        b=OZ56AVuvNeYKOUtAjxhUokvKhoZ6Uw6s5To2WABb8BlbYXaTM2tNFpLeAoE9Z7fujU
         TEX31fSP/PHLHKFHq6WwW83Fwl7nikJJZaWaQo9wcorlHu45mhi/5LgtsIrnzWdhNFqG
         6zW4l88gVVvaLnhMVTHY8QU1LUwj9M3sdbj2+Tbsy/9L7+Q3/zj6FabbfnCUmTC4Gk4e
         +cBlT2Z2L4evBuGfEuVU0mF59WQSdSqv4RLyldnOrFh16b6lUEhJmjKWAwe6y8JEw4ew
         tOvkTukCVsUKVoQUseiGGsO+7+VM8WM+h9soLsKYiVUkL88VBQ2tXnaFewSJSZ5ttJoj
         Md1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
        fh=tM6WGaJMD+ZFYPSV8ElnSWiXxc0DzZ4X/fAsmwD5ZNI=;
        b=XL61bAFknmjo3n2iRRDKHukxOeOmVkpqbHbLtcdodAE+VJJorekuh39B+V8/hBvjcc
         sEmVA3w3xwXrW1BRmtrKVKDKX7WByHloDM6rjNJ22/TGLyl4klLebg9OvpOkCgpTbZzK
         oCa6cR+1A9iEdRnwKzeT5KYHADBaUU8uq5nIW7Lf8TnYJd1MRhNoa3RnitTtFT0rEx9s
         Yb8ONJLMvFa0Mvjmn1jKkGSEDq6GcT1+yq3IrBzmX1aKeiTBy4aciU8xnUdkiY8dUmA2
         AgpLT7RbhvjKev/a5PFlzFD9IKdlqa1CugK7FYmqDBznh6BeqOqrxREjoF9jqEag6D03
         VhPQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794241689; x=1794846489; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
        b=srxWjLePv9OIRCLTG0MRhO6jkMhswbe+4aHpKx2C1lrvROwk+kJ+6gOiwwOulRP6ZO
         UeRgYBtvbaY5zjRX3AWDdH7IBW5hb0DZrNXdBnYtS1R5ncYGfMI3+Pnk5flSJyzXJxE6
         JpmWwBie3OBH2mA7UQaMBV8apdJAEXF/MVyyd77Oh5pUyR6I8z6GtIVhaEMIWV6bLUVE
         8W61pyupIdy3MgjRon39z6PyiCwuh6jdzWsStZy1Lnhe8v2zMhsn6ORJGZ68Kydorf/2
         EOhn8oOf802YDdo3pgMXrVu54GO66Jee4pMxSb+/nKYynKcXUamRnXhN5o8clHhcIuJ1
         g91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241689; x=1794846489;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
        b=sw+UTF5L95Kx5a+k9xrqvZn0NmxR8QExwZm5ejzTJ5foBCI5/aJ9xOYwX8Tdu/EnX6
         p1YXGeA65kF44AWmWUqtO9SriZtFBdUIwdAYFAPuzMsi5EnyOkmebX6x+Z8k4qD3UNyA
         0wPDHJPyxHX4WMzXYmuoqWJG/l8iB7R+Rl0FbZeFeoN+GKFxx7dnKfMxnxoXPSty7E9x
         mv4Giy/yq1IraY0kSmxuSDT3yGQI5xfA1cm8FMkl21yTF6FExtSTgR/xFW/bhk3yF1F8
         4MJCjDcn7al0Gw+HfwQL6NmqTljNj9YNmiAolkTwLH48HjdWoDSzigBGvYi0x2XLARgP
         YtMA==
X-Forwarded-Encrypted: i=1; AL+hErE6dDRuEjW5kbVVXE0zz6OmXHKWHsY2lVqdLh8Sayd3MRGAylKm8rSQ6BTp0q7XlnXUHqPtN/6hSJc=@lists.linux.dev
X-Gm-Message-State: APuU4Z+ylWjtn7zgbLxrosWy+N8cTz5Eu/ztT/75zKUw28+7GEBpDUjF
	KBAVsUO5V81rr+1H96cFzJcdmEDtD6MZJyY+iIt3iQJHUtHjcqfMqiG8KUst0Tk76KjyI/xM8j/
	EKD8e5WzQ0wwF0UzmpIzg4tLlu7EXr9du5bOW8SHVpw==
X-Gm-Gg: AYBFou3ZlSftX8dFDmrrZ1ZrWRUGYbyDBJvc59i6lf78GcFk8/XnEzsqj77VZlbCf0u
	gJJ2cFzXE2oYseluz8+oRCbUt6G5lAtP+Gj95F/uVoWmFWSW9ws+rxjOTAkxD9dTl0gtPaP0+AJ
	4fLEsj+Jh4l+8wsyxOFLT0rt0/g2OtaGTYAREI1YLxdhKsfxQSEzh1mR7bnrI86O/8sYO6ZgbPJ
	7Ypr1n8g4VI3P3tpksnvvoppjNAbAEU0BNp0v8NBDf9lcP19e20uc91tc1qpRMtUEVN8ryRhs8M
	Rev157WtyIwCGJiXmpl8pRqsLzPAI6smsm+9tsAgnc47N7uTy5Bmbb/B3I4xM7YDG+2G6bCPSKB
	CluG83HDY35eiTUGO1gGn88X//Ewv9ttEMN9h2BhWOPVwOjZSgQDLBgYyPOe/jsE6WUjK7g==
X-Received: by 2002:a05:6402:22cc:b0:6b1:cd52:5798 with SMTP id
 4fb4d7f45d1cf-6b756b07148mr54356a12.42.1794241689236; Mon, 09 Nov 2026
 08:28:09 -0800 (PST)
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
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <au38gSTzmvPKmqWT@scheduler.schedules>
 <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com> <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
In-Reply-To: <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 17:27:57 +0100
X-Gm-Features: AclHuK-qEpP_7M7KqnfdpIA6Mgua6z_axLvPnkGDjCe32vaSEKTrZIO3tqlNgoU
Message-ID: <CAKfTPtAL9T0bGZdhkodC49DtNUFKJgEn9f5wLNBe_rGxzJEN0w@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kayra Cizmeci <kayracizmeci@gmail.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 16:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 04:27:14PM +0100, Vincent Guittot wrote:
> > On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > > On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > > > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > > >
> > > >       dequeue_hierarchy(p, flags);
> > > >
> > > > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > > > +             cfs_rq->idle_seq++;
> > >
> > > This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().
> >
> > I hesistated to make it WRITE_ONCE but i concluded that it was not
> > strictly necessary because the READ_ONCE is only used to compare the
> > value but not use it for any computation or sync so if the compiler
> > wants to do any kind of optimization what we really care is : is it
> > equal or not ? so any intermediate value that we would read would be
> > ok
>
> Right, so without WRITE_ONCE() the compiler is allowed to write the word
> in random order byte writes. When comparing only cares about equality,
> any intermediate messed up state is not equal. And since we were
> incrementing, we're not supposed to be equal to any previous snapshot.
>
> Therefore all is well.
>
> That said; we should either document the above reasoning, or just do
> WRITE_ONCE() and get all the sanitizers off our back, because I'm
> certain that KCSAN is going to complain about this.

I agree that it needs at least a comment. I can use WRITE_ONCE but I
remember seeing somethign about its cost. But does it worth having
sanitizers complaining ... I will run some tests and use WRITE_ONCE if
I don't see difference
