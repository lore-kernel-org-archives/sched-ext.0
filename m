Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D51E3762
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091689; cv=none; b=r5eROi6y4+1pz9sX1PMj7UelI6sQjs7kRSXrr/CQtYsq+HKiHL6rj2km+IuG+uw41Meg16B0lOR8scW7bIkI1x9MfM96oUyQ7TuMzpvDZ3cIsT0XZsAHOS63HHYNNn2V1YOlzU/61Sf8z2D5QKMnm9yTaPY0SrDXlS09nxogxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091689; c=relaxed/simple;
	bh=jmXmw5asMTtXGIz/8lcXflbtO8gf8d9v00RouWwfLuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr7gYd4eN/eiGNBrtzhWJ/ULNVFkR82BUTLDmIXHQBp2kqwmXSkSPZ98Ncqj807tSrVlyxyyZPgxjuy+ih+71Yek8D9+kPLSf1jAia87tbh20IgKAnzXzJngcv5qKnILxjXgqrtS8qoLJuU7h5ydNnHb7gFj02B21q5tHTc92ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwQ3Ew3f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwQ3Ew3f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0eaf55d58so13447705ad.1
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091687; x=1766696487; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+k0sBo8kGqSqYtBtyPmz0oTC29vtNufjE0L64aGxAA=;
        b=iwQ3Ew3fmMsvpzLExpGLwfEt8CfcGjINaspnGXxpNRVldVKvQvmlraJoaT1p3caEZX
         rWTvi40548V6VF/1htCHi9PCrgOILvWzG5csGcHB7N3Ba5QQJP3aTscSgxsF6IwHepWT
         0O8QZiL/Ebdwy1Z5mOcSgCFGxYAiFO/q7IVjMwKuWXZQ37TpIeNFvKdO8r5hp9DPRAiS
         ncAw3Y36D8w2E+QoI/afrJQiNNWSHpkelwdDl3n6s9OCqoOzpW6+d5H4MeoC+LDASGKi
         Ss35sfKpgc0mQb+PerdrvkysVPdDt955+gvJICCO/vkZE8GjtUqpzdLbFHyoBUuH5Aif
         rsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091687; x=1766696487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s+k0sBo8kGqSqYtBtyPmz0oTC29vtNufjE0L64aGxAA=;
        b=fczpolErtVovmCalCCCqs1Ui36aquCYAdJ8gSIA2fLrJxC+wxDAwsr98V4RdndU/gs
         YtOj5H2Y9FT/ML5ULcBCG7K67ayBq06RtLyJ6l631pxBgaE2lQUv5r4tmIHoOIAFpr14
         ziiZw7zCCX+Bvb3wIVOUd+9vkDM6RVE9zz3YYW5IIxlAEn+OV9N32JIo1hxpge/syw0y
         aLAOquwOJsm3oQELFs5LNsLOqRdj0yivqL47AmR+HGqNcHkwk8C6/srgLq99yIqRLC0t
         bKyF+EqLCQbHMaQI83uFAgDHo1pmnrgROKLKx8CB19+MdLydG8GQw4dn2nxEoRkzch4l
         rjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmErOpkuQ5FnOIbst3Ou8TK4QpYNd9P6gbfqdSL2XBt4irYhgKeE4T1AOTRYemUf4tohr/h2avM6Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YyGd+0GfOKLYD4hWgBClpQGkC9G9eQiC/+vZepK9mBdaxP5AbkW
	DfzjJjtHhTMV9oyA1JVuap2MIRGjBTcG76p7EoGDbU3uC/CYLvW97aqcCGxB0LXhFB+j97IbmM4
	c1OXipjYzHv4CredMoQ1FWcW1CgLkAoE=
X-Gm-Gg: AY/fxX7IBxfddfDFmF5P46GTLrmI5N5XPI8c6hqFBPtmbjXf2v9W9phO+okTZZcSRoT
	fh6jW89e9cvlNkt8Q+knHDAVrc7/Fv+QbeYw8IkYJ7wLMZKdIYhX3VDG8ukr4tuM4pweGYrezRi
	p9ISjfmhSTWty91T6DrVawFyG8OhoBQO1+FrJg0wA7XpVN07wivb3Cfn7MX8hzwcRVnAJh6f/yo
	kUEtxB0EJiLAHIM9c/LV9AK3TcIj+iIU80M4LWS7CZVEPvf9wEJN8wh8JAFwsNBG7ZGfg0UOEvc
	bsd4UR/931k=
X-Google-Smtp-Source: AGHT+IFvxO++u168y/ZQIZTL6aX57IK2pSm13Cv1wVzQ3aSOnLQnrHhkdej5Dd5WyhHBMHif+7aTekMWxA8bTfSxggY=
X-Received: by 2002:a17:903:1b06:b0:2a1:3ad6:fab3 with SMTP id
 d9443c01a7336-2a2caa9cd35mr39266795ad.1.1766091687269; Thu, 18 Dec 2025
 13:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218003314.260269-1-ihor.solodrai@linux.dev> <20251218003314.260269-6-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 13:01:13 -0800
X-Gm-Features: AQt7F2pO_lFPayHYxhN87IzQtBu5GC3SicKONr1cvSuGE1FgcyvrGgbGAfOSm2Q
Message-ID: <CAEf4Bzb9BnSLmHOj=kdgC6is6_ZXHuHw_OyaMO_7xp+eWdtbPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when PAHOLE_VERSION changes
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>, Changwoo Min <changwoo@igalia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Vernet <void@manifault.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 4:34=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> This patch implements kconfig re-sync when the pahole version changes
> between builds, similar to how it happens for compiler version change
> via CC_VERSION_TEXT.
>
> Define PAHOLE_VERSION in the top-level Makefile and export it for
> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> variable.
>
> Kconfig records the PAHOLE_VERSION value in
> include/config/auto.conf.cmd [1].
>
> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> between builds, make detects a dependency change and triggers
> syncconfig to update the kconfig [2].
>
> For external module builds, add a warning message in the prepare
> target, similar to the existing compiler version mismatch warning.
>
> Note that if pahole is not installed or available, PAHOLE_VERSION is
> set to 0 by pahole-version.sh, so the (un)installation of pahole is
> treated as a version change.
>
> See previous discussions for context [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/kconfig/preprocess.c?h=3Dv6.18#n91
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv6.18#n815
> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@orac=
le.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Makefile     | 9 ++++++++-
>  init/Kconfig | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

This is great, we should have done that a long time ago :)

[...]
