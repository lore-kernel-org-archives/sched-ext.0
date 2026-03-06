Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D9372ED9
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829915; cv=none; b=ryIj3lJ4csBVEhzhSwj7lmIwphz7Bg42+MGRa+urIVAVpKhP4l6Tu034fB4CEuUN0juSjGqmFHUyIuc1TlxSAlvqToitjqz/TJAUtHMPTR1Vw3edS6oI+3PLDAkEMGrhUNjhPUYdoP43zAfzOQbSjwTlY3AuAU9LImUPRHXf4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829915; c=relaxed/simple;
	bh=elutkPZW/m+Hbg3tKnjsgvpmyPteDk5HU81VB/n7nlg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OV0zRMMvusgBp5m/XhW92lSSQD2EETqS3Xh42rz1lKpuTfENWwvQDRAxT4m77/JHB+qo2KhChnAywHDuixGVPhdRu0zgl9C0BJ8pvLjqXShg+8dPkR5gSn5wUA5tbw7OqG+EHWOLx8PvFdj96aW7+6HFUAqH0nGuNKWtHBd3B+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Z2sxkt4O; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Z2sxkt4O"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899d6b7b073so102879036d6.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 12:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772829910; x=1773434710; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krD/ofUXNj0qIhwSBPz6DnVjO0QOIzp7Ti+676UFGPU=;
        b=Z2sxkt4OBMdFx56Ie8xdUkrZJXgk4Y4gVKqZU90ZxDpog9PTm1uwIYqhlv5C+5VO6v
         SwmfdNBD6JwKQ8l484A/tgPjPmfux/VZqVt+Ipf79ceDTXglBErhWeVAkBYagA9APdYT
         bdm5BA/nTrfL7/jpqPhWQGVBN+qXYLRDeGpMpu47cLWdgz/e16SoFnXec1Luh2JF3TF/
         jaJYR4nLb1flDTEHg03xX82Djs3Y0SoDP8m0r4QcQTD3lzyXKSRD7fmv2PZNaj+ehYXR
         QYSgGNtBrXleDu6wHI0JeMMV25dWkdUV3ijprtLnzOOzPgCnqiI9YCYvdARWFlyEpd/2
         TEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772829910; x=1773434710;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krD/ofUXNj0qIhwSBPz6DnVjO0QOIzp7Ti+676UFGPU=;
        b=rooKh2dX9g0bXlMrreuz3id71OUAKn0nKHiy0mvHfQbIDZZZxh+fibOi33hSgLm41D
         TOY895HBxIMVGna2p5sLzhFAGSo2mbietkCHg7082qbDgdaiH4Az+QMsajCDr66U/AiU
         kS+s1uUKGfzsIgEnvlVvdQeROkIeba3PP6C9elr2Wb3Npt6WDz+TqRCRxKWw2ENhaVMu
         GZ9f7bCqw3nHl36DDy1TimtHrdyV1sCR7tbQWV3/GKhKkAsVM7TfsD6XiXg34Xtl5yRs
         GeYufMnUKyV5Q1e4PYWBN0vI7ct4LeQNYsXFt1u6T0faXmd3Gg4X9T45EVbdcnQwzYkZ
         oqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrHJ1Kx0jVSFK0LnjGOVzvGgpINtd6XbJd89UuxMsQueTJEECN8AHG0Eb1rXPTw9b7AoE2PCSUWAo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn4C4uK2x2DNHDmHKE91qd3ZnNQ9ANfcTHXcoe+RkZ+w2cLco6
	HzSCjcXZQJbinHymz6wgkTNp0w598BEJsAp6ywAiV0IuV0GRBeo+KuI/nrmXRtqitQA=
X-Gm-Gg: ATEYQzyiowLuRRTQM8aFqlquJLkZcj+peNl6r4GJF4dW08AFqlcfZFQ1cqQiR0l75Oa
	weBre5Oinfa10s/xFPfT+Gb+7dVhX1ASFQz3YNH+TsSrVEGxVMY8Afn6FyQgry8JGP6zQqw8b8C
	xZzgUErPkRe2qEcffUh1Ivh/6VZd6N/alfpqyXBTdun5MX5s9lCmlFezIk8KMpujfIt0IndcGHa
	/u5GvsYiZ20DgsDcS7xluWkhcDG6MGHHPpRH44zvFwNHZJARM/oWF44rk7J8WSu8qxCvfrF54At
	x20SBEVqMPefkpejVJHcrKGn63wzB+sMSvdz6ggFvK8vW7dkyd9SJ641w+7xdD+cxYMjF3mf7Ws
	Fzn0j8YlzxvfTfjwJh+CsLrMgzYSULKd6jccH90MZ6JbkqvXb5oeKAi5nKD3MM9oZ1I2FAt2k3z
	nVYk/7Rs8yeAXg7Bt0WC4O/Zk=
