Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356301DE4FB
	for <sched-ext@lists.linux.dev>; Fri, 12 Dec 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765518628; cv=none; b=Takf+ZYylS6CS1La8xT/Bfjc++iHcUi3dwkz2MZ+Q2rZTbu5FMyrItJhYGloXq8RopFE010qcsY3vYYrThtPpNBdF7/KONmPimFV5ONqLan7ty4Bwp6PN/4fhxdf0DxZIQInL94nyVx0T1GfT/BD4Kujr0674FXwAfBN6IJ9lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765518628; c=relaxed/simple;
	bh=tuRbDtchayVzq2x0lXes5ITy1CXf4+nfqMwbTJ2dr88=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RG0IwDJbO+n+etKLmPJDfjy7Cnltw8DVj4bq+5GBWSHIytCyu0oIiOqxBpRh01GON73NKdV84p7DctQ1GrCwurRW+vWkF3uFNTU4pTDPS4QpZ5BUo/y/OEEfEUqS9c6UsEDvS/NDS4OToJ/wVpS5cog9njzY0I5WrHuVLEic9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=NtHXnn7j; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="NtHXnn7j"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b5ed9e7500so68323285a.0
        for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 21:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765518625; x=1766123425; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5U3FZF9RvjF/Luec6BBDXZiC46B4Lp/JwY7xrlV9Tw=;
        b=NtHXnn7jvO6JaWvN0U+O3JgfgqJunCAY4Xx2E7TcURcvHh7uJFAo9Y9shd3Wg1Eggh
         VVpbpUVg0uq2wrK5/XmQkvSdhooYvCenrOTnjVm7PisJfiJYCt58ERhYNLckPTXHH+bF
         RYiaYhbUf3KSLT8W96HQsHpSgjaGrV06OxqprOV9YcMTPl0Cu9DWV5AIuYHfsag/WBOZ
         /IAlwwLwMRJkYyyT8VyWqoAwXG9gs3baHv/pad+9T8OX6H01Xq5lxC3YWK5KzvRIH5iO
         3Hi+exZgRo1sGyvZDc5ZsS3J9tRcW0gVsYSXOGOiggGQWzpLwL/ga8PI665OkcaSo0dM
         1+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765518625; x=1766123425;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5U3FZF9RvjF/Luec6BBDXZiC46B4Lp/JwY7xrlV9Tw=;
        b=l9bckBt7ee7rsua81+9EMypxE32JFrBgbHL/RR3tTQJGRZX+PEmVaNQbdnOIleWGy6
         hjN96l9H00dHbawOzDq2bkjOOKBbRxfHQUWvvcEhIxG4CxUxZ8hCeo39bwHMsyIFHKYW
         hqFCQsDcsCZjdbSkww+7g3oqvWxYlGTYHwUJFaZOjAWrrVs4qtc4ApuT7PCzXvPQC4iU
         vdE5Znbp8LOfW2/YvGbLs30TodBa6MMLXp2XGqT7bU5GO9wt/DjQZaBb8/I49pVFTuht
         fTT5W5kdaB/Bgwbgo6menOJ28xuTkqkWy4PDEiiDo69vM8RiFc+Ppm4k1AyF8NsKi7h1
         FukA==
X-Forwarded-Encrypted: i=1; AJvYcCWKcyYRHfjMhEG4UfSm4FtAiZCoPH9AUS5QuU7Ei/i/EMG8O4Pjye5B2JUbaTdhj4blB+9TttFwZUI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOJa1vpnxmIEA1OWfpxtrTQ+moTyZ+NmO/NP3nRFDC2V93oI2y
	Wme0hgeB9Nj6V+g2gszNHOmWfwKHbLWcX8wOu0G4msRE/naYiik4hLDn7C6/7MRKX5g=
