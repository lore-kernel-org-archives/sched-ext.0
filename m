Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340574;
	b=xT5iMJJEXwtuWThQ0aBqDAjjZXAkpfPtLDUxBa+90+HVQ76TVHVhoqWgHKLhyKaawBe5
	 dZzw1Inti/XevlYT+duQZRWTcyr8VPyi+apkHWQQnAqimriF8kHqqAx0SBAV0vXChksJ4
	 ft6LAY4iZgvHTXxEMQjBqjAdyXfXcd21XWU1nxZ3CFA+lS4vSO9Nb6yGW1ng8HEPzvzhJ
	 hgn402OF9woLOPsWjQflVuoWxuALlPlE0xVjOyIdDYC6cUFphLL0mgsJ1ULEKOd5BNdU3
	 Pz9IfN3TV6RJSa2X0ov/TI72h2eNGKiNn9vIkHt0q7mWCrce99BFYPzW62Hg/+wjnBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340574;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4e9zTEEepAH07YcZ7jQL8z3Ph2Jplxj/qCJ27ebIFzk=;
	b=ebVkNMhoDRC36rOjsqPaSSG7XvwnruS/ZMZx7722oBliHidKMbCn/nXw5BffrNen2nrQ
	 Q634j7MAPtMrQ9p9zUyBLInTSJSIstIRpK1/DO9YooKdiv4CJG/WjSnuVCfXcThSBk5N6
	 cI3pS23KFDmlCtaIQYIOd5zU7BKX7asSC+tqBbdimLN5SbLhMrZwS0MWjOGpAFuiUk5TG
	 hPH/laiV9WtwL5XO6WflOSnATTaouIgjNjUHnuhI9jdZM/HUNpU6vtOuTwWc0OlBTXM+n
	 wD+QgCHFsaMKeTSU9QY4Y/2ydxtLOnDXH6Q9Gvt/qYKMt88KOXyYdJUK/UnFwEH8sDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg5Faxr9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BC606A326
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg5Faxr9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349631F008BC
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 19:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340574;
	bh=4e9zTEEepAH07YcZ7jQL8z3Ph2Jplxj/qCJ27ebIFzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cg5Faxr9v+zaSU1I7eWru+ybfPtVRmrNfap/AxS1DesuT1U3ymnw3FbJBp0/Y4PF0
	 Vpwaabish9VkJVp4qp9kqbJTNM48JC7Lob+NV73I3VmpFr0lVS4U51WePY8svJ/q/0
	 BnF6AfVCJB/c5LGl+rgFGGH7apLWY56LmjtWyk0uxIJ1/Q+PyQEADiiYqdcEKpidPv
	 H1DkVOT2g6swHoq5YJ3ec5OCJfmabgQnp0uTi1836mRBKR+371sq89cHtJVddn+giK
	 lHnzlRFL2PCbRHVXngUtsgvDKBv2oMK9ALhH39kIHL4v6SP1cwq+Vdf0aGe+SI0FDs
	 MSO7iY7LZBepg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso2215504e87.0
        for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 11:56:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGnyQNB34RO0iav2DMbnzi9C/yPW9EhSp6uya7BqdWXKxBqYuNnSBEcsrrZkLuN+GqYIxateNjm5v0=@lists.linux.dev
X-Gm-Message-State: APuU4Z+QauWUnbLyGCymohoGldxiyerAakt3S1d+V6r2BYLpYN2dSgdz
	grBzc3KprGz48P6w8ifU2lnFOOw9oWj2M2wDsdB7U9d9BGdK6TKXCnQDLnRTgNiA+1GRpE5Xqpa
	7nuVAfkIvRsGdZtbTYhgVXTMzoKeZbK4=
X-Received: by 2002:a05:6512:4023:b0:5c0:46a:af07 with SMTP id
 2adb3069b0e04-5c15d633aa6mr41569e87.24.1794340572514; Tue, 10 Nov 2026
 11:56:12 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org> <20261106151947.3991524-17-vincent.guittot@linaro.org>
In-Reply-To: <20261106151947.3991524-17-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 20:55:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9MvRWz276XfR+FK+jZTyj88CEpV9i-Vtb-crhXLswvg@mail.gmail.com>
X-Gm-Features: AclHuK_hRY2h3ib4gYJGswYHP1kc8kMT9CG7yVECgP2MQJGZ6hr3Nt_oO0vb9a4
Message-ID: <CAJZ5v0j9MvRWz276XfR+FK+jZTyj88CEpV9i-Vtb-crhXLswvg@mail.gmail.com>
Subject: Re: [PATCH 16/20 v3] energy model: Add a get previous state function
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:21=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Instead of parsing the entire EM table everytime, add a function to get t=
he
> previous state.
>
> Will be used in the scheduler feec() function.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

No objections from me.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index c909a8ba22e8..89cf109cbca6 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -224,6 +224,26 @@ em_pd_get_efficient_state(struct em_perf_state *tabl=
e,
>         return max_ps;
>  }
>
> +static inline int
> +em_pd_get_previous_state(struct em_perf_state *table,
> +                        struct em_perf_domain *pd, int idx)
> +{
> +       unsigned long pd_flags =3D pd->flags;
> +       int min_ps =3D pd->min_perf_state;
> +       struct em_perf_state *ps;
> +       int i;
> +
> +       for (i =3D idx - 1; i >=3D min_ps; i--) {
> +               ps =3D &table[i];
> +               if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> +                   ps->flags & EM_PERF_STATE_INEFFICIENT)
> +                       continue;
> +               return i;
> +       }
> +
> +       return -1;
> +}
> +
>  /**
>   * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
>   *             performance domain
> @@ -375,6 +395,18 @@ static inline struct em_perf_domain *em_pd_get(struc=
t device *dev)
>  {
>         return NULL;
>  }
> +static inline int
> +em_pd_get_efficient_state(struct em_perf_state *table,
> +                         struct em_perf_domain *pd, unsigned long max_ut=
il)
> +{
> +       return 0;
> +}
> +static inline int
> +em_pd_get_previous_state(struct em_perf_state *table,
> +                        struct em_perf_domain *pd, int idx)
> +{
> +       return -1;
> +}
>  static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>                         unsigned long max_util, unsigned long sum_util,
>                         unsigned long allowed_cpu_cap)
> --
> 2.53.0
>
>
