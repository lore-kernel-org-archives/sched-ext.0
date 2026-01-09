Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205F35E55E
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988507; cv=none; b=CDIstGwup2I2nQ5/qKa8CbxLL5d9K5ykSdlbVDwS3alsqfSAkwGaAE+i4IVF685NBtR54U1jc57VbHxBkftHx8m4wVKPCCPgsx7MZyEFEmohjKZEiLMzUt14OEW7LxrLxzLXsVDSqTi+OL2OnP8FEP2BqQ2V2BCNC1PQgBNXGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988507; c=relaxed/simple;
	bh=MhElfQne+j9lBSOteOTAImcd5y7CE11SkL50jXSh4kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy5o7t7VCndrqH0yPEgosktmNEleX4mclBq9Y5Fj1FoMyP9ewDDPUUa8HGLJN3cSyCHpI5/PthgkayN+/SUD7gXc5bDIumFF9E70SiUI9gy4RlnTMov/FzUXdUtY15ACMH3kM/S5dKoYNn/nkXBa9cmZgoFrvMHA/8RpTNY+uLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUy4A9Ek; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUy4A9Ek"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2602436f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 09 Jan 2026 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767988504; x=1768593304; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBkPDONatTuGPl5aY/TAYsLDoFrF+bCOUtSOi52c1ug=;
        b=AUy4A9EkelGrmT7Qm5wvEY27Kfnkav1exNsS8bCyaeDbU1ufD9qdBpOQ42AhzNgG52
         0eGfXJge9HYNUwCZtKdEpiQudmcvGQO+Z43nSPRSzpPaVOaWxYFDGuwsAROi1UgLct5e
         zR8OTaWZx/4o6n/IGUDnKJIci/R1pjSnP0MPPBeL925oZ+Fcse6zeekim4sae+VyyEJ2
         9xA+xYO7lWxRYvjgr+N9mVwq+pVF8zX1bIuFIm+Zz3XghGkv6GTk+sRs6vPBS1EbWd+O
         GkhFsq14IRQZGQyLavRWCD5m/qLrR0CaAhzeOO+bUIFvfwfiwghJWfBueEkqxdTQySTO
         JV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767988504; x=1768593304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBkPDONatTuGPl5aY/TAYsLDoFrF+bCOUtSOi52c1ug=;
        b=oHFpfM+W8uONfCHl5PTDOenc+80KbCqGkYonnrFXRGVT2bQW2FkUmZVoZpd3Np+rEL
         moGfDZlWPMV0oUmvcG+35KPV7BCmgApKXWGbq/YdMtUXOREvIK2AQn6LaYOhvGGhAv62
         mn4+YkKY0UKkIqq6xWxyBF5zPo43waogXy6EkverYEK7+XGPx6/4avMEsrMLe04+Kz3B
         pI6hHpmLiQM4SA9cUalGDFpLnDBs+Vxirjkd+NcCfqtd+ZYrRo3Q9pW8L7ZJG48KtyaZ
         pACNejr4S9+Nh8cYQ9l8x1rCaxanNDbniAcReGofCqzk9iZdO1fLvWZWLDwgxg9o4Lm4
         4utw==
X-Forwarded-Encrypted: i=1; AJvYcCXD1CYomXz1Em6QqngjO9aTQCRju5WjT61R38V7BRmztYMYzAVxVEe0qPeswOGs49v+L1TPnMXKIAI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdyMxUIdzxi13qplKOiYfySM5/K+hc5d1/FerIPxEJykaB2egL
	iKigPOjStMSeeF4H8JUSISuoHNY1/GJJPQLVEwMiTRZs3cRSpqgRt1BRlOIoJPe5GCWPvTQP2KZ
	M6EqocZCKfpacYzjw4ouLqYIAccEmMY8=
X-Gm-Gg: AY/fxX7uIx67VmRk/gvRwiQIQtSI6amFK7HCaxsGLt6jixhjeeEucc7yv8skNKb56nM
	yueWKZZeRHGUj3fIqa4h/aPsq2wOWGpcENvcaeoLt3/JcUgLMya2howzDVUxAjdZNVIYbT2hznl
	BOoy70lEDyVZYDKwbb05+xQwxgS+RAPI6H7Q0rCLUKkD71HByr68lvacfklPRepgG+ApQCJeKmW
	QbHKz+8wQEjzJTU/5ilk52HgonYaJRBcDFGlO3nFtdJMrbu/rWNA2PGd4oa5ahVoBQYRJf/+Sx9
	QV2JUIoop8HEKq2qo2eTg+qP3Zdg
X-Google-Smtp-Source: AGHT+IG/EZRLQONxvapFw3RQndcGZicYBoimPYye5AFD2yn9qZIvRV/9nvD07Us9CjbpRX96Rtf3b1sKeTS6kQdLu+M=
X-Received: by 2002:a05:6000:2f81:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-432c377c19emr13483755f8f.14.1767988503788; Fri, 09 Jan 2026
 11:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 11:54:52 -0800
X-Gm-Features: AZwV_QgQhMZNtddtaPEGfXd-u2d00hNwXFesS-EHcJxSG5vDE12dKLQL2hWx4Io
Message-ID: <CAADnVQKAfFe3=1-D9heEsya-v+bX-GnUbaqe_nYf0tkZNde_pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> +       if (unlikely(kfunc_flags && KF_IMPLICIT_ARGS & *kfunc_flags))

Please add extra () around &

that's the style we use elsewhere. Like:
if (!first && (env->log.level & BPF_LOG_LEVEL2))

> +               if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
> +                               && is_kfunc_arg_implicit(desc_btf, &args[=
i])))

same

pw-bot: cr
