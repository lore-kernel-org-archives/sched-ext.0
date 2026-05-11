Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6B381B1D
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535922; cv=pass; b=tCsmLdwsts+7S1qnyPGjQ50YNwhvXV7hvUkTcBVi+FeoUuzVaeqVAjPHVZ7Z1g5vSDUm0JozF8HxUCOScqC8u1EYR1G6NlG3Ju5QXS77azC6WeXU2W1LaCAXphemDcxMZG4YJV+D+VcH7pi/gNH4x4+7gD3z2MxmKXln3lk2sbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535922; c=relaxed/simple;
	bh=1jxVlMTuyh+V6ULjH/E1BVkWLBDoxONf7vVMF3j55cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfHtLnljMmGtWIakWoFHuwSX1EqBMMboPH2J8RCiATn+5QmBswHNgHwM0viVQlQAjb7SIcOD8HsIgGAGbCbIvd4aT9/Wp+Xb9KewH/TNNyHEL9hAghBVDmkQ3TnqpIlEASRPNZ6IQcegbfdXKOKNORxImG/+uWESufRx2xp/bgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2IJrZKw; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2IJrZKw"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4891f625344so45739445e9.0
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 14:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778535919; cv=none;
        d=google.com; s=arc-20240605;
        b=LUpO6QGcy8+Byt83aCqbTsayFeIFfHL5a5Rl/qyhLX+kXD08Fg05Qrz6Dq27UhK+YH
         6vQmgPE2ZxsycnEGOJzzQBFGpyF3X1ygqWCq1VN1F+gN/6XJ69LannZRN8rfG+1Dy5xD
         IwzXHao3xX6qMoYj+vedzes5ntznthrhgrtA0uGTifXpFLPNBPOt6R354lLAABHokPoU
         reKMuN58vAuomnl99/qqolf4MAjMGubCw+RYJNotILPDMqEYKA56wCH2lzdp88BL2RF3
         xz8xHhuZ2UgUl9Y3anEw543gsngib6Ge7a1QgQ47b6vdK1ah33ehdVwmXha8HH0AX1Lz
         8Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DCb8mLBaUUyi/AdLKnWPEWx/s5sJ5fwujB6Wz/0osO8=;
        fh=oXgfUSNyz6xS+nOGIdicRnqOQww98T6tIKLASX101NY=;
        b=IptDgHFhB5zwhxSL/g/WSahQU7XYSWRabgaIf5k5k4oz544h8PJw78syRzBJKbDEvd
         kCth+5A7X6K4mC+Y+ySt5ZqPmfngxtO5daixTerzLh1yX3Yv2fx1xC+HXd+Sv6m1JGKM
         H7fIzJ7rS7QPylkcTBFz1cTzTPAeFNcuRB/opW5UkCVUUmHsynqDujtGWBznj5pt5qJI
         oCsURWWkmoHCcKkQ4gCCWiE6/haj8L/l9uslh3CRbcR+JsxsIrmhwJpGFKWsyy4h0tbV
         th9gGr57kfF25mihKBT4G+IlLDYTMdbb+iufZpPz/wu6lk8GWLJ2f7Gv9dLCHM+lQXT3
         AogQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778535919; x=1779140719; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCb8mLBaUUyi/AdLKnWPEWx/s5sJ5fwujB6Wz/0osO8=;
        b=d2IJrZKwddWy91xQV1vM+iZWG7L575qRobUsqMklHydHftEq5O+Oiy4RTrKnp5tLVT
         n6rywReQnrntyftfNzlXsZe3ZK3l8gUnYenqf1yLFfV5YX9g4O6doYb5kTlLCdLsyKWX
         eoyTIEs0dgzBeAajDiNz7M07/NPxCKdn5XlfHjoJzgAvNGS76Batl2W4uge4JDKTn0cb
         k95o2NZ5Rl13I25wFzAcYyOn523nEkdVqTgoQ+1IsS/BUvFH4mHOkAXqxx8NLFg8ZA7m
         Y5N8+u2hjgrPzz43bGv3Xn01po/0NCWbXf9so/pGAwJG9segpFinvv666euwjsXcT+FE
         RvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535919; x=1779140719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCb8mLBaUUyi/AdLKnWPEWx/s5sJ5fwujB6Wz/0osO8=;
        b=ALCHrtfpaAvJaViBrUgztc06aCBBy4SDPaAJyFXVSJ3b+YwZKVwZpeYP5bJi9eced/
         D7D/ClLZPeROpD5JH4xWxT1zqecy1TgyZzokOs9BM7sFrybGvrhb4648g1cdMg1umtrb
         dtWCysce/+DMX1RrWK+Hfa34t0FFx+Es7U2OtXSwG22jXYTMBMKUHEzi07pxertHwc8S
         8UYsr1hCY+MQF/7k3Hs3P0W8ORXQ7XkTWLFb0TSOWczEvzPElgxpA1MDza0Zn6PYRDDo
         5I9gzRgVmkJ3HN/lPht2/VFZgot94P/ua0eJlAjDoQG3QhydLY0FMb2XEHkyIBtQgOr3
         1oig==
