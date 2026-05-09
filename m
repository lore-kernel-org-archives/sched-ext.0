Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4D1E9B37
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337465; cv=none; b=XRlRHGG3sSl4tPHb6TnnUZ0hmDSvokJ3XtTaKJd5NoBgtfOwHNb0/CVyM+fZYyT6+JxNE2gK5my9aXz+LwurPKl05XU8GOQeEJHp2w1toiwjl9wBzFWTBoap8BRp3Z/zMwul0rVyIuyecy029TdtnXrB1+uwD4Yxzzzi/YiNW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337465; c=relaxed/simple;
	bh=UojDEiS+a7ahpuK82RudsaPwn4v3xANM0iS4jcGkw88=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E0PskJzWaL2/TWJKKrrKKG7Xx30lja2s02qplXMCSEEcyR/DmNTc0E/RUZdSVm86GepSTtfks3pYmOTxgrBq9E9eApQudCwlDWbj7ESFJhVZV8zRNYM/Cw8QwAoJP0Wvbt+0KN/4SBPVU/MSy//51coG58jJDKRhyHSCX/OUU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QndpsViL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QndpsViL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so16601735e9.1
        for <sched-ext@lists.linux.dev>; Sat, 09 May 2026 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778337462; x=1778942262; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOcGfIOtFOkiWqfncI0KZjtYci+VZ44xdjbjhNWu6Xc=;
        b=QndpsViL0D8HFe5rIWUcj86/1Cx1XADM35FQo/BJgFSiCBrhuRG+Le5WTJN0rjAcxq
         8bkSzUZRgdmYMfFazjQ5b1gQVQIYzkGcNzxG9bFOka0M17YkHDjbFs6jY8DHFcNFx7gQ
         HnB2ChHdf99Kv51thYHHmJSPB2iE5LNZpnZWUocxc/OCO4sk/Pv9U3eKwa/eznL+JC/i
         oKdBA29zqLjsMi0+s89hAm7nUI/bBsHVPVVXB22RI96Wvb91WYPDrdggBQ3kEDzM2N1B
         k4ZUeGUsB86RW4EQVZsbZ/EAPjICHqyDDnw2HAvLEeTwhaiAUk5eF0ppQ6o5dkJyagfy
         vi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778337462; x=1778942262;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOcGfIOtFOkiWqfncI0KZjtYci+VZ44xdjbjhNWu6Xc=;
        b=rjmpSI9bq5jN/loGTZd/u/inW+bTWX99mmbbA8x4cQNrWkxfhE9kvS4b92M5vPYtdB
         YVcYGaGiztI+9VoMfuE2KoZJP01sO4pqCrp8/565UBTj3MQBxGKDNPImgNJ4gwDuLuPv
         ZNP4eRFmAOQg1Xkm4DkytoKyVaJfbb+natX0hLfkpQ8ZPv719VY32+X1xZJ3C/5PU5f9
         dD8VYN9X62lVuE3IThGnwQasPHjMFa1cgJ3Ce9EkCFcKZ9ueEr0GZSQKb8MnI6LN5U60
         Gvuj75jQ6mv6BcNftVC3vi0OKc6egJ1+DyX7htRsA7Z8Y08XeSpMfr61lUrk6DdQmTjn
         LB5A==
X-Forwarded-Encrypted: i=1; AFNElJ8jjWyYDHCnGL0t83RyhHlnSS7jiDo18q+aBTDeOYkE1ug1rwKcmNMop3UL2nH6vi5uC9z2RI8SnZ8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzN9vXSIbediaZNUQ0BCkqs6NHUCJm6hqoRUb2JNHU7fITyUL4w
	doiyBeU6uV/h6NnNHRA1LBSr11bma65GCbbTHDAC/y0sSP+QT6DiQtYeFN3Uk3WdlJpFGHCpqRx
	bcg+X3Yw=
