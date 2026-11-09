Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238655;
	b=C0fWlpMY5amf/Trj4XJjGjr+3p9ydLV95KvNMvRIZyZKqcCbyv/7mBcSQ2F1fdzKm9r5
	 ltFHpj91AnydikFtJYNIgeTSstslkOy1cqrAylLTuR/wd4Ara36fdIbKI44rGYGI4sNZE
	 vI+3BFcuyqoGdvZa802OoGO228GqfdaVS8TmgVk6JqqS769G382/CFzZNcJgLCVRB9iuo
	 uFwMdQAuniTEwT5x8A4NpDG4oyzZ3/ywF4+SOLExCZbDhJZTWvWLsYkqryjgeYmkt7IgM
	 u8wdc6KNeYk7LEQip/b6tW8zCBTbCi7rpJVq9n5fPf+E0vQ6syewO3X2qZOfGxOdiwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
	b=Esm8tbBGNvOmgXucUbJ0G5y1eD2ajAFDX3Kl1klfO06YOB+UweDEkjEFwiMt5vLnQFaY
	 lNu9JZ/uugQyH/oMzmuqNZ4h8CHVh7rwTi4Vp8A9h/jZNCSJ6jbF9dACF2Pw5UawGFTel
	 A9jkEQsPWfBMx3nbmZOU7o/2w+JRG/cnOHiZ36IQAEEmvpe+0BCUWiI0NWjgL6hPDtDpw
	 zPXwQfgfsFkjeXFldu8sIhxRrKu1DnB/T3ajYkENyThlpfddNjHV3x0vNbO8D7hUSoAe8
	 IefUERvxRK9XOpVNGSerwGMHOaujWTAMGBlXyb8HeFQeL9t0FDoPZS8EDUn3bN2FHPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n0UJZxxT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD51606A325
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 15:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD51606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n0UJZxxT
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1679884a12.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 07:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238654; cv=none;
        d=google.com; s=arc-20260327;
        b=MYeFODZBlkR3cNyjyZ5eXNrTV2X5uI8GLeljLZG0YKGbdH75n+czF9ijAcrHHgKdI/
         vW/JrNeUV42yhIsxRfhooGB5S05cEgqNClB6JKEtrhxjS/2qe6pt+E9gotF8s+3WqSLD
         IukgHhNxtohit02NLHyP41E578giSXI1jYSNXzgUEh21WrN/BfYLE4He6YH8/My9WYGp
         RBZ8IVAidLJSCKuoMbaB8QaEnUtjk3YfPXDSPbA4P0pAYe/mqIz4KquZddC1f3S/S1tB
         t0Hnvyo8qor/8vu9zost0UImrUG7FxP1UEJjVtBPNlNC3HSFcw7gJ2HYXu5s887mZk6B
         2I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
        fh=J5glp+N2r7KrsSZ079dKnFCWDyGkMFo1oI2E4Ai3vaY=;
        b=jBy21ls6HUnsp5c2Q0HeoJDZYZx3YLLbxV83/PSnAHr+RPNZL5/ri+YAcQoJSqfEnr
         KDXNybE5laMNdFwP9VcTSd7NWPxSE7bKQ6ITGl2I8U93HIf92YPoFR7yOu9S93mqcG46
         T3zbvuJulUMmf0njWq3nI0isnM7WcQE7OTKqGHFhRdXFa2IkVgvX5TKuwjx4Tqgd1udx
         S29cgsJSronxLdiGskWiYO96nLtA+Sug4aRSjShuyV4agQdYGckSzSkfjun144FXO2h5
         rWURj6vT6WX9IFqHiFvVW5gKbHm6pPqUadQ2CdFxXjHjhFCiIRp+AaLRyvb9ETIHvtJ3
         HBFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238654; x=1794843454; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
        b=n0UJZxxT93+Agk10vcIchy4CdqVgikbRIvUABKJyAtX9yAiW9TjVA+tdKhXF2Q3mxB
         JeC3RPPN3E+opiq8ERNqJ0JgGLOI5MUDPW7lY0DPZqC146Vm6NpjLUBnPTLWUyTaxNbU
         HzPmlKHyjkRNuFMyEssVkH7EV1xhRSn/v21nbZ9rcYfvPrvnA3hNJhxqfnp0yBE0463U
         qH8W0vwBTNWmWMM81X2Fk/HiT27V0rHAvenkHAxeOVtODEHLZQtR1Wr0kzPFzQgpHjMZ
         YwLvMjEmJckZzZjkT6NaIob9cWggXJTZxoj6wyMxTGvDlaK0GOWuNgLc/EeH1FJgeuPZ
         Ww8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238654; x=1794843454;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
        b=MHSVo84ZlLlvpDICX/NofZBnNCRahXVCtl75/cUsqgD0fDB4RP2eG/Oh++9aVetPyF
         eW2+0xL8qVFzuPyKLvVKkhvif0jwi1V9dfTEal5UGUkQrI4J9l4T4isB0Ta/tqs8i3ga
         2oc7sZRnWD9La2jqTJ7o3i/uiyfjDWN57xDIYDXT2Ra/Lw2n9GAtUUASNq8Y822Rxelj
         6G9WQccxG1McZKYd+gV8i1Pa+aUrzZ18OTLO8oLK+EgOhZu1m+P5pJgCO0HiACFry7yH
         dnu82DYuA6tdrxEvgjOzugVAMJZvCEOr0K1V8r6C/7ZJ+LRjyKPrAtmXX5i0EQebmvGI
         lUCw==
