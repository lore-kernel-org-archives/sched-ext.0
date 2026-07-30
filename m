Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AD423768
	for <sched-ext@lists.linux.dev>; Thu, 30 Jul 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413958; cv=none; b=nWZDyzeh3ymdno619o0Ij3SI086iBHGkexGIRJxrY5hGPbY/DzXW2BaZZuyiAV9PoKux8m274jihKstR+XEyg8fc5iYC0jyqlrnD+uGHIT2xBZfDqfrb+HLG2I/1fowxe8q71DnbHvHJDD7vk445ekn5Y0vwZvjkuLNvt37NnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413958; c=relaxed/simple;
	bh=ChwpBgvydSRCyl30CYsOXGRWljoGGY9h81QLREQDLPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2et1Bk2ksahCNLOiRmbEDLnJOyQg3PMmlOYB3iSYvM8/DVWdrgEpgqVj/VdvPj2k7Vh7mkzQYawXC8RasQFZfHDLLL6TqIAdaAOI2yDhpY0dvVgymc/R0N8b5O5eVfWERaFS5lqWUzuDEtsXgqlLX0jRYq8OHwC4oZolf2egI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=R40f0lYO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="R40f0lYO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4956869750eso13859745e9.2
        for <sched-ext@lists.linux.dev>; Thu, 30 Jul 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1785413954; x=1786018754; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aGfVWtxrVG8Gs+fqhc2m5PVIKlSxiEIBozWBl1vrMD4=;
        b=R40f0lYOsN21BdrRwKSjqfJnapt0+pZgbYSXMZ9NuOoFWa5ItjscHYOuxOEdSNR/wE
         O69OLbCDk2hgAHFZlSA96ZOCvjPTIx+3EH9Lxb9J49uxXX2GzMgxsb7Q8TaKsKVDWgdp
         VjTYMqN+PUYdJcdPVOZIP8iHD8qvS0yQlTy5daEPhGrbKHMtxE63JaMZzli88wJizEqJ
         lNP3ZPXNRUjPfyILUWtBNB1BUK5ACoSJtOdN8AYf21d55jehVAykXt+sWQ9LHsx9zISv
         o+fiARy4t3P36z5SQz86FSzYlDkuAh6NQvssfwfIs5naZA+csxK+XljpNpGnAFEnk33J
         jxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413954; x=1786018754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGfVWtxrVG8Gs+fqhc2m5PVIKlSxiEIBozWBl1vrMD4=;
        b=cht/DgNVkjZFYbDR4x9pqanc+4tRF1kGJcdRMWf0JCTZL4N5k+nh+7Tj0PUR+8QHO3
         sW7pEOZ65vkSiEYJ/H6b0Kzzc8BsY2o/EMda4AS6w5QXhGjsz/qpiIj5XLAmZ8eSqR1c
         iy7g05Mcpela/0IpdxjVuIdiI/h+c9e/sz/24+uWqb+5wEqgNEbLgWwjIVTe+Klhbe1S
         vXJ2LR5Lgse5Et9pL+d6283yrQAXlCEONVkUs7ATL4TZg3UeuAy8tBGh7FVvLb5BG/kT
         Gz2+5aEEnLt6MGNFcLBIyWtvvGE1Zx6OqSXVURc1n/rtkyFKzbNVV3e8r+2MNVmf7LSv
         IgaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjtvV8B7Ylzqb40UlmDkQq08NCdVpFghzEshqYMkxW2ClEsbWJkCFmiOe+2os4PoIXL38Zr6z+CWA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwRUZ3YJIpwNBOjYnBt5f1PeoJpMdWCMWA/fCbSWls8BtQxPwNQ
	95Hu11CIr9aGTpGQlFOZ/A4uHmUnl0gHGZNB+2yeU9n4Tpi1EoL0zFpli+mPVp4I0eo=
X-Gm-Gg: AR+sD12TKkzDiE4xL0d5CmXF3j+7WTk7QwmP/PXtYFUCkBAJWru+rpAfgfkqW60Ynp3
	jdKeeAGIiR6pdYrxn+FvmQ1CLqlUjHSDPOGPtSP21WFp+uz7xYKFJcBMn7Py6sQCRkjG27h5sQx
	aKqk0829o2XAfha1tIiXP75YuSbwvJQkbfUOqT3qnB+MeoJh2c+4sQaz6fDwIIEqWxMJwNWxlDE
	Qb9XYVzFt3OTYKfmao6yw/qY5gva0LvaUVTonD7hL1xL+j813tc7ekNz4fw3q4KF9QZd8FfBXJa
	PiB5If44EJDW5+wFzgx0Ud17lXqMmH4BtLwOKBjVAVDsNsoKZMZcosYGbfc/SWA735CgjKL/MvE
	f5391V3xN/+F70SqTvmTJISFmnP6vJyU5gPrjKB8FczwASjUWP32Y3KoN+ABxIk+Ccb06oZEWoc
	xI1+n+uaaQ/+cbILHDscE5QdQlN2kThlab1vnXOtt90SkeD7A=
X-Received: by 2002:a05:600c:e548:20b0:495:6022:5a14 with SMTP id 5b1f17b1804b1-49800eb98b3mr22025465e9.34.1785413953494;
        Thu, 30 Jul 2026 05:19:13 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:ebe::178:11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aae15sm58243785e9.13.2026.07.30.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:19:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:19:11 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <amtBE9JlGBPwsIuU@matt-Precision-5490>
References: <20260713101245.3207634-1-matt@readmodwrite.com>
 <amiGJWJ-tzUMYizu@matt-Precision-5490>
 <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>

On Tue, Jul 28, 2026 at 11:44:04AM -0700, Paul E. McKenney wrote:
> 
> Apologies for the delay!!!
 
No worries :)

> Alternatively, please do feel free to hold off until we get the public
> posting of the call_rcu() and call_srcu() deferral patch series.
> It will likely provide a helper function that you can use.  To your
> credit, your initial definition of the irqsoff local variable within
> call_rcu_tasks_generic() is what we seem to be settling on.  It should
> also clarify what needs to happen when a CPU goes offline with deferred
> callbacks.

Sure, I saw the patch series and will piggyback on top of it.

Thanks,
Matt