X-Gm-Gg: AY/fxX4R38LyyEDal6bJkyxxzlVhavas2dY3wAkH6efZ50aVZh4oqBtfCLnDxplWjL0
	TWH7+41KUoWo1+H87xROCpF7j7fK+4n2zppmMvav5gy91FwLXRPmNdAQGH7HbenTixQ9Rhr8JEQ
	WdkOFytOLHZr/3/1bW6ogUl8KfWsoN6VEwwWHdq2bt9Q4aiQg8qZ3LEqjsSNQjW7rBCOHFzyGxX
	dVdyWVlO9iunYfmWqDbTdpj41dDLbsOtvOU/rLH268lGsZlnGTvxEKx56fPzoQ5jjtTxXMCD2ob
	qP1Lr108hSezo4jTILuy6j6CtWY/8Kexi3TNnDkvJ/joLq4KZpbdsugZtoInrKdRf6crbmzDWm5
	yLGD30pxMOwyi2TRlAsLC8oKoKipmpWt75xOal2WFzD9Yo3pr+yLqUKqiGVMZC8XR/A2+Hmf88d
	MCUqwT8CRR+ldZiO3wTFOrDw==
X-Google-Smtp-Source: AGHT+IHqDDaEbhWB1AD1vW7kv3sMO5h7V98gD88UklizPvHXo++/ioxnBxUJrL9YdjJWKJQSrWK6AQ==
X-Received: by 2002:a05:620a:45a6:b0:8b2:767c:31cb with SMTP id af79cd13be357-8bb3a397913mr137841085a.87.1765518625010;
        Thu, 11 Dec 2025 21:50:25 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm406603585a.26.2025.12.11.21.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 21:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 00:50:22 -0500
Message-Id: <DEW04ADT6JB8.1FATMFM1JFKA5@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "David Vernet" <void@manifault.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Factor out local_dsq_post_enq() from
 dispatch_enqueue()
X-Mailer: aerc 0.20.1
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251212014504.3431169-1-tj@kernel.org>
 <20251212014504.3431169-2-tj@kernel.org>
In-Reply-To: <20251212014504.3431169-2-tj@kernel.org>

On Thu Dec 11, 2025 at 8:45 PM EST, Tejun Heo wrote:
> Factor out local_dsq_post_enq() which performs post-enqueue handling for
> local DSQs - triggering resched_curr() if SCX_ENQ_PREEMPT is specified or=
 if
> the current CPU is idle. No functional change.
>
> This will be used by the next patch to fix move_local_task_to_local_dsq()=
.
>
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c4465ccefea4..c78efa99406f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -982,6 +982,22 @@ static void refill_task_slice_dfl(struct scx_sched *=
sch, struct task_struct *p)
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
> =20
> +static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_s=
truct *p,
> +			       u64 enq_flags)
> +{
> +	struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
> +	bool preempt =3D false;
> +
> +	if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
> +	    rq->curr->sched_class =3D=3D &ext_sched_class) {
> +		rq->curr->scx.slice =3D 0;
> +		preempt =3D true;
> +	}
> +
> +	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_clas=
s))
> +		resched_curr(rq);
> +}
> +
>  static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_=
q *dsq,
>  			     struct task_struct *p, u64 enq_flags)
>  {
> @@ -1093,22 +1109,10 @@ static void dispatch_enqueue(struct scx_sched *sc=
h, struct scx_dispatch_q *dsq,
>  	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
>  		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> =20
> -	if (is_local) {
> -		struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
> -		bool preempt =3D false;
> -
> -		if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
> -		    rq->curr->sched_class =3D=3D &ext_sched_class) {
> -			rq->curr->scx.slice =3D 0;
> -			preempt =3D true;
> -		}
> -
> -		if (preempt || sched_class_above(&ext_sched_class,
> -						 rq->curr->sched_class))
> -			resched_curr(rq);
> -	} else {
> +	if (is_local)
> +		local_dsq_post_enq(dsq, p, enq_flags);
> +	else
>  		raw_spin_unlock(&dsq->lock);
> -	}
>  }
> =20
>  static void task_unlink_from_dsq(struct task_struct *p,

