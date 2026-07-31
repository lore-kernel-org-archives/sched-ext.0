Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747841B8CE
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494865; cv=none; b=p5xCceKMGxhAyrcLCMdmEz65tnBI8jxGXRitYELN4DiMVEQptlHnmAar2MdBeAI5+Yiq+ddX/6WxXbj5BMh2uSZ5X6hx939OCeIiGhWjoyl65jXXL3VTiV4pH4vu2OSxOCmeC/2z3R3hvCGL8PQL/vMJg1ojFmYlBbMJfjnULwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494865; c=relaxed/simple;
	bh=SbE5NnnjMLf0IRNa4xhJpBlGsSBqzfDSxKCBGWSj43c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ca3+jipnpSFbvHRZWX7MJ+0srqKR4PqVVWHtFpZpQJpHwmRKoSJRUk70M4N8p0vLcvQ1TA0Ab3el/kszgRJzdoBu7c6QGSOYr3zmwojZoWdjd/i+F0xbDxhFEOkULrCzZOnMehmbRWCQfZY7pxUwlz7qKKLFnL19youHP53DoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYP7OLWX; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYP7OLWX"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso667182f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785494852; x=1786099652; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z27h1fQmYFd6D52ydmkBguskAI+LpCRqeYbcaWL+DhA=;
        b=XYP7OLWXv6qxLkzTPpQ3iNGVyGeGBM4ZT5he5bdAwoPH98Ec+qgWM0CXHpNV5Iq/a+
         q3I/xIMPNKzbFaAK+xwkRBCqAV8zQ9QxHErjynbUpbTDQj7PIXDV6sg3zKeXduZ+l9HS
         9RUMg/CNpY8gOfF58T3rEpSM4LcLGJkvY2m8/jzuXrG6lcv230X5FltP66CzKI66BOUQ
         DjlqNilgY67uO6T5JRW2xXmXTyylj7qX2IJE4s0PFSN+Y4v5MiBC+maTurbSJTqr5MDu
         812jUweVawigFgDI8nkcpq7r5nVDL2qY7/yz0HHbS6NEvdwA4sQKMHregruxh/GzyLtm
         yXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494852; x=1786099652;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z27h1fQmYFd6D52ydmkBguskAI+LpCRqeYbcaWL+DhA=;
        b=SEAcVLysYzG4cPdS4/dIm2ZqfG3pq4HjJNCuvC+CI3/7pR1SAzKY1RreOdP059kYYZ
         S5YCEe3MptIyFW3j1ZhmEot+4CZwO1jawzdJGGzYkp4yk3ufhU7I+Ce+RwbY92oSvHFh
         l1G5OfT4Pepb1N68J8CPbdWgBpLN9FZPaXMSyWwwFfrHYCFlQFr9f2Rhb5iR2uYcR32p
         vkxGPX9iWB8FmuyBMsjLI+WprEMkLDIa9zg+spQWPq860mOa0LNSPpxKoo0o/CH/HP1a
         ofcp+3bDELAO1bcnPeDfYDH4vwTO4LnAT1xJ9zPseX7OWvZTXHU/hwcOCKrr33mMcorC
         i8iw==
X-Forwarded-Encrypted: i=1; AHgh+RpVZHzECMt9NHpthPRddLaMW1mzHcJa6zeABLNWOhjQlIfc9ghmhg1CiTBu44go3xcsKZVgWicDfQU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxisFG7b/4atFr6jlqjed5DArZj4fwf+l0VrUyNbjamv2QQ/R6Q
	ULfedCm9kiO0U2P3vtUsCJi4fdyjQswkw4K/ZMiIc/rhfz1g8kUrwkS3C9uPpSNHhcT2Erw+pip
	5q02OnognRPsqBg==
X-Received: from wmox20.prod.google.com ([2002:a05:600c:1794:b0:495:5204:e932])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1865:b0:47f:9752:3277 with SMTP id ffacd0b85a97d-47fd2ab79c7mr3560893f8f.2.1785494851752;
 Fri, 31 Jul 2026 03:47:31 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:47:30 +0000
In-Reply-To: <20260731090334.2911948-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260731090334.2911948-1-arighi@nvidia.com> <20260731090334.2911948-2-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DKCP3MW35928.SLEV2IOR4IJL@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Initialize idle masks before ops.init()
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Fri Jul 31, 2026 at 8:59 AM UTC, Andrea Righi wrote:
> @@ -59,11 +59,13 @@ static inline void init_sched_ext_class(void) {}
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
>  
>  #ifdef CONFIG_SCHED_CLASS_EXT
> +DECLARE_STATIC_KEY_FALSE(scx_idle_tracking_enabled);
> +

I was originally thinking about reusing scx_builtin_idle_enabled here,
apologies if I wasn't clear enough.

My reasoning is: If the user is doing their own idle CPU tracking,
in which case scx_builtin_idle_enable will be disabled, what's the point
of SCX tracking idle CPUs?

Do you see a scenario where using one static branch is problematic?

Thanks,
Kuba