X-Received: by 2002:a05:6214:2681:b0:89a:1602:8b08 with SMTP id 6a1803df08f44-89a30a17914mr51065886d6.10.1772829909563;
        Fri, 06 Mar 2026 12:45:09 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316da91esm23608096d6.32.2026.03.06.12.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 15:45:08 -0500
Message-Id: <DGVZR4KGA1EW.2H252OKPNDR2S@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 01/15] sched_ext: Relocate scx_bpf_task_cgroup() and its
 BTF_ID to the end of kfunc section
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-2-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-2-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Move scx_bpf_task_cgroup() kfunc definition and its BTF_ID entry to the e=
nd
> of the kfunc section before __bpf_kfunc_end_defs() for cleaner code
> organization.
>
> No functional changes.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c | 78 +++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index e25b3593dd30..fe222df1d494 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -8628,43 +8628,6 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s=
32 cpu, const struct bpf_prog_
>  	return rcu_dereference(cpu_rq(cpu)->curr);
>  }
> =20
> -/**
> - * scx_bpf_task_cgroup - Return the sched cgroup of a task
> - * @p: task of interest
> - * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
> - *
> - * @p->sched_task_group->css.cgroup represents the cgroup @p is associat=
ed with
> - * from the scheduler's POV. SCX operations should use this function to
> - * determine @p's current cgroup as, unlike following @p->cgroups,
> - * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r=
.t. all
> - * rq-locked operations. Can be called on the parameter tasks of rq-lock=
ed
> - * operations. The restriction guarantees that @p's rq is locked by the =
caller.
> - */
> -#ifdef CONFIG_CGROUP_SCHED
> -__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
> -					       const struct bpf_prog_aux *aux)
> -{
> -	struct task_group *tg =3D p->sched_task_group;
> -	struct cgroup *cgrp =3D &cgrp_dfl_root.cgrp;
> -	struct scx_sched *sch;
> -
> -	guard(rcu)();
> -
> -	sch =3D scx_prog_sched(aux);
> -	if (unlikely(!sch))
> -		goto out;
> -
> -	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
> -		goto out;
> -
> -	cgrp =3D tg_cgrp(tg);
> -
> -out:
> -	cgroup_get(cgrp);
> -	return cgrp;
> -}
> -#endif
> -
>  /**
>   * scx_bpf_now - Returns a high-performance monotonically non-decreasing
>   * clock for the current CPU. The clock returned is in nanoseconds.
> @@ -8779,6 +8742,43 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_s=
tats *events,
>  	memcpy(events, &e_sys, events__sz);
>  }
> =20
> +#ifdef CONFIG_CGROUP_SCHED
> +/**
> + * scx_bpf_task_cgroup - Return the sched cgroup of a task
> + * @p: task of interest
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
> + *
> + * @p->sched_task_group->css.cgroup represents the cgroup @p is associat=
ed with
> + * from the scheduler's POV. SCX operations should use this function to
> + * determine @p's current cgroup as, unlike following @p->cgroups,
> + * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r=
.t. all
> + * rq-locked operations. Can be called on the parameter tasks of rq-lock=
ed
> + * operations. The restriction guarantees that @p's rq is locked by the =
caller.
> + */
> +__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
> +					       const struct bpf_prog_aux *aux)
> +{
> +	struct task_group *tg =3D p->sched_task_group;
> +	struct cgroup *cgrp =3D &cgrp_dfl_root.cgrp;
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +
> +	sch =3D scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		goto out;
> +
> +	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
> +		goto out;
> +
> +	cgrp =3D tg_cgrp(tg);
> +
> +out:
> +	cgroup_get(cgrp);
> +	return cgrp;
> +}
> +#endif	/* CONFIG_CGROUP_SCHED */
> +
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(scx_kfunc_ids_any)
> @@ -8808,11 +8808,11 @@ BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF=
_RCU_PROTECTED)
> +BTF_ID_FLAGS(func, scx_bpf_now)
> +BTF_ID_FLAGS(func, scx_bpf_events)
>  #ifdef CONFIG_CGROUP_SCHED
>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_A=
CQUIRE)
>  #endif
> -BTF_ID_FLAGS(func, scx_bpf_now)
> -BTF_ID_FLAGS(func, scx_bpf_events)
>  BTF_KFUNCS_END(scx_kfunc_ids_any)
> =20
>  static const struct btf_kfunc_id_set scx_kfunc_set_any =3D {