X-Forwarded-Encrypted: i=1; AL+hErHp5e5nQpahr1qoU8xbBvl2EjpKpEjtl+2y3lyyElBy8xfKeR8vCAXPiuF45RUR66wJtMe0WQRDKFs=@lists.linux.dev
X-Gm-Message-State: APuU4Z8m1UrFav96jS40kreijKQrTgQf8bab/OxXtUtIGY7+SGFJ8ewa
	2oBT6rAlqXl/e2LIycZliz7CxM7k4GauIGtPOoh0MVzwco4H175NGdp7qrs/RurG83lQhMKpz6K
	FWYJ9yWskDHyo3/rPVPIKWJAzEq3Gp4uIi5o9i1IPGw==
X-Gm-Gg: AYBFou37x4DISxDoQYeIa5SaVP6QhzZ46UAu70YdB+YguUuIViP7T/fmCzFuxlJkg4g
	thVt1KNP7yFuxFnej9U2jaUzxhky8++B5EZVPZefA/f8Awk6jeaEDdRFLDJhH+UcwRHzheTeZsi
	uetGiQT2L9EfOOPv7vp1ZxtImI33xVAIxQxuMS/B3ARJ4msOnwhMjCfp0vzSdAvrow2+rFkkt8n
	4v0El4Xr19RgGs1QkDb9luPyhpxHFk/Uf+1+gUTmysNJSuKKlJItikpMPOj5H0coV0pJRHTB6ga
	2L3OL3VwpcGgg+5UZtu8c/sDi1s2gblPZGTcP/dymOmV9/sHiMCDpNJY24rDB/2L+GPXz7G3uiK
	TzquYj47FA6g0x42q8avqMaHLY8XswJVxpHrSmwwmNw5SCoYElBfm1Hcp31mj35wG/o2DgQ==
X-Received: by 2002:a05:6402:5289:b0:6b4:602d:f1f7 with SMTP id
 4fb4d7f45d1cf-6b7224201a5mr2863676a12.20.1794238653840; Mon, 09 Nov 2026
 07:37:33 -0800 (PST)
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
 <20261106151947.3991524-7-vincent.guittot@linaro.org> <au7SabL5pfbsApyB@scheduler.schedules>
 <20261109135553.GC2668564@noisy.programming.kicks-ass.net> <avHR3lIV2TB9SWSZ@scheduler.schedules>
In-Reply-To: <avHR3lIV2TB9SWSZ@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:37:21 +0100
X-Gm-Features: AclHuK811qKUEGatxNoqg1c1GOx20pgleT3TGIXPs1QZ03pxVoNJcJkfBXVbIS8
Message-ID: <CAKfTPtCQP5uhmFOyJimoOA4zsVT5k3TUCDS28JOLrCcxoO1Oyg@mail.gmail.com>
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
To: Kayra Cizmeci <kayracizmeci@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 15:15, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Mon, Nov 09, 2026 at 02:55:53PM +0100, Peter Zijlstra wrote:
> > On Sat, Nov 07, 2026 at 11:57:12AM +0300, Kayra Cizmeci wrote:
> >
> > > (My editor got crazy, so I had to copy this diff :<)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 262626455497..8b0dd858f332 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
> > >
> > >  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
> > >  {
> > > -   if (p->se.slice < get_rq_min_slice(rq))
> > > -           return true;
> > > -
> > > -   return false;
> > > +   return p->se.slice < get_rq_min_slice(rq) &&
> > > +           READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
> > >  }
> >
> > that wants to be rcu_dereference_all() or somesuch, rather than
> > READ_ONCE().
>
> Ah, my bad :-).
>
> >
> > The think I noticed is that it will only select one slice_cpu; it will
> > not consider another once its has found one.
> >
> > This means it picks the oldest option, rather than the most recent one.

Yes, I followed the same logic as when finding an idle CPU to limit overhead.

>
> So you mean by the time CPU loop ends, the CPU that we selected
> might not be a good option anymore.
>
> > And given this is all racy as heck, the most recent one might in fact be
> > the better choice. It will have had less time to go stale.

patch 20 takes care of such situation whereas several task select the same CPU

> >
>
> Makes sense to me. So then we gonna overwrite slice_cpu everytime we
> find a new one?
>
>
> Cheers,
>
> Kayra