X-Forwarded-Encrypted: i=1; AFNElJ85LlvIvbQYnpe3rssUT/8XzVTvg4HRYfIpfW3ModmHznZUV1a4UT42C7L7lYCjwplSrus6V3+Mv4Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YzhJeH2JC3X8EH/z/1R6R2Agj/j0l5I17CQ/71aUupKUE6Rzc1M
	1950nvATOueVTmn/2qhQUEi5fJ3UzMQeoH1fBleq9hzgQnq28SHQH0PlYaDDjrTeNx11Fo0jhOS
	rnzWkiftGmZ7Fvbb2F1XOhLs1BpBff5KMhgPI
X-Gm-Gg: Acq92OFsGsMRDeE5I/95gVFhxzX365H1yhBHq3cWGrdojGPjTPUiu45NH+8JV8jqJwP
	uXqw2ruZkwbncb6zCawCs0WpJY/2fhe1h8cCPcdklG2EQzzajofX5gVaU7Pv9qrDRRyKMFVTUCd
	A1O3mxNa+xB9/ibhp+5wwlIVnpZCPkoveRIsFdkud5jd90/BbRBu4zjae+As9lnB7wG+rdRRM1r
	4wdIVYFP9ywL6Y9pMrwepPH8j5yQVHTs9ig6dPgZLbZo2hMCGQnuwi+ejAcNNHP1X18wNjKYy/7
	LCWh++95XSE6thyJXZwjPlXEEfkhznlVfGTAAubvouxn6rT1w7nFbaudVIL3jJPPdda5cpoy1tQ
	/evHhLnJk6Ppsy21elgEZfg/v/z/DmOEzYqTH4K0KXjyxuLExugA6xiIuKA==
X-Received: by 2002:a05:600c:4f53:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48e8e217cf4mr16970785e9.14.1778535919376; Mon, 11 May 2026
 14:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-6-tj@kernel.org>
In-Reply-To: <20260427105109.2554518-6-tj@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 May 2026 23:44:43 +0200
X-Gm-Features: AVHnY4JM0cTM4CzCxr9EHkQqFmjxgyQr8U4LgfIjjLOFUJriEF0ECdKTclqEquA
Message-ID: <CAP01T75ATTaXSXcCV396R0YhKN37R7-cjxMtZCdtW038u=agTA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] bpf: Add bpf_prog_for_each_used_map()
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>
> Wrap the prog->aux->used_maps[] walk and its used_maps_mutex behind a
> helper. Existing in-tree callers open-code the same lock + iterate pattern
> (e.g. bpf_check_tail_call in core.c, the verifier and syscall paths); a
> sched_ext follow-up needs the same loop and would otherwise reach into
> bpf_prog_aux directly.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/bpf.h |  3 +++
>  kernel/bpf/core.c   | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f4e4360b81f6..587e5ff387bf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2338,6 +2338,9 @@ static inline bool map_type_contains_progs(struct bpf_map *map)
>
>  bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp);
>  int bpf_prog_calc_tag(struct bpf_prog *fp);
> +int bpf_prog_for_each_used_map(struct bpf_prog *prog,
> +                              int (*cb)(struct bpf_map *map, void *data),
> +                              void *data);
>
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
>  const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 066b86e7233c..aa590a817176 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2510,6 +2510,35 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
>         return ret;
>  }
>
> +/**
> + * bpf_prog_for_each_used_map - Invoke @cb for each map @prog references
> + * @prog: BPF program whose used_maps to walk
> + * @cb: callback invoked once per map; non-zero return stops iteration
> + * @data: opaque argument passed to @cb
> + *
> + * Holds prog->aux->used_maps_mutex across the walk.
> + *
> + * Return 0 if iteration completed, otherwise the first non-zero @cb return.
> + */
> +int bpf_prog_for_each_used_map(struct bpf_prog *prog,
> +                              int (*cb)(struct bpf_map *map, void *data),
> +                              void *data)
> +{
> +       struct bpf_prog_aux *aux = prog->aux;
> +       int ret = 0;
> +       u32 i;
> +
> +       mutex_lock(&aux->used_maps_mutex);
> +       for (i = 0; i < aux->used_map_cnt; i++) {
> +               ret = cb(aux->used_maps[i], data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&aux->used_maps_mutex);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(bpf_prog_for_each_used_map);
> +

Since each program only has one arena, and you use this to determine
whether the program's arena has a flag, why not just add a
bpf_prog_arena() accessor and check the result's flag directly? You
can do prog->aux->arena inside it to return the bpf_map pointer.

>  static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
>  {
>         bool select_interpreter = false;
> --
> 2.53.0
>
