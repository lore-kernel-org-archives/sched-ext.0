Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB881DED57
	for <sched-ext@lists.linux.dev>; Sun, 28 Dec 2025 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766887379; cv=none; b=dcr6FwaSaamt+i1quXG4+kzT7aXNOSIkIPNRYvw/xk4BSfys3Eaqo4U5VRDsfYQm1BGIkI81B6/wF+QByRvLYAuRYxoFHrG8UyOfog5TElIlVy+qDZUuOmeiaZ0ravnCUNiqeViui2vqYZUnIekgxCtUsl+s1MkAu4DdT+CSe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766887379; c=relaxed/simple;
	bh=9uI7qb9GF/HhSNAL8u0Z2ot1Bw+SYk4YvxF71UxoXsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jOM/il7FNquQomxB3YEFvfrLSYw5yI+2XD3dwksQ+xJ4aW6H4GU4KMSCVvJ70lXK+UABVjnyNXnh60Yb0mj0sg4manamcYPAv6QQswGqHiCluNAnBjG8WGmjlNDoZXGopv6kdkgDUsakJ8EM2dRQJgGs+MnjWHZLb0ke/0GjjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=pc5KHPFh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="pc5KHPFh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda6c385c0so63005211cf.3
        for <sched-ext@lists.linux.dev>; Sat, 27 Dec 2025 18:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1766887376; x=1767492176; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7esDURr1zV7cHVjufQT5umZhqS6ZyNH4DqU3znCP18=;
        b=pc5KHPFh1oVVTY9WXGgXC424wAN+eRdpbS1nMFZ640jBHFMgikR1rDDQcSHsRMWnYI
         k7QY5TKyUBxND8MYtas8VYsPzr05u1c/keDRb/MR5PDvdGBGHhCn6+lc9YIznVeGHbW1
         5UAZK3ai+fotWysGCYcrTXVvyQhfX10ROCDi62AgLFQlTExqof5MXSDTeC+mVtdBMFu/
         /Amtg6kgSelp47WoIU6pV3CQu2gOKIpIuuF270tP0ZACK6iUmGbwAv0ZFO9ouv+woTfx
         hbEPo2xFjo5ABOD6ViLC0uTQAu8DV8LwFU8FiD05lEL8Mtxq3wbkfCgj5c5L4RuatYMU
         8fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766887376; x=1767492176;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7esDURr1zV7cHVjufQT5umZhqS6ZyNH4DqU3znCP18=;
        b=UN33O0B5asbStKTdUhhfNYk+gtaapEwAoigISUoxdCPYc8QM/LfDihg1yQFeDZ9UD0
         Ga2LcJzzdrFyE8JFM+PGmKdD37vnL8RNtwMeiTQo0B9IQEl+S4er9HP0pQkZm35r5a/b
         y6e7OlXs5HR0+LUiMcqJBSXszXmEMMbQaswQ85px6OjX+ZD9aHMtH5bmc31lPeRQ1Vb2
         qJ89vlVgNoM4bCLOmIh/cnEUlVROTNzJdoIE9DoNKjItSHnjrWihTrA7bDVVQmBarSL6
         LK8q3ewsvWpmh4r29EbZLczvYXYhdSxqbuZ9gP/55BntkJ4rrWBgf6ACH7LfEZ4YIC54
         2vPA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHbT9y7ecxzqJwFFSWTSiGqSx8SxCSslZhp16LOp6y5/0IhqoI44N+ECqTwSbRMM1EmroAC+BoVE=@lists.linux.dev
X-Gm-Message-State: AOJu0YyjRFHPM+Xmi5VocgoWADNOLBGCJ7jzRUimsT7DGVnHagUPX9dr
	FkaCqJmL2B9j8TqIgOAD6h7MwmyEhHvDiNHlzFIKhn0TsvMPvVHkFbszWTKEPWjpmRE=
X-Gm-Gg: AY/fxX5tP2OQOfJUqgX98HKRP6bD/q84MA/RwFxf2zYF221On04aJfiMlpwSuwRShhn
	twzy0QhFIIcEIQVJEj1pGKyJqMnFtyQgaPeo8tLvpvYlho4hKYhZXE+PwbrsWiQiJH5lwd/OPqB
	DDeoiHPo5vk2h4x5zxlx/PAeb8PpB2Hj/ZTufp5dj17q8rHkorsWeFs0eviys+hyqIYroLdEQN5
	fe3M/JsIVYIsyVxHnj6bCxdqMl4gCVykmti/NjH+8Ssz9jFnAnsKg59ROEUiUF5ylYYLaBA+He6
	qH+1y7wp5228M5B9EiualzPbtqAPgVpmGR57Vc12ilx0DWu9JM6cUb4Xzww0UNhRK7ozjV0y5ht
	yMbsY6gTX796bAKxucbyOjDfocWxrqZyeuExhViYSkxV8c7sQmC8gPl5K93Odu/IVW9YZpPSTDn
	LDqkU+GXj4V0TioxwQDTmTsg==
X-Google-Smtp-Source: AGHT+IGlBkiJgryHpBpt83RHqxAvFwdGCSXUUnS8nN8SSXFXfanNaPYJvXO3bZmd9fmdqQkOaNwyKA==
X-Received: by 2002:ac8:5745:0:b0:4ed:b363:2c2 with SMTP id d75a77b69052e-4f4abdba542mr419754231cf.62.1766887376119;
        Sat, 27 Dec 2025 18:02:56 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4b1302d44sm202504531cf.29.2025.12.27.18.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 18:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 21:02:54 -0500
Message-Id: <DF9HAUDQI1QN.2WM04EUYW03VU@etsalapatis.com>
Subject: Re: [PATCH v1 2/2] tools/sched_ext: update scx_show_state.py for
 scx_aborting change
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kohei Enju" <enjuk@amazon.com>, <sched-ext@lists.linux.dev>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Dan Schatzberg" <schatzberg.dan@gmail.com>, <kohei@enjuk.jp>
X-Mailer: aerc 0.20.1
References: <20251226084657.75567-1-enjuk@amazon.com>
 <20251226084657.75567-3-enjuk@amazon.com>
In-Reply-To: <20251226084657.75567-3-enjuk@amazon.com>

On Fri Dec 26, 2025 at 3:46 AM EST, Kohei Enju wrote:
> Commit a69040ed57f5 ("sched_ext: Simplify breather mechanism with
> scx_aborting flag") removed scx_in_softlockup and scx_breather_depth,
> replacing them with scx_aborting.
>
> Update the script accordingly.
>
> Fixes: a69040ed57f5 ("sched_ext: Simplify breather mechanism with scx_abo=
rting flag")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/sched_ext/scx_show_state.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show=
_state.py
> index aec4a4498140..02e43c184d43 100644
> --- a/tools/sched_ext/scx_show_state.py
> +++ b/tools/sched_ext/scx_show_state.py
> @@ -38,8 +38,7 @@ print(f'enabled       : {read_static_key("__scx_enabled=
")}')
>  print(f'switching_all : {read_int("scx_switching_all")}')
>  print(f'switched_all  : {read_static_key("__scx_switched_all")}')
>  print(f'enable_state  : {state_str(enable_state)} ({enable_state})')
> -print(f'in_softlockup : {prog["scx_in_softlockup"].value_()}')
> -print(f'breather_depth: {read_atomic("scx_breather_depth")}')
> +print(f'aborting      : {prog["scx_aborting"].value_()}')
>  print(f'bypass_depth  : {prog["scx_bypass_depth"].value_()}')
>  print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
>  print(f'enable_seq    : {read_atomic("scx_enable_seq")}')