X-Gm-Gg: Acq92OEHQ8c9SkEjopPrkcKAJx4HdL3spz6L6uZ+jBaT9/NIb2Hud+KX7phhjhExm1X
	KccDoGG3yG8H/I/fEmErDvfgKqDdLbZ/OBK+EqXbjTJ1pptnM8tIO5VvGw6PkHPANrhfmVKYoVH
	K+vJ1G/LF+6lqscFrEpZ5dUXUJaEwbpaG9s24lTZOJoKbyKrEGNzsmKsis86FiDXFKTSjZWmKBS
	eRLNy9E3aBwSobBzW6/Uqbam+G2nkVrcXNjbtRDVS0qNfzycHnoWOcNa25Ys685JT5+tPuttV4I
	IFOLaiYJKBbDhqntk2w3Aj3yvxDhJzQ4M82vhT8uKUbjJgBvxbqCL/oW/ddRP84Ld+cv8PT2lH5
	zqFLAuRbfIcH+viZAiO9Zf1g/BD+y5U5/PjWP2DMmYXouzbnZoYUx/aaXvCzIYMsPygeFtpOwot
	0uzJoqY0Txk0gL0eTn1syzig0f7ChGdGsHQAL7tEsTsAtvMgdHlJhpMcM=
X-Received: by 2002:a05:600c:4a25:b0:48a:768b:eea9 with SMTP id 5b1f17b1804b1-48e51e09797mr153144355e9.4.1778337461682;
        Sat, 09 May 2026 07:37:41 -0700 (PDT)
Received: from localhost (ppp-94-65-157-136.home.otenet.gr. [94.65.157.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm23237805e9.29.2026.05.09.07.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 07:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 May 2026 10:37:39 -0400
Message-Id: <DIE80MHCA7U0.372V2BPKCAQH9@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Fix ops_cid layout assert
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <sched-ext@lists.linux.dev>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260508235946.215232-1-tj@kernel.org>
In-Reply-To: <20260508235946.215232-1-tj@kernel.org>

On Fri May 8, 2026 at 7:59 PM EDT, Tejun Heo wrote:
> ca1d48a86fab ("sched_ext: Use offsetofend on both sides of the ops_cid
> layout assert") replaced sizeof() with offsetofend() to dodge 32-bit
> PPC trailing padding, but the resulting check is tautological: with
> CID_OFFSET_MATCH(priv, priv) already enforcing offsetof(priv) equality
> and @priv being the same type in both structs, the two offsetofends
> are equal by construction. The original protection - catching a stray
> field added past @priv in sched_ext_ops_cid - is gone.
>
> Anchor on a zero-size __end[] marker appended after @priv. Its offset
> sits flush after @priv regardless of trailing struct padding; if a
> field is inserted past @priv, __end shifts and the assert fires.
>
> Closes: https://lore.kernel.org/all/20260508215211.0C03AC2BCB0@smtp.kerne=
l.org/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c          | 6 ++----
>  kernel/sched/ext_internal.h | 3 +++
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f86ee15be7cb..b685f45b4fd0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -10380,11 +10380,9 @@ static int __init scx_init(void)
>  	/*
>  	 * cid-form must end exactly at @priv - validate_ops() skips
>  	 * cpu_acquire/cpu_release for cid-form because reading those fields
> -	 * past the BPF allocation would be UB. offsetofend() on both sides
> -	 * instead of sizeof() on sched_ext_ops_cid to sidestep trailing
> -	 * struct padding (e.g. 32-bit PPC tail-pads ops_cid past @priv).
> +	 * past the BPF allocation would be UB.
>  	 */
> -	BUILD_BUG_ON(offsetofend(struct sched_ext_ops_cid, priv) !=3D
> +	BUILD_BUG_ON(offsetof(struct sched_ext_ops_cid, __end) !=3D
>  		     offsetofend(struct sched_ext_ops, priv));
>  #undef CID_OFFSET_MATCH
> =20
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 0ed79bd891c7..cd33984cffcf 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -938,6 +938,9 @@ struct sched_ext_ops_cid {
> =20
>  	/* internal use only, must be NULL */
>  	void __rcu *priv;
> +
> +	/* layout end anchor for the BUILD_BUG_ON in scx_init(); keep last */
> +	char __end[0];
>  };
> =20
>  enum scx_opi {

